# Projet BRIEF_TERRAFORM

Projet de streaming de données de capteurs IoT avec Apache Spark, Delta Lake et Kafka.

## 📋 Vue d'ensemble

Ce projet contient:
- **Infrastructure as Code** avec Terraform
- **Application de streaming** SmartTech pour le traitement de données de capteurs en temps réel
- **Documentation** et ressources d'apprentissage

## 🗂️ Structure du Projet

> ⚠️ **Note**: Ce projet est en cours de restructuration pour optimiser son organisation.
> Consultez les documents d'analyse pour plus de détails.

### Structure Actuelle

```
BRIEF_TERRAFORM/
├── docs/                    # Documentation
├── infrastructure/          # Infrastructure as Code (Terraform)
├── smarttech-streaming/     # Application de streaming
├── sensor_data/             # Données de capteurs (à réorganiser)
└── scripts/                 # Scripts utilitaires
```

## 🛠️ IDE et Extensions

Pour une meilleure expérience de développement avec Terraform :

- **VS Code** : Installez l'extension [HashiCorp Terraform](https://marketplace.visualstudio.com/items?itemName=hashicorp.terraform)
- **Configuration** : Le projet inclut déjà `.vscode/settings.json` pour VS Code
- **Documentation complète** : Voir [docs/terraform/IDE_EXTENSIONS.md](./docs/terraform/IDE_EXTENSIONS.md)

### Fonctionnalités IDE

✅ Syntax highlighting
✅ Auto-completion
✅ Format on save
✅ Linting et validation
✅ IntelliSense

---

## 📚 Documentation

### Documents d'Analyse et Migration

1. **[ANALYSE_STRUCTURE_PROJET.md](./ANALYSE_STRUCTURE_PROJET.md)**
   - Analyse détaillée des problèmes de structure actuels
   - Proposition de structure optimisée
   - Avantages et recommandations

2. **[STRUCTURE_VISUELLE.md](./STRUCTURE_VISUELLE.md)**
   - Comparaison visuelle avant/après
   - Mapping des fichiers
   - Métriques d'amélioration

3. **[PLAN_MIGRATION.md](./PLAN_MIGRATION.md)**
   - Plan d'exécution détaillé par phases
   - Checklist de validation
   - Points d'attention

### Migration Automatisée

Un script PowerShell est disponible pour automatiser la migration:

```powershell
# Mode dry-run (simulation)
.\scripts\migrate_structure.ps1 -DryRun

# Exécution réelle
.\scripts\migrate_structure.ps1
```

## 🚀 Démarrage Rapide

### Prérequis

- **Docker** et Docker Compose (pour Terraform et services)
- Python 3.11+ (pour le projet streaming)
- Apache Spark 4.0+
- Delta Lake
- Kafka

### Infrastructure avec Terraform (via Docker)

Terraform est utilisé via Docker - **aucune installation locale nécessaire** !

```powershell
# Initialiser Terraform
.\scripts\terraform.ps1 init

# Générer un plan
.\scripts\terraform.ps1 plan

# Appliquer la configuration
.\scripts\terraform.ps1 apply
```

📚 **Voir la documentation complète**: [infrastructure/terraform/README.md](./infrastructure/terraform/README.md)
📖 **Guide détaillé Docker**: [docs/terraform/GUIDE_DOCKER.md](./docs/terraform/GUIDE_DOCKER.md)

### Application de Streaming

1. **Installer les dépendances Python**:
   ```bash
   cd smarttech-streaming
   uv sync
   ```

2. **Démarrer les services** (Kafka, Zookeeper):
   ```bash
   docker-compose up -d
   ```

3. **Lancer les streams**:
   ```bash
   # Stream Bronze (fichiers -> Delta)
   python src/streams/bronze_stream.py

   # Stream Silver (Kafka -> Delta)
   python src/streams/silver_stream.py
   ```

## 📊 Structure Optimisée (Recommandée)

La structure optimisée suit les meilleures pratiques Python et sépare clairement:
- **Code source** (`src/`) - Modules organisés
- **Données** (`data/`) - Organisées par type (raw, processed, checkpoints)
- **Notebooks** (`notebooks/`) - Séparés du code de production
- **Tests** (`tests/`) - Tests isolés
- **Configuration** (`config/`) - Configuration centralisée

Voir [STRUCTURE_VISUELLE.md](./STRUCTURE_VISUELLE.md) pour plus de détails.

## 🔧 Technologies Utilisées

### Infrastructure
- **Terraform**: Infrastructure as Code (via Docker)
- **Docker**: Conteneurisation et orchestration

### Streaming
- **Apache Spark**: Traitement de données en streaming
- **Delta Lake**: Stockage de données avec transactions ACID
- **Kafka**: Messagerie en streaming
- **Python**: Langage de programmation principal

## 📝 Prochaines Étapes

### Structure du Projet
1. ✅ Analyser la structure actuelle
2. ⏳ Exécuter la migration vers la structure optimisée
3. ⏳ Mettre à jour les chemins dans les scripts
4. ⏳ Créer les modules utilitaires (spark_config, schemas)
5. ⏳ Tester et valider la nouvelle structure

### Infrastructure
1. ✅ Configuration Terraform via Docker
2. ⏳ Configurer les providers (AWS, Azure, etc.)
3. ⏳ Définir les ressources d'infrastructure
4. ⏳ Configurer le backend pour le state
5. ⏳ Documenter les variables et outputs

## 🤝 Contribution

Pour contribuer au projet:
1. Consulter les documents d'analyse
2. Suivre le plan de migration
3. Tester les modifications
4. Mettre à jour la documentation

## 📄 Licence

[À définir]

---

*Dernière mise à jour: Analyse de structure initiale*

