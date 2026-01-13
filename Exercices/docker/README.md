# 🐳 Docker - Conteneur Terraform pour les Exercices

Conteneur Docker personnalisé pour exécuter Terraform pour les exercices locaux.

---

## 📋 Contenu

- `Dockerfile` - Image Docker avec Terraform
- `docker-compose.yml` - Configuration Docker Compose
- `.dockerignore` - Fichiers à exclure du build

---

## 🚀 Utilisation

### Build l'image

```bash
# Depuis Exercices/
cd Exercices
./scripts/docker/docker-build.sh
```

Ou depuis PowerShell :

```powershell
.\scripts\docker\docker-build.ps1
```

### Utiliser le conteneur

Le conteneur est utilisé automatiquement par les scripts Terraform dans `scripts/wsl/` et `scripts/powershell/`.

---

## 🔧 Configuration

L'image contient :
- ✅ Terraform (dernière version)
- ✅ Outils utiles (git, jq, bash)

---

*Conteneur Docker pour les exercices Terraform*
