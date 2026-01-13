variable "file_name" {
  description = "Nom du fichier à créer"
  type        = string
  default     = "mon_fichier.txt"
}

variable "file_content" {
  description = "Contenu du fichier"
  type        = string
  default     = "Contenu par défaut"
}
