terraform {
  required_version = ">= 1.0"
  
  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "hello_world" {
  content  = "Bienvenue dans Terraform !"
  filename = "${path.module}/hello_world.txt"
  file_permission = "0755"
}
