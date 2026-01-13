# Exercice 3 : Data Source + HTTP

## Objectif
Utiliser le provider HTTP de Terraform pour télécharger un fichier à partir d'une URL et le stocker localement.

Le fichier se situe à l'adresse : `https://cdn.wsform.com/wp-content/uploads/2018/09/country_full.csv`

## Fichiers
- `main.tf` : Configuration avec data source HTTP et ressource local_file

## Concepts Appris

1. **Data Source** : `data "http"` pour télécharger depuis une URL
2. **Référencement** : Utiliser `data.http.country_data.response_body` dans une ressource
3. **Multi Providers** : Utilisation de `http` et `local` providers

## Exécution

```bash
# Depuis le dossier exercice_3
chmod +x run.sh
./run.sh init
./run.sh plan
./run.sh apply -auto-approve
```

## Résultat Attendu

Après `terraform apply`, vous devriez avoir :
- Un fichier `downloaded_file.txt` créé
- Contenu : Le fichier CSV téléchargé depuis l'URL
- Permissions : 0644

## Vérification

```bash
# Voir le fichier téléchargé
ls -la downloaded_file.txt

# Voir les premières lignes
head -10 downloaded_file.txt

# Compter les lignes
wc -l downloaded_file.txt
```

## Nettoyage

```bash
./run.sh destroy
```

## Ressources

- [Provider HTTP](https://registry.terraform.io/providers/hashicorp/http/latest/docs)
- [Provider Local - Resource File](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file)
