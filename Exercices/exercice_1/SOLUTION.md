# Solution au Problème "No changes"

Si Terraform dit "No changes" mais que le fichier n'existe pas, voici comment résoudre :

## Solution 1: Forcer la création avec -replace

```bash
./run.sh apply -replace='local_file.hello_world' -auto-approve
```

## Solution 2: Nettoyer complètement et recommencer

```bash
# Supprimer tous les fichiers de state
rm -rf .terraform terraform.tfstate* .terraform.lock.hcl

# Réinitialiser
./run.sh init

# Appliquer
./run.sh apply -auto-approve
```

## Solution 3: Vérifier où le fichier devrait être créé

Le fichier devrait être créé dans le même dossier que `main.tf` :
```bash
pwd
# Devrait être: /mnt/d/PROJETS/BRIEF_TERRAFORM/infrastructure/terraform/exercice_1

ls -la hello_world.txt
```

## Solution 4: Vérifier le state Terraform

```bash
# Voir ce que Terraform track
docker run --rm -i \
  -v $(pwd):/workspace \
  -v terraform-plugins:/root/.terraform.d/plugins \
  -w /workspace \
  hashicorp/terraform:latest state list
```
