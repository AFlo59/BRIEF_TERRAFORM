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

# Installer Azure CLI via pip avec --break-system-packages
# Nécessaire car Alpine Linux récent utilise un environnement Python "externally managed" (PEP 668)
RUN pip3 install --no-cache-dir --break-system-packages azure-cli

# Créer un wrapper pour az si nécessaire
# pip installe généralement le script dans /usr/local/bin
RUN if [ -f /usr/local/bin/az ]; then \
        chmod +x /usr/local/bin/az && \
        ln -sf /usr/local/bin/az /usr/bin/az; \
    elif [ -f /usr/bin/az ]; then \
        echo "Azure CLI already in /usr/bin"; \
    else \
        # Créer un wrapper Python si le script n'existe pas
        echo '#!/bin/sh' > /usr/local/bin/az && \
        echo 'exec python3 -m azure.cli "$@"' >> /usr/local/bin/az && \
        chmod +x /usr/local/bin/az && \
        ln -sf /usr/local/bin/az /usr/bin/az; \
    fi

# Vérifier que Azure CLI est installé et fonctionne
RUN az --version >/dev/null 2>&1 || (echo "ERROR: Azure CLI installation failed" && exit 1)

# Créer un répertoire de travail
WORKDIR /workspace

# Définir les variables d'environnement
ENV TF_IN_AUTOMATION=false
ENV TF_INPUT=true

# Commande par défaut
CMD ["terraform", "version"]
