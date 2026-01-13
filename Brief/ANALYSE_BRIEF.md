# 📋 Analyse du Brief - Provisioning Azure avec Terraform

## 🎯 Objectif du Projet

Déployer **3 ressources Azure** via Terraform pour simuler un environnement basique de Data Engineering :
1. **Machine Virtuelle (VM) Linux** - Pour jobs de traitement de données
2. **Azure Storage Account + Blob Container** - Pour stocker des fichiers de données
3. **Web App Azure** - Pour exposer des résultats/services web

---

## 📊 Analyse des Exigences

### Ressources à Créer

#### 1. Machine Virtuelle Linux
- **Spécifications** : Basiques (1 vCPU, 1 Go de RAM)
- **Usage** : Jobs de transformation, tests Apache Spark, outils d'analyse
- **Configuration** : Aucune configuration particulière requise

#### 2. Azure Storage Account + Blob Container
- **Storage Account** : Pour stocker fichiers bruts, résultats d'analyses, backups ML
- **Blob Container** : Pour déposer des objets (CSV, audio, vidéo, etc.)
- **Usage** : Source de données pour ETL, intégration avec Azure Data Factory/Databricks

#### 3. Web App Azure
- **Usage** : Exposer endpoint API, modèles ML, dashboard de visualisation
- **Configuration** : Active mais sans application pour l'instant

---

## 🔧 Contraintes Techniques

### Organisation du Code
- ✅ **Modules Terraform** : Chaque ressource doit être indépendante et gérée via des modules
- ✅ **Variables** : Utiliser `variables.tf` pour paramètres (noms, tailles, etc.)
- ✅ **Coûts** : Ressources basiques et peu coûteuses
- ✅ **Modularité** : Code organisé (main, modules, variables, data sources, outputs)

### Cycle de Vie
- ✅ **Plan** : Doit fonctionner
- ✅ **Apply** : Doit fonctionner
- ✅ **Destroy** : Doit supprimer toutes les ressources sans traces

---

## 📦 Livrables Attendus

### 1. Code Terraform
- Fichiers `.tf` pour les 3 ressources
- **Attention** : Exclure le dossier `.terraform/` du livrable

### 2. Documentation
- Explication des étapes de création
- Procédure de vérification (portail Azure ou CLI)

### 3. Variables
- Fichier(s) `variables.tf` avec tous les paramètres nécessaires

---

## 🎯 Critères de Performance

1. **Code organisé et modularisé**
   - Répartition dans différents fichiers (main, modules, variables, data sources, outputs)

2. **Fonctionnement correct**
   - Plan, Apply, Destroy fonctionnent

3. **Déploiement correct**
   - Toutes les ressources créées selon spécifications

4. **Destruction complète**
   - `terraform destroy` supprime tout sans traces

---

## 📅 Échéance

- **Rendu attendu** : 13/01/26 à 17h00
- **Travail** : Individuel

---

## 🔗 Ressources de Référence

- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Tutorials](https://learn.hashicorp.com/terraform)
- [Terraform Registry](https://registry.terraform.io/)
- [Terraform - create Linux VM](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/linux_virtual_machine)
- [Azure CLI Documentation](https://learn.microsoft.com/en-us/cli/azure/)
- [Azure Storage Account](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)
- [Azure Blob Container](https://learn.microsoft.com/en-us/azure/storage/blobs/storage-blobs-introduction)
- [Azure App Service Terraform](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/app_service)

---

*Analyse créée pour planifier le projet Azure*
