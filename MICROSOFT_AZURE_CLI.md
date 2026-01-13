Azure CLI sur Windows + WSL (guide pas à pas)
Objectif

Installer Azure CLI en 64 bits sur Windows

Se connecter à Azure

Utiliser la même connexion Azure depuis WSL (Linux) sans réinstaller Azure CLI dans WSL

Étape 1 — Vérifier que Windows est en 64 bits

Ouvre PowerShell et exécute :

wmic os get osarchitecture


Résultat attendu :

64-bit


Si ce n’est pas 64-bit → arrêter ici.

Étape 2 — Installer Azure CLI (64 bits) sur Windows

Lien officiel (x64) :
https://aka.ms/installazurecliwindowsx64

Méthode recommandée

Télécharger le fichier .msi

Double-cliquer

Next → Install → Finish

Étape 3 — Vérifier l’installation Azure CLI

Ferme PowerShell, rouvre-le, puis exécute :

az --version


Résultat attendu :

azure-cli 2.xx.x

Python 64 bit (AMD64)

Chemin contenant Program Files (pas Program Files (x86))

Vérifier le chemin exact :

where.exe az


Résultat attendu :

C:\Program Files\Microsoft SDKs\Azure\CLI2\wbin\az.cmd

Étape 4 — Connexion à Azure (Windows)
az login


Un navigateur s’ouvre → connecte-toi.

Si Azure affiche plusieurs subscriptions, sélectionne celle que tu veux
(exemple : Data Engineering).

Vérifier la subscription active
az account show

Lister toutes les subscriptions
az account list -o table

Forcer une subscription (recommandé)
az account set --subscription "NOM_DE_LA_SUBSCRIPTION"

Étape 5 — Utiliser Azure CLI depuis WSL (méthode recommandée)

⚠️ Ne pas installer Azure CLI dans WSL.
On va utiliser le CLI Windows directement.

Étape 5.1 — Vérifier que WSL voit Azure CLI

Dans WSL (Ubuntu) :

ls "/mnt/c/Program Files/Microsoft SDKs/Azure/CLI2/wbin"


Tu dois voir :

az

az.cmd

Étape 5.2 — Tester Azure CLI depuis WSL (sans alias)
"/mnt/c/Program Files/Microsoft SDKs/Azure/CLI2/wbin/az" version


Si la version s’affiche → OK.

Étape 5.3 — Créer un alias permanent dans WSL

Ouvre le fichier .bashrc :

nano ~/.bashrc


Ajoute à la fin du fichier :

alias az='/mnt/c/Program Files/Microsoft SDKs/Azure/CLI2/wbin/az'

Sauvegarder et quitter nano

Sauvegarder : Ctrl + O

Confirmer : Entrée

Quitter : Ctrl + X

Recharge le fichier :

source ~/.bashrc

Étape 5.4 — Vérifier la connexion Azure depuis WSL
az account show
az account list -o table


Tu dois voir exactement la même subscription que sous Windows.

Étape 6 — Problème courant : az non reconnu sous Windows

Si az n’est pas reconnu juste après l’installation :

$env:Path = [Environment]::GetEnvironmentVariable("Path","Machine") + ";" + [Environment]::GetEnvironmentVariable("Path","User")


Puis :

az --version

Bonnes pratiques

Une seule installation Azure CLI (Windows)

Une seule connexion Azure

WSL utilise le CLI Windows

Pas de double token

Pas de conflits

Fin

Azure CLI est maintenant utilisable :

sous Windows

sous WSL

avec la même authentification Azure
