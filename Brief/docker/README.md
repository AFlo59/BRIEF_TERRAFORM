# 🐳 Docker - Conteneur Terraform pour le Brief

Conteneur Docker personnalisé pour exécuter Terraform avec Azure CLI.

---

## 📋 Contenu

- `Dockerfile` - Image Docker avec Terraform + Azure CLI
- `docker-compose.yml` - Configuration Docker Compose
- `.dockerignore` - Fichiers à exclure du build

---

## 🚀 Utilisation

### Build l'image

```bash
# Depuis Brief/docker/
cd Brief/docker
docker build -t terraform-brief:latest .
```

Ou utiliser les scripts dans `scripts/docker/` :

```bash
# WSL
./scripts/docker/docker-build.sh

# PowerShell
.\scripts\docker\docker-build.ps1
```

### Utiliser le conteneur

Le conteneur est utilisé automatiquement par les scripts Terraform dans `scripts/wsl/` et `scripts/powershell/`.

---

## 🔧 Configuration

L'image contient :
- ✅ Terraform (dernière version)
- ✅ Azure CLI
- ✅ Outils utiles (git, jq, ssh)

---

*Conteneur Docker pour le projet Brief*
