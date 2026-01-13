from pyspark.sql import SparkSession
from delta import configure_spark_with_delta_pip
from pyspark.sql.functions import col, to_timestamp

builder = (
    SparkSession.builder
    .appName("SmartTech-Streaming-Bronze")
    .master("local[*]")
    # Forcer Spark à se binder sur 127.0.0.1
    .config("spark.driver.bindAddress", "127.0.0.1")
    .config("spark.driver.host", "127.0.0.1")
    # Delta
    .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
    .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
)

spark = configure_spark_with_delta_pip(builder).getOrCreate()
spark.sparkContext.setLogLevel("WARN")

# Schéma de nos événements
schema = """
    timestamp string,
    device_id string,
    building string,
    floor int,
    type string,
    value double,
    unit string
"""

# Lecture en streaming des fichiers JSON
raw_df = (
    spark.readStream
    .schema(schema)
    .json("input")   # dossier où tu ajoutes des fichiers au fur et à mesure
)

# Nettoyage / projection
clean_df = (
    raw_df
    .withColumn("event_time", to_timestamp(col("timestamp")))
    .dropna(subset=["event_time", "device_id", "value"])
    .select("event_time", "device_id", "building", "floor", "type", "value", "unit")
)

# Écriture dans Delta Bronze
query = (
    clean_df.writeStream
    .format("delta")
    .outputMode("append")
    .option("checkpointLocation", "checkpoints/bronze_sensors")
    .start("delta/bronze_sensors")
)

print("Streaming Bronze démarré. Ctrl+C pour arrêter.")
query.awaitTermination()
