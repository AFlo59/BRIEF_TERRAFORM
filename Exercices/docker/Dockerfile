# Dockerfile pour Terraform - Exercices
# Image de base avec Terraform pour les exercices locaux

FROM hashicorp/terraform:latest

# Installer des outils utiles
RUN apk add --no-cache \
    bash \
    git \
    jq \
    || (apt-get update && apt-get install -y bash git jq || true)

# Créer un répertoire de travail
WORKDIR /workspace

# Définir les variables d'environnement
ENV TF_IN_AUTOMATION=false
ENV TF_INPUT=true

# Commande par défaut
CMD ["terraform", "version"]
