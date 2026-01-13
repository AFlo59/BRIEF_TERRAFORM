# Configuration Terraform principale
# Ce fichier contient la configuration de base pour votre infrastructure

terraform {
  required_version = ">= 1.0"
  
  # Configuration du backend (optionnel)
  # Décommentez et configurez selon votre besoin
  # backend "s3" {
  #   bucket = "your-terraform-state-bucket"
  #   key    = "terraform.tfstate"
  #   region = "us-east-1"
  # }
  
  required_providers {
    # Ajoutez vos providers ici
    # Exemple pour AWS:
    # aws = {
    #   source  = "hashicorp/aws"
    #   version = "~> 5.0"
    # }
    
    # Exemple pour Azure:
    # azurerm = {
    #   source  = "hashicorp/azurerm"
    #   version = "~> 3.0"
    # }
  }
}

# Exemple de ressource (à adapter selon vos besoins)
# resource "aws_instance" "example" {
#   ami           = var.ami_id
#   instance_type = var.instance_type
#   
#   tags = {
#     Name = "terraform-example"
#   }
# }
