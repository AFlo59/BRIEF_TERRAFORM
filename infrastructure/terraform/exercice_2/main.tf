terraform {
  required_version = ">= 1.0"

  required_providers {
    local = {
      source  = "hashicorp/local"
      version = "~> 2.4"
    }
  }
}

resource "local_file" "dynamic_file" {
  content  = var.file_content
  filename = "${path.module}/${var.file_name}"
  file_permission = "0644"
}
