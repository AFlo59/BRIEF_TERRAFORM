# Plan de Migration - Restructuration du Projet

## 🎯 Objectif
Réorganiser le projet selon la structure optimisée définie dans `ANALYSE_STRUCTURE_PROJET.md`.

---

## ⚠️ Prérequis

1. **Sauvegarder le projet actuel**
   ```bash
   # Créer une branche de sauvegarde
   git checkout -b backup-before-restructure
   git add .
   git commit -m "Backup avant restructuration"
   ```

2. **Vérifier les dépendances**
   - S'assurer que tous les scripts fonctionnent avant migration
   - Noter les chemins relatifs utilisés dans le code

---

## 📋 Plan d'Exécution par Phases

### Phase 1: Nettoyage Immédiat ⚡

#### 1.1 Supprimer les fichiers système macOS
```bash
# Supprimer les dossiers __MACOSX
Remove-Item -Recurse -Force "__MACOSX" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "smarttech-streaming\__MACOSX" -ErrorAction SilentlyContinue
```

#### 1.2 Créer la structure de base
```bash
# Créer les nouveaux dossiers
New-Item -ItemType Directory -Force -Path "docs\terraform"
New-Item -ItemType Directory -Force -Path "docs\streaming"
New-Item -ItemType Directory -Force -Path "infrastructure\terraform"
New-Item -ItemType Directory -Force -Path "scripts"
```

#### 1.3 Déplacer la documentation Terraform
```bash
# Déplacer les PDFs
Move-Item "IaC-Provisionning(Terraform)\*.pdf" "docs\terraform\" -Force
# Supprimer l'ancien dossier
Remove-Item -Recurse -Force "IaC-Provisionning(Terraform)"
```

**✅ Checklist Phase 1:**
- [ ] Dossiers __MACOSX supprimés
- [ ] Structure de base créée
- [ ] Documentation Terraform déplacée
- [ ] .gitignore créé et fonctionnel

---

### Phase 2: Réorganisation du Projet Streaming 🚀

#### 2.1 Aplatir la structure imbriquée
```bash
# Se placer dans le dossier smarttech-streaming
cd smarttech-streaming

# Déplacer le contenu du sous-dossier vers le parent
Move-Item "smarttech-streaming\*" "." -Force
# Supprimer le dossier vide
Remove-Item -Recurse -Force "smarttech-streaming"
```

#### 2.2 Créer la nouvelle structure Python
```bash
# Créer les dossiers de la structure optimisée
New-Item -ItemType Directory -Force -Path "src\producers"
New-Item -ItemType Directory -Force -Path "src\streams"
New-Item -ItemType Directory -Force -Path "src\utils"
New-Item -ItemType Directory -Force -Path "notebooks"
New-Item -ItemType Directory -Force -Path "data\raw\sensor_data"
New-Item -ItemType Directory -Force -Path "data\raw\activity-data"
New-Item -ItemType Directory -Force -Path "data\raw\stream_events"
New-Item -ItemType Directory -Force -Path "data\input"
New-Item -ItemType Directory -Force -Path "data\delta"
New-Item -ItemType Directory -Force -Path "data\checkpoints"
New-Item -ItemType Directory -Force -Path "tests"
New-Item -ItemType Directory -Force -Path "config"
```

#### 2.3 Déplacer et réorganiser les fichiers

**Scripts:**
```bash
# Déplacer et renommer les scripts
Move-Item "scripts\producer_kafka.py" "src\producers\kafka_producer.py"
Move-Item "scripts\stream_files_to_delta_bronze.py" "src\streams\bronze_stream.py"
Move-Item "scripts\stream_kafka_to_delta_silver.py" "src\streams\silver_stream.py"
```

**Notebooks:**
```bash
# Déplacer les notebooks
Move-Item "veille\*.ipynb" "notebooks\" -Force
```

**Données:**
```bash
# Déplacer les données de capteurs depuis la racine
Move-Item "..\sensor_data\*.json" "data\raw\sensor_data\" -Force

# Déplacer les données depuis veille
Move-Item "veille\activity-data\*.json" "data\raw\activity-data\" -Force
Move-Item "veille\stream_events\*.json" "data\raw\stream_events\" -Force

# Déplacer le dossier input s'il existe
if (Test-Path "input") {
    Move-Item "input\*" "data\input\" -Force
}
```

**Checkpoints et Delta:**
```bash
# Déplacer les checkpoints et delta existants
if (Test-Path "checkpoints") {
    Move-Item "checkpoints\*" "data\checkpoints\" -Force
}
if (Test-Path "delta") {
    Move-Item "delta\*" "data\delta\" -Force
}
```

#### 2.4 Créer les fichiers __init__.py
```bash
# Créer les fichiers __init__.py pour les modules Python
New-Item -ItemType File -Force -Path "src\__init__.py"
New-Item -ItemType File -Force -Path "src\producers\__init__.py"
New-Item -ItemType File -Force -Path "src\streams\__init__.py"
New-Item -ItemType File -Force -Path "src\utils\__init__.py"
New-Item -ItemType File -Force -Path "tests\__init__.py"
```

#### 2.5 Nettoyer les dossiers vides
```bash
# Supprimer les dossiers vides
Remove-Item -Recurse -Force "veille" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "scripts" -ErrorAction SilentlyContinue
Remove-Item -Recurse -Force "input" -ErrorAction SilentlyContinue
```

**✅ Checklist Phase 2:**
- [ ] Structure imbriquée aplatie
- [ ] Nouvelle structure Python créée
- [ ] Scripts déplacés et renommés
- [ ] Notebooks déplacés
- [ ] Données organisées
- [ ] Fichiers __init__.py créés
- [ ] Dossiers vides supprimés

---

### Phase 3: Refactorisation du Code 🔧

#### 3.1 Créer le module de configuration Spark

**Créer `src/utils/spark_config.py`:**
```python
"""
Configuration Spark réutilisable pour les streams.
"""
import os
from pyspark.sql import SparkSession
from delta import configure_spark_with_delta_pip


def create_spark_session(app_name: str, extra_packages: list = None):
    """
    Crée une session Spark configurée pour Delta Lake.
    
    Args:
        app_name: Nom de l'application Spark
        extra_packages: Liste de packages supplémentaires (ex: Kafka)
    
    Returns:
        SparkSession configurée
    """
    # Nettoyage des variables d'env qui peuvent casser le bind du driver
    for var in ["SPARK_LOCAL_IP", "SPARK_DRIVER_BIND_ADDRESS", "SPARK_DRIVER_HOST"]:
        os.environ.pop(var, None)
    
    builder = (
        SparkSession.builder
        .appName(app_name)
        .master("local[*]")
        .config("spark.driver.bindAddress", "127.0.0.1")
        .config("spark.driver.host", "localhost")
        .config("spark.sql.extensions", "io.delta.sql.DeltaSparkSessionExtension")
        .config("spark.sql.catalog.spark_catalog", "org.apache.spark.sql.delta.catalog.DeltaCatalog")
    )
    
    if extra_packages:
        spark = configure_spark_with_delta_pip(builder, extra_packages=extra_packages).getOrCreate()
    else:
        spark = configure_spark_with_delta_pip(builder).getOrCreate()
    
    spark.sparkContext.setLogLevel("WARN")
    return spark
```

#### 3.2 Créer le module de schémas

**Créer `src/utils/schemas.py`:**
```python
"""
Schémas de données pour les streams.
"""
from pyspark.sql.types import StructType, StructField, StringType, IntegerType, DoubleType


def get_sensor_schema():
    """
    Retourne le schéma pour les données de capteurs.
    
    Returns:
        StructType: Schéma Spark pour les événements de capteurs
    """
    return StructType([
        StructField("timestamp", StringType(), True),
        StructField("device_id", StringType(), True),
        StructField("building", StringType(), True),
        StructField("floor", IntegerType(), True),
        StructField("type", StringType(), True),
        StructField("value", DoubleType(), True),
        StructField("unit", StringType(), True),
    ])


def get_sensor_schema_string():
    """
    Retourne le schéma sous forme de string (pour JSON).
    
    Returns:
        str: Schéma sous forme de string
    """
    return """
        timestamp string,
        device_id string,
        building string,
        floor int,
        type string,
        value double,
        unit string
    """
```

#### 3.3 Mettre à jour les scripts de streaming

**Mettre à jour `src/streams/bronze_stream.py`:**
- Importer depuis `src.utils.spark_config` et `src.utils.schemas`
- Utiliser les chemins relatifs mis à jour (`data/input`, `data/delta`, etc.)

**Mettre à jour `src/streams/silver_stream.py`:**
- Importer depuis `src.utils.spark_config` et `src.utils.schemas`
- Utiliser les chemins relatifs mis à jour

**Mettre à jour `src/producers/kafka_producer.py`:**
- Vérifier les imports et chemins

#### 3.4 Mettre à jour main.py
```python
"""
Point d'entrée principal de l'application SmartTech Streaming.
"""
from src.producers.kafka_producer import generate_event, KafkaProducer
# ... autres imports selon besoins

def main():
    print("SmartTech Streaming Application")
    # Logique principale

if __name__ == "__main__":
    main()
```

**✅ Checklist Phase 3:**
- [ ] Module spark_config.py créé
- [ ] Module schemas.py créé
- [ ] Scripts de streaming mis à jour
- [ ] Scripts de production mis à jour
- [ ] main.py mis à jour
- [ ] Tous les imports fonctionnent

---

### Phase 4: Mise à Jour des Chemins et Configuration 📝

#### 4.1 Mettre à jour les chemins dans les scripts

**Dans `src/streams/bronze_stream.py`:**
- `"input"` → `"data/input"`
- `"checkpoints/bronze_sensors"` → `"data/checkpoints/bronze_sensors"`
- `"delta/bronze_sensors"` → `"data/delta/bronze_sensors"`

**Dans `src/streams/silver_stream.py`:**
- `"checkpoints/silver_sensors"` → `"data/checkpoints/silver_sensors"`
- `"delta/silver_sensors"` → `"data/delta/silver_sensors"`

#### 4.2 Créer un .gitignore spécifique au projet streaming

**Créer `smarttech-streaming/.gitignore`:**
```gitignore
# Spark checkpoints et données Delta
data/checkpoints/
data/delta/
data/input/*.json

# Données brutes volumineuses (optionnel)
data/raw/stream_events/
data/raw/activity-data/

# Python
__pycache__/
*.pyc
.venv/
```

#### 4.3 Mettre à jour docker-compose.yml
Vérifier que les chemins et configurations sont toujours valides.

**✅ Checklist Phase 4:**
- [ ] Tous les chemins mis à jour dans les scripts
- [ ] .gitignore créé pour smarttech-streaming
- [ ] docker-compose.yml vérifié
- [ ] Configuration testée

---

### Phase 5: Tests et Validation ✅

#### 5.1 Tests de base
```bash
# Tester les imports Python
python -c "from src.utils import spark_config, schemas; print('OK')"

# Vérifier la structure
tree /F smarttech-streaming
```

#### 5.2 Tests fonctionnels
1. Tester le producteur Kafka
2. Tester le stream Bronze
3. Tester le stream Silver
4. Vérifier que les données sont bien écrites dans Delta

#### 5.3 Documentation
- Mettre à jour le README.md du projet streaming
- Documenter les nouveaux chemins
- Créer un guide de démarrage rapide

**✅ Checklist Phase 5:**
- [ ] Imports Python fonctionnent
- [ ] Structure validée
- [ ] Tests fonctionnels passés
- [ ] Documentation mise à jour

---

## 🚨 Points d'Attention

1. **Chemins relatifs**: Tous les scripts doivent être exécutés depuis `smarttech-streaming/`
2. **Données existantes**: Les checkpoints et données Delta existants doivent être migrés
3. **Dépendances**: Vérifier que `pyproject.toml` est à jour
4. **Environnement**: S'assurer que l'environnement Python est correctement configuré

---

## 📊 Script de Migration Automatisé

Un script PowerShell complet est disponible dans `scripts/migrate_structure.ps1` pour automatiser cette migration.

---

## ✅ Validation Finale

Après migration, vérifier:

- [ ] Structure de dossiers conforme au plan
- [ ] Tous les fichiers à leur nouvelle place
- [ ] Aucun fichier orphelin
- [ ] .gitignore fonctionne correctement
- [ ] Tests passent
- [ ] Documentation à jour

---

*Plan créé le: $(Get-Date)*
*Dernière mise à jour: Version initiale*

