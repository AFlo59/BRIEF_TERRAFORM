# Exercice 2 : Variables

## Objectif
Découvrir l'utilisation des variables dans Terraform pour rendre la configuration flexible.

## Fichiers
- `main.tf` : Configuration Terraform utilisant les variables
- `variables.tf` : Définition des variables

## Variables Définies

1. **file_name** : Nom du fichier à créer (string, défaut: "mon_fichier.txt")
2. **file_content** : Contenu du fichier (string, défaut: "Contenu par défaut")

## Exécution

### Méthode 1: Avec les valeurs par défaut

```bash
# Depuis le dossier exercice_2
chmod +x run.sh
./run.sh init
./run.sh plan
./run.sh apply
```

### Méthode 2: Avec des variables personnalisées (ligne de commande)

```bash
./run.sh apply -var="file_name=mon_document.txt" -var="file_content=Ceci est mon contenu personnalisé!"
```

### Méthode 3: Avec un fichier terraform.tfvars

Créez `terraform.tfvars` :
```hcl
file_name    = "mon_document.txt"
file_content = "Ceci est le contenu de mon fichier créé avec Terraform !"
```

Puis exécutez :
```bash
./run.sh apply -var-file="terraform.tfvars"
```

### Méthode 4: Avec variables d'environnement

```bash
export TF_VAR_file_name="test.txt"
export TF_VAR_file_content="Hello from environment variable!"
./run.sh apply
```

## Résultat Attendu

Après `terraform apply`, vous devriez avoir :
- Un fichier créé avec le nom spécifié dans `file_name`
- Le contenu correspondant à `file_content`
- Permissions : 0644

## Vérification

```bash
# Voir le fichier créé
ls -la $(terraform output -raw file_name 2>/dev/null || echo "mon_fichier.txt")

# Voir le contenu
cat $(terraform output -raw file_name 2>/dev/null || echo "mon_fichier.txt")
```

## Nettoyage

```bash
./run.sh destroy
```

## Ressources

- [Provider Local - Resource File](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)
- [Terraform Variables](https://developer.hashicorp.com/terraform/language/values/variables)
