# Exercice 4 : Multi Providers

## Objectif
Utiliser Terraform pour générer un ensemble de 10 mots de passe aléatoires et les stocker dans un fichier local.

Cet exercice vous permet de travailler avec deux ressources Terraform où l'une dépend de l'autre :
- Une ressource `random` pour générer des mots de passe
- Une ressource `local_file` pour les sauvegarder

## Fichiers
- `main.tf` : Configuration avec providers random et local

## Concepts Appris

1. **Multi Providers** : Utilisation de `random` et `local` providers
2. **Count Meta-argument** : Générer plusieurs ressources avec `count = 10`
3. **Dépendances** : La ressource `local_file` dépend de `random_password`
4. **Fonctions Terraform** :
   - `join()` : Joindre des éléments
   - `for` : Boucle pour itérer
   - `timestamp()` : Timestamp actuel
5. **Interpolation** : Utiliser les valeurs d'une ressource dans une autre

## Exécution

```bash
# Depuis le dossier exercice_4
chmod +x run.sh
./run.sh init
./run.sh plan
./run.sh apply -auto-approve
```

## Résultat Attendu

Après `terraform apply`, vous devriez avoir :
- Un fichier `passwords.txt` créé
- Contenu : 10 mots de passe aléatoires formatés
- Permissions : 0600 (lecture/écriture pour le propriétaire uniquement)

## Vérification

```bash
# Voir le fichier créé
ls -la passwords.txt

# Voir le contenu (⚠️ Attention: contient des mots de passe!)
cat passwords.txt

# Compter les mots de passe
grep -c "Password" passwords.txt
```

## Structure du Fichier Généré

Le fichier `passwords.txt` contiendra :
```
# Mots de passe générés avec Terraform
# Générés le: 2026-01-12T14:10:00Z

Password 1: Abc123!@#XyZ789
Password 2: Def456$%^UvW012
...
Password 10: Ghi789&*()Rst345
```

## Nettoyage

```bash
./run.sh destroy
```

## Ressources

- [Provider Random](https://registry.terraform.io/providers/hashicorp/random/latest/docs)
- [Provider Local - Resource File](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)
- [Terraform for_each](https://developer.hashicorp.com/terraform/language/meta-arguments/for_each)
- [Terraform Functions](https://developer.hashicorp.com/terraform/language/functions)

## Alternative avec for_each

Si vous préférez utiliser `for_each` au lieu de `count`, voici une version alternative :

```hcl
resource "random_password" "passwords" {
  for_each = toset([for i in range(1, 11) : "password_${i}"])

  length  = 16
  special = true
  upper   = true
  lower   = true
  numeric = true
}

resource "local_file" "passwords_file" {
  content = <<-EOT
    # Mots de passe générés avec Terraform
    # Générés le: ${timestamp()}

    ${join("\n", [
      for key, password in random_password.passwords : "${key}: ${password.result}"
    ])}
  EOT

  filename        = "${path.module}/passwords.txt"
  file_permission = "0600"
}
```
