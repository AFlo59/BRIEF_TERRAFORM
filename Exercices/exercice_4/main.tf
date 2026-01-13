terraform {
  required_version = ">= 1.0"

  required_providers {
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

# Générer 10 mots de passe aléatoires
resource "random_password" "passwords" {
  count   = 10
  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

# Sauvegarder les mots de passe dans un fichier
resource "local_file" "passwords_file" {
  content = <<-EOT
    # Mots de passe générés avec Terraform
    # Générés le: ${timestamp()}

    ${join("\n", [
      for i, password in random_password.passwords : "Password ${i + 1}: ${password.result}"
    ])}
  EOT

  filename        = "${path.module}/passwords.txt"
  file_permission = "0600"  # Permissions restrictives pour un fichier de mots de passe
}
