import os
from pyspark.sql import SparkSession
from delta import configure_spark_with_delta_pip
from pyspark.sql.functions import col, from_json, to_timestamp
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DoubleType

# Netoyage des variables d'env qui peuvent casser le bind du driver
for var in ["SPARK_LOCAL_IP", "SPARK_DRIVER_BIND_ADDRESS", "SPARK_DRIVER_HOST"]:
    os.environ.pop(var, None)

# Packages Kafka pour Spark (adapter la version si ton pyspark n'est pas 3.5.*)
EXTRA_PACKAGES = [
    "org.apache.spark:spark-sql-kafka-0-10_2.13:3.5.2",
]

builder = (
    SparkSession.builder
    .appName("SmartTech-Streaming-Silver")
    .master("local[*]")
    .config("spark.driver.bindAddress", "127.0.0.1")
    .config("spark.driver.host", "localhost")
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
)

# on passe Kafka via extra_packages
spark = configure_spark_with_delta_pip(builder, extra_packages=EXTRA_PACKAGES).getOrCreate()
spark.sparkContext.setLogLevel("WARN")


# Schéma des messages JSON
schema = StructType([
    StructField("timestamp", StringType(), True),
    StructField("device_id", StringType(), True),
    StructField("building", StringType(), True),
    StructField("floor", IntegerType(), True),
    StructField("type", StringType(), True),
    StructField("value", DoubleType(), True),
    StructField("unit", StringType(), True),
])

# 1) Lecture depuis Kafka
kafka_df = (
    spark.readStream
    .format("kafka")
    .option("kafka.bootstrap.servers", "localhost:29092")
    .option("subscribe", "smarttech-sensors")
    .option("startingOffsets", "latest")
    .load()
)

# 2) value (bytes) -> string
value_df = kafka_df.selectExpr("CAST(value AS STRING) as json_str")

# 3) Parsing JSON
parsed_df = value_df.select(from_json(col("json_str"), schema).alias("data")).select("data.*")

# 4) Nettoyage & normalisation
clean_df = (
    parsed_df
    .withColumn("event_time", to_timestamp(col("timestamp")))
    .dropna(subset=["event_time", "device_id", "value"])
    .select("event_time", "device_id", "building", "floor", "type", "value", "unit"
    )
)

# 5) Écriture Delta Silver
query = (
    clean_df.writeStream
    .format("delta")
    .outputMode("append")
    .option("checkpointLocation", "checkpoints/silver_sensors")
    .start("delta/silver_sensors")
)

print("Streaming Silver démarré. Ctrl+C pour arrêter.")
query.awaitTermination()
