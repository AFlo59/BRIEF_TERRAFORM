# Exercice 1 : Fichier Local

## Objectif
Créer un fichier local avec Terraform.

## Fichiers
- `main.tf` : Configuration Terraform

## Exécution

### Méthode 1: Script run.sh (Recommandé)

```bash
# Depuis le dossier exercice_1
./run.sh init
./run.sh plan
./run.sh apply
```

### Méthode 2: Depuis la racine du projet

```bash
# Depuis /mnt/d/PROJETS/BRIEF_TERRAFORM
./scripts/terraform-wsl.sh init -chdir=infrastructure/terraform/exercice_1
./scripts/terraform-wsl.sh plan -chdir=infrastructure/terraform/exercice_1
./scripts/terraform-wsl.sh apply -chdir=infrastructure/terraform/exercice_1
```

### Méthode 3: Docker directement

```bash
# Depuis le dossier exercice_1
docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -w /workspace \
  hashicorp/terraform:latest init

docker run --rm -it \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -w /workspace \
  hashicorp/terraform:latest apply
```

## Résultat attendu

Après `terraform apply`, vous devriez avoir :
- Un fichier `hello_world.txt` créé
- Contenu : "Bienvenue dans Terraform !"
- Permissions : 0755

## Vérification

```bash
ls -la hello_world.txt
cat hello_world.txt
```

## Nettoyage

```bash
./run.sh destroy
# ou
terraform destroy
```
