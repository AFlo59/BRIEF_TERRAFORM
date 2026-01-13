terraform {
  required_version = ">= 1.0"

  required_providers {
    http = {
      source  = "hashicorp/http"
      version = "~> 3.4"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

# Data source pour télécharger le fichier depuis l'URL
data "http" "country_data" {
  url = "https://cdn.wsform.com/wp-content/uploads/2018/09/country_full.csv"

  # Optionnel: méthode de requête
  request_headers = {
    Accept = "text/csv"
  }
}

# Ressource pour sauvegarder le fichier téléchargé localement
resource "local_file" "downloaded_file" {
  content  = data.http.country_data.response_body
  filename = "${path.module}/downloaded_file.txt"
  file_permission = "0644"
}
