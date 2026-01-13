# Structure Visuelle du Projet - Avant/Après

## 📊 Structure ACTUELLE (Problématique)

```
BRIEF_TERRAFORM/
│
├── __MACOSX/                          ❌ Fichiers système macOS
│   └── sensor_data/
│
├── IaC-Provisionning(Terraform)/      ⚠️  Caractères spéciaux
│   ├── Intro Cloud.pdf
│   └── Intro Terraform.pdf
│
├── sensor_data/                        ⚠️  Données à la racine
│   ├── sensor_data_04.json
│   ├── sensor_data_05.json
│   └── ... (100+ fichiers)
│
└── smarttech-streaming/
    ├── __MACOSX/                      ❌ Fichiers système
    │   └── smarttech-streaming/
    │
    └── smarttech-streaming/           ❌ Structure imbriquée redondante
        ├── checkpoints/               ⚠️  Devrait être dans data/
        ├── delta/                     ⚠️  Devrait être dans data/
        ├── input/                     ⚠️  Devrait être dans data/
        ├── docker-compose.yml
        ├── main.py
        ├── pyproject.toml
        ├── README.md
        ├── uv.lock
        │
        ├── scripts/                   ⚠️  Devrait être dans src/
        │   ├── producer_kafka.py
        │   ├── stream_files_to_delta_bronze.py
        │   └── stream_kafka_to_delta_silver.py
        │
        └── veille/                    ⚠️  Mélange notebooks et données
            ├── 1.1-Veille-StructuredStreaming.ipynb
            ├── 1.2-Veille-Time-Windows.ipynb
            ├── activity-data/         ⚠️  80 fichiers JSON
            └── stream_events/         ⚠️  943 fichiers JSON
```

### 🔴 Problèmes Identifiés:
1. ❌ Structure imbriquée `smarttech-streaming/smarttech-streaming/`
2. ❌ Fichiers système `__MACOSX/` versionnés
3. ❌ Données dispersées (3 emplacements différents)
4. ❌ Pas de structure Python standard
5. ❌ Mélange de code, données et notebooks
6. ❌ Nom de dossier avec caractères spéciaux
7. ❌ Pas de séparation claire des responsabilités

---

## ✅ Structure OPTIMISÉE (Recommandée)

```
BRIEF_TERRAFORM/
│
├── .gitignore                         ✅ Fichiers à ignorer
├── README.md                          ✅ Documentation principale
├── roadmap.md                         ✅ Roadmap du projet
│
├── docs/                              ✅ Documentation centralisée
│   ├── terraform/
│   │   ├── Intro Cloud.pdf
│   │   └── Intro Terraform.pdf
│   └── streaming/
│       └── (documentation streaming)
│
├── infrastructure/                    ✅ Infrastructure as Code
│   └── terraform/
│       ├── main.tf
│       ├── variables.tf
│       └── ...
│
├── smarttech-streaming/               ✅ Projet principal
│   ├── .gitignore                     ✅ Gitignore spécifique
│   ├── README.md                      ✅ Documentation projet
│   ├── pyproject.toml                 ✅ Configuration Python
│   ├── uv.lock                        ✅ Lock file
│   ├── docker-compose.yml             ✅ Services Docker
│   │
│   ├── src/                           ✅ Code source organisé
│   │   ├── __init__.py
│   │   ├── main.py                    ✅ Point d'entrée
│   │   │
│   │   ├── producers/                 ✅ Producteurs de données
│   │   │   ├── __init__.py
│   │   │   └── kafka_producer.py
│   │   │
│   │   ├── streams/                   ✅ Scripts de streaming
│   │   │   ├── __init__.py
│   │   │   ├── bronze_stream.py
│   │   │   └── silver_stream.py
│   │   │
│   │   └── utils/                     ✅ Utilitaires réutilisables
│   │       ├── __init__.py
│   │       ├── spark_config.py        ✅ Config Spark centralisée
│   │       └── schemas.py             ✅ Schémas de données
│   │
│   ├── notebooks/                     ✅ Notebooks séparés
│   │   ├── 1.1-Veille-StructuredStreaming.ipynb
│   │   └── 1.2-Veille-Time-Windows.ipynb
│   │
│   ├── data/                          ✅ Données organisées
│   │   ├── raw/                       ✅ Données brutes
│   │   │   ├── sensor_data/           ✅ (100+ fichiers JSON)
│   │   │   ├── activity-data/         ✅ (80 fichiers JSON)
│   │   │   └── stream_events/         ✅ (943 fichiers JSON)
│   │   │
│   │   ├── input/                     ✅ Dossier d'entrée streaming
│   │   │
│   │   ├── delta/                     ✅ Tables Delta (gitignored)
│   │   │   ├── bronze_sensors/
│   │   │   └── silver_sensors/
│   │   │
│   │   └── checkpoints/               ✅ Checkpoints Spark (gitignored)
│   │       ├── bronze_sensors/
│   │       └── silver_sensors/
│   │
│   ├── tests/                         ✅ Tests organisés
│   │   ├── __init__.py
│   │   ├── test_producers.py
│   │   └── test_streams.py
│   │
│   └── config/                        ✅ Configuration
│       ├── spark.conf
│       └── kafka.conf
│
└── scripts/                           ✅ Scripts utilitaires
    └── migrate_structure.ps1          ✅ Script de migration
```

### ✅ Avantages de la Structure Optimisée:

1. **Séparation claire des responsabilités**
   - Documentation → `docs/`
   - Infrastructure → `infrastructure/`
   - Code → `src/`
   - Données → `data/`
   - Notebooks → `notebooks/`

2. **Structure Python standard**
   - Modules organisés dans `src/`
   - Tests isolés dans `tests/`
   - Configuration centralisée

3. **Gestion des données optimisée**
   - Données brutes dans `data/raw/`
   - Données traitées dans `data/delta/`
   - Checkpoints dans `data/checkpoints/`
   - Tous ignorés par git (via .gitignore)

4. **Maintenabilité améliorée**
   - Code modulaire et réutilisable
   - Configuration centralisée
   - Documentation organisée

5. **Évolutivité**
   - Facile d'ajouter de nouveaux modules
   - Structure prête pour CI/CD
   - Compatible avec les outils standards

---

## 📈 Comparaison Quantitative

| Métrique | Avant | Après | Amélioration |
|----------|-------|-------|--------------|
| **Niveaux d'imbrication max** | 4 | 3 | ⬇️ 25% |
| **Emplacements de données** | 3 | 1 | ⬇️ 67% |
| **Dossiers système (__MACOSX)** | 2 | 0 | ⬇️ 100% |
| **Structure Python standard** | ❌ | ✅ | ✅ |
| **Séparation code/données** | ❌ | ✅ | ✅ |
| **Modules réutilisables** | 0 | 2+ | ⬆️ ∞ |

---

## 🎯 Mapping des Fichiers (Migration)

| Fichier Actuel | Nouveau Emplacement |
|----------------|---------------------|
| `smarttech-streaming/smarttech-streaming/scripts/producer_kafka.py` | `smarttech-streaming/src/producers/kafka_producer.py` |
| `smarttech-streaming/smarttech-streaming/scripts/stream_files_to_delta_bronze.py` | `smarttech-streaming/src/streams/bronze_stream.py` |
| `smarttech-streaming/smarttech-streaming/scripts/stream_kafka_to_delta_silver.py` | `smarttech-streaming/src/streams/silver_stream.py` |
| `smarttech-streaming/smarttech-streaming/veille/*.ipynb` | `smarttech-streaming/notebooks/*.ipynb` |
| `sensor_data/*.json` | `smarttech-streaming/data/raw/sensor_data/*.json` |
| `smarttech-streaming/smarttech-streaming/veille/activity-data/*.json` | `smarttech-streaming/data/raw/activity-data/*.json` |
| `smarttech-streaming/smarttech-streaming/veille/stream_events/*.json` | `smarttech-streaming/data/raw/stream_events/*.json` |
| `smarttech-streaming/smarttech-streaming/checkpoints/` | `smarttech-streaming/data/checkpoints/` |
| `smarttech-streaming/smarttech-streaming/delta/` | `smarttech-streaming/data/delta/` |
| `smarttech-streaming/smarttech-streaming/input/` | `smarttech-streaming/data/input/` |
| `IaC-Provisionning(Terraform)/*.pdf` | `docs/terraform/*.pdf` |

---

## 🚀 Prochaines Étapes

1. **Lire** `ANALYSE_STRUCTURE_PROJET.md` pour comprendre les problèmes en détail
2. **Consulter** `PLAN_MIGRATION.md` pour le plan d'exécution détaillé
3. **Exécuter** `scripts/migrate_structure.ps1` pour automatiser la migration
4. **Valider** la nouvelle structure et tester les scripts
5. **Mettre à jour** la documentation au fur et à mesure

---

*Document créé pour faciliter la compréhension de la restructuration*

