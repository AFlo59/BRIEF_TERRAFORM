# 📚 Index des Guides - Où Trouver les Informations

Guide rapide pour trouver les informations dont vous avez besoin.

---

## 🎯 Ce Que Vous Cherchez Probablement

### ⚠️ "Que dois-je faire manuellement ?"

👉 **[CE_QUE_VOUS_DEVEZ_FAIRE.md](./CE_QUE_VOUS_DEVEZ_FAIRE.md)** ⭐

**Contenu** :
- Liste complète des actions manuelles
- 6 étapes à faire vous-même
- Checklist de vérification

---

### 🌐 "Comment utiliser le portail Azure ?"

👉 **[docs/GUIDE_PORTAL_AZURE.md](./docs/GUIDE_PORTAL_AZURE.md)** ⭐

**Contenu** :
- Guide étape par étape du portail Azure
- Comment vérifier chaque ressource
- Où trouver chaque information
- Captures d'écran recommandées
- Tests fonctionnels

**Sections principales** :
1. Accès au portail Azure
2. Vérification du Resource Group
3. Vérification de la VM (avec captures d'écran)
4. Vérification du Storage Account
5. Vérification de la Web App
6. Vérification via Azure CLI

---

### 🔧 "Comment configurer Azure ?"

👉 **[docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md)** ⭐

**Contenu** :
- Créer un compte Azure
- Créer une subscription
- Installer Azure CLI
- Se connecter à Azure
- Générer une clé SSH
- Configurer terraform.tfvars

**Étapes détaillées** :
1. Créer un compte Azure (portail)
2. Créer une subscription (portail)
3. Installer Azure CLI
4. Se connecter (`az login`)
5. Générer clé SSH
6. Configurer variables

---

### 🚀 "Comment déployer ?"

👉 **[docs/DEPLOYMENT.md](./docs/DEPLOYMENT.md)**

**Contenu** :
- Procédure complète de déploiement
- Commandes étape par étape
- `terraform init`, `plan`, `apply`
- Tests fonctionnels
- Destruction

---

### ✅ "Comment vérifier que ça marche ?"

👉 **[docs/VERIFICATION.md](./docs/VERIFICATION.md)**

**Contenu** :
- 3 méthodes de vérification :
  - Via portail Azure
  - Via Azure CLI
  - Via Terraform outputs
- Checklist complète
- Tests fonctionnels

---

## 📋 Guide de Navigation Rapide

### Par Objectif

| Je veux... | Document à consulter |
|------------|---------------------|
| **Savoir ce que je dois faire manuellement** | [CE_QUE_VOUS_DEVEZ_FAIRE.md](./CE_QUE_VOUS_DEVEZ_FAIRE.md) |
| **Configurer Azure pour la première fois** | [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md) |
| **Utiliser le portail Azure étape par étape** | [docs/GUIDE_PORTAL_AZURE.md](./docs/GUIDE_PORTAL_AZURE.md) |
| **Déployer l'infrastructure** | [docs/DEPLOYMENT.md](./docs/DEPLOYMENT.md) |
| **Vérifier les ressources** | [docs/VERIFICATION.md](./docs/VERIFICATION.md) |
| **Comprendre le plan du projet** | [PLAN_PROJET.md](./PLAN_PROJET.md) |
| **Voir la checklist complète** | [CHECKLIST_DETAILLEE.md](./CHECKLIST_DETAILLEE.md) |
| **Commencer rapidement** | [START_HERE.md](./START_HERE.md) |

---

## 🗺️ Parcours Recommandé

### Si vous commencez maintenant :

1. **Lire** [CE_QUE_VOUS_DEVEZ_FAIRE.md](./CE_QUE_VOUS_DEVEZ_FAIRE.md)
   - Comprendre ce que vous devez faire

2. **Suivre** [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md)
   - Configurer Azure étape par étape

3. **Créer les modules** (voir [PLAN_PROJET.md](./PLAN_PROJET.md))
   - Module VM
   - Module Storage
   - Module Web App

4. **Déployer** [docs/DEPLOYMENT.md](./docs/DEPLOYMENT.md)
   - Suivre la procédure de déploiement

5. **Vérifier** [docs/GUIDE_PORTAL_AZURE.md](./docs/GUIDE_PORTAL_AZURE.md)
   - Vérifier dans le portail Azure

---

## 📍 Emplacement des Guides

```
Brief/
├── CE_QUE_VOUS_DEVEZ_FAIRE.md  ⭐ Actions manuelles
├── START_HERE.md                ⭐ Guide de démarrage
│
└── docs/
    ├── GUIDE_AZURE_SETUP.md     ⭐ Configuration Azure
    ├── GUIDE_PORTAL_AZURE.md    ⭐ Guide portail Azure
    ├── DEPLOYMENT.md            ⭐ Déploiement
    └── VERIFICATION.md          ⭐ Vérification
```

---

## 🎯 Questions Fréquentes

### "Je n'ai jamais utilisé Azure, par où commencer ?"

1. [CE_QUE_VOUS_DEVEZ_FAIRE.md](./CE_QUE_VOUS_DEVEZ_FAIRE.md) - Voir ce qu'il faut faire
2. [docs/GUIDE_AZURE_SETUP.md](./docs/GUIDE_AZURE_SETUP.md) - Configurer Azure
3. [docs/GUIDE_PORTAL_AZURE.md](./docs/GUIDE_PORTAL_AZURE.md) - Apprendre le portail

### "Comment vérifier mes ressources dans le portail ?"

👉 [docs/GUIDE_PORTAL_AZURE.md](./docs/GUIDE_PORTAL_AZURE.md)

Guide complet avec :
- Étapes détaillées pour chaque ressource
- Où cliquer dans le portail
- Ce que vous devriez voir
- Captures d'écran recommandées

### "Quelles sont les commandes Azure CLI ?"

👉 [docs/VERIFICATION.md](./docs/VERIFICATION.md#méthode-2-azure-cli)

Toutes les commandes pour vérifier :
- Resource Groups
- VMs
- Storage Accounts
- Web Apps

---

*Index créé pour faciliter la navigation dans la documentation*
