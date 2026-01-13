# 🛠️ IDE et Extensions pour Terraform

Guide des meilleures options d'IDE et d'extensions pour travailler avec Terraform.

---

## 🎯 Options Principales

### 1. Visual Studio Code (Recommandé) ⭐

**Extension officielle HashiCorp** : La meilleure option pour VS Code.

#### Installation

1. **Ouvrir VS Code**
2. **Aller dans Extensions** (Ctrl+Shift+X)
3. **Rechercher** : `HashiCorp Terraform`
4. **Installer** : "Terraform" par HashiCorp

#### Fonctionnalités

✅ **Syntax highlighting** - Coloration syntaxique  
✅ **Auto-completion** - Complétion automatique  
✅ **Format on save** - Formatage automatique  
✅ **Linting** - Détection d'erreurs  
✅ **IntelliSense** - Suggestions intelligentes  
✅ **Hover documentation** - Documentation au survol  
✅ **Go to definition** - Navigation vers les définitions  
✅ **Symbol search** - Recherche de symboles  

#### Configuration Recommandée

Ajoutez dans `.vscode/settings.json` :

```json
{
  "[terraform]": {
    "editor.defaultFormatter": "hashicorp.terraform",
    "editor.formatOnSave": true,
    "editor.codeActionsOnSave": {
      "source.formatDocument": "explicit"
    }
  },
  "terraform.languageServer": {
    "enabled": true,
    "args": []
  },
  "files.associations": {
    "*.tf": "terraform",
    "*.tfvars": "terraform",
    "*.hcl": "terraform"
  }
}
```

#### Autres Extensions Utiles pour VS Code

- **Terraform Cloud** - Intégration avec Terraform Cloud
- **Terraform Doc** - Génération de documentation
- **Terraform Snippets** - Snippets de code

---

### 2. IntelliJ IDEA / PyCharm / WebStorm

**Plugin Terraform** pour les IDE JetBrains.

#### Installation

1. **File → Settings → Plugins**
2. **Rechercher** : `Terraform`
3. **Installer** : "Terraform" par HashiCorp

#### Fonctionnalités

✅ Syntax highlighting  
✅ Auto-completion  
✅ Code formatting  
✅ Error detection  
✅ Refactoring support  

---

### 3. Terraform Cloud (UI Web)

Interface web officielle de HashiCorp pour gérer Terraform.

#### Fonctionnalités

✅ **UI Web complète** - Interface graphique  
✅ **State management** - Gestion du state à distance  
✅ **Runs visualization** - Visualisation des exécutions  
✅ **Policy as Code** - Sentinel policies  
✅ **Collaboration** - Travail en équipe  
✅ **Cost estimation** - Estimation des coûts  

#### Accès

- **Gratuit** : [app.terraform.io](https://app.terraform.io)
- **Enterprise** : Version self-hosted

---

### 4. Terraform Language Server (LSP)

Serveur de langage pour intégration avec n'importe quel éditeur supportant LSP.

#### Installation

```bash
# Via Go
go install github.com/hashicorp/terraform-ls@latest

# Via Homebrew (Mac)
brew install terraform-ls

# Via Chocolatey (Windows)
choco install terraform-ls
```

#### Éditeurs Supportés

- VS Code (via extension)
- Vim/Neovim (via plugins)
- Emacs
- Sublime Text
- Atom

---

## 🚀 Configuration pour VS Code (Recommandé)

### Étape 1: Installer l'Extension

1. Ouvrir VS Code
2. Extensions (Ctrl+Shift+X)
3. Rechercher "HashiCorp Terraform"
4. Installer

### Étape 2: Configuration du Projet

Créer `.vscode/settings.json` à la racine du projet :

```json
{
  "[terraform]": {
    "editor.defaultFormatter": "hashicorp.terraform",
    "editor.formatOnSave": true,
    "editor.formatOnPaste": true
  },
  "terraform.languageServer": {
    "enabled": true
  },
  "files.associations": {
    "*.tf": "terraform",
    "*.tfvars": "terraform",
    "*.hcl": "terraform"
  },
  "terraform.format": {
    "enable": true
  },
  "terraform.lint": {
    "enable": true
  }
}
```

### Étape 3: Utilisation

- **Formatage** : Shift+Alt+F (ou Cmd+Shift+P → "Format Document")
- **Validation** : Les erreurs apparaissent automatiquement
- **Auto-completion** : Ctrl+Space
- **Documentation** : Hover sur une ressource pour voir la doc

---

## 📋 Extensions VS Code Recommandées

### Essentielles

1. **HashiCorp Terraform** (officiel)
   - ID: `hashicorp.terraform`
   - Fonctionnalités complètes

2. **Terraform Cloud**
   - ID: `hashicorp.terraform-cloud`
   - Intégration Terraform Cloud

### Utilitaires

3. **Terraform Doc**
   - Génération de documentation
   - ID: `alexkrechik.cucumberautocomplete`

4. **Terraform Snippets**
   - Snippets de code rapides
   - ID: `run-at-scale.terraform-doc-snippets`

---

## 🎨 Fonctionnalités Avancées

### 1. IntelliSense et Auto-completion

L'extension fournit :
- Complétion pour les ressources
- Complétion pour les variables
- Complétion pour les outputs
- Complétion pour les data sources

### 2. Validation en Temps Réel

- Détection d'erreurs de syntaxe
- Vérification des types
- Validation des références

### 3. Navigation

- **Go to Definition** (F12)
- **Find References** (Shift+F12)
- **Symbol Search** (Ctrl+Shift+O)

### 4. Refactoring

- Renommage de variables
- Extraction de modules
- Formatage automatique

---

## 🔧 Configuration avec Docker

Si vous utilisez Terraform via Docker, configurez VS Code pour utiliser Docker :

### Option 1: Extension Dev Containers

1. Installer "Dev Containers" extension
2. Créer `.devcontainer/devcontainer.json` :

```json
{
  "image": "hashicorp/terraform:latest",
  "features": {},
  "customizations": {
    "vscode": {
      "extensions": [
        "hashicorp.terraform"
      ]
    }
  },
  "mounts": [
    "source=${localWorkspaceFolder},target=/workspace,type=bind"
  ],
  "workspaceFolder": "/workspace"
}
```

### Option 2: Remote - Containers

Utiliser l'extension "Remote - Containers" pour développer directement dans Docker.

---

## 🌐 Terraform Cloud UI

### Accès Web

1. **Créer un compte** : [app.terraform.io](https://app.terraform.io)
2. **Connecter votre workspace**
3. **Visualiser les runs** dans l'interface web

### Fonctionnalités Web

- 📊 **Dashboard** - Vue d'ensemble
- 🔄 **Runs** - Historique des exécutions
- 📝 **State** - Visualisation du state
- 👥 **Teams** - Gestion d'équipe
- 🔐 **Policies** - Sentinel policies
- 💰 **Cost Estimation** - Estimation des coûts

---

## 💡 Astuces VS Code

### Raccourcis Utiles

- `Ctrl+Shift+P` → "Terraform: Format Document"
- `Ctrl+Shift+P` → "Terraform: Validate"
- `F12` → Go to Definition
- `Shift+F12` → Find References
- `Ctrl+Space` → Auto-completion

### Snippets Personnalisés

Créer `.vscode/terraform.code-snippets` :

```json
{
  "Terraform Resource": {
    "prefix": "tf-resource",
    "body": [
      "resource \"${1:type}\" \"${2:name}\" {",
      "  $0",
      "}"
    ],
    "description": "Terraform resource block"
  }
}
```

---

## 📚 Ressources

- [VS Code Terraform Extension](https://marketplace.visualstudio.com/items?itemName=hashicorp.terraform)
- [Terraform Language Server](https://github.com/hashicorp/terraform-ls)
- [Terraform Cloud](https://www.terraform.io/cloud)
- [Terraform Documentation](https://www.terraform.io/docs)

---

## ✅ Recommandation

**Pour ce projet** : Utilisez **VS Code avec l'extension HashiCorp Terraform**

C'est la solution la plus simple, gratuite et complète pour développer avec Terraform.

---

*Guide créé pour faciliter le développement Terraform avec des outils modernes*
