# Dockerfile pour Terraform - Projet Brief Azure
# Image de base avec Terraform et Azure CLI

FROM hashicorp/terraform:latest

# Installer des outils de base
RUN apk add --no-cache \
    bash \
    curl \
    python3 \
    py3-pip \
    git \
    openssh-client \
    jq \
    || (apt-get update && apt-get install -y bash curl python3 python3-pip git openssh-client jq || true)

# Installer Azure CLI via pip (méthode universelle)
RUN pip3 install --no-cache-dir azure-cli || \
    (curl -sL https://aka.ms/InstallAzureCLIDeb | bash || true)

# Créer un répertoire de travail
WORKDIR /workspace

# Définir les variables d'environnement
ENV TF_IN_AUTOMATION=false
ENV TF_INPUT=true

# Commande par défaut
CMD ["terraform", "version"]
