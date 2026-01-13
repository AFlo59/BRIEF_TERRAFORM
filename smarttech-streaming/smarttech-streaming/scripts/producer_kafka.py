import json
import time
import random
from datetime import datetime, timezone
from kafka import KafkaProducer

producer = KafkaProducer(
    bootstrap_servers="localhost:29092",
    value_serializer=lambda v: json.dumps(v).encode("utf-8")
)

device_ids = ["sensor-temp-001", "sensor-hum-002",
              "sensor-energy-010", "sensor-temp-003",
              "sensor-co2-020"]

types_units = {
    "sensor-temp-001": ("temperature", "°C"),
    "sensor-hum-002": ("humidity", "%"),
    "sensor-energy-010": ("energy_consumption", "kWh"),
    "sensor-temp-003": ("temperature", "°C"),
    "sensor-co2-020": ("co2", "ppm"),
}

buildings = ["A", "B"]
floors = [1, 2, 3]

def generate_event():
    device = random.choice(device_ids)
    sensor_type, unit = types_units[device]
    building = random.choice(buildings)
    floor = random.choice(floors)

    if sensor_type == "temperature":
        value = round(random.uniform(18, 30), 1)
    elif sensor_type == "humidity":
        value = round(random.uniform(30, 60), 1)
    elif sensor_type == "energy_consumption":
        value = round(random.uniform(100, 220), 1)
    elif sensor_type == "co2":
        value = random.randint(400, 1300)
    else:
        value = 0
#.utcnow()
    return {
        "timestamp": datetime.now(timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ"), 
        "device_id": device,
        "building": building,
        "floor": floor,
        "type": sensor_type,
        "value": value,
        "unit": unit
    }

topic = "smarttech-sensors"

print("Envoi de messages dans Kafka. Ctrl+C pour arrêter.")
try:
    while True:
        event = generate_event()
        producer.send(topic, event)
        print("Sent:", event)
        time.sleep(1)   # 1 message par seconde
except KeyboardInterrupt:
    print("Arrêt producteur.")
finally:
    producer.flush()
    producer.close()
