# ⚠️ Erreur : Limite d'IP Publiques Basic Atteinte

Guide pour résoudre l'erreur de limite d'adresses IP publiques Basic SKU.

---

## ❌ Erreur

```
Error: IPv4BasicSkuPublicIpCountLimitReached:
Cannot create more than 0 IPv4 Basic SKU public IP addresses
for this subscription in this region.
```

---

## 🔍 Cause

Votre abonnement Azure a atteint la **limite de 0 adresses IP publiques Basic SKU** dans la région `francecentral`.

Cela peut arriver avec :
- Les abonnements étudiants/gratuits qui ont des limites strictes
- Les abonnements qui ont déjà utilisé toutes leurs IP publiques Basic
- Certaines régions qui ont des restrictions

---

## ✅ Solutions

### Solution 1 : Utiliser Standard SKU (Recommandé)

Le module VM a été mis à jour pour utiliser **Standard SKU** au lieu de Basic.

**Avantages** :
- ✅ Pas de limite stricte
- ✅ Meilleure sécurité (par défaut, Standard SKU bloque le trafic entrant)
- ✅ Compatible avec les Load Balancers Standard

**Inconvénients** :
- ⚠️ Coûte légèrement plus cher (~$0.005/heure vs gratuit pour Basic)
- ⚠️ Nécessite une Network Security Group pour autoriser le trafic SSH

**Action** : Le code a déjà été mis à jour. Relancez `terraform apply`.

---

### Solution 2 : Supprimer une IP Publique Existante

Si vous avez d'autres IP publiques Basic inutilisées :

```bash
# Lister les IP publiques Basic
az network public-ip list --query "[?sku.name=='Basic']" --output table

# Supprimer une IP publique inutilisée
az network public-ip delete --name NOM_IP --resource-group fabadiRG
```

Puis relancez `terraform apply`.

---

### Solution 3 : Utiliser une Autre Région

Si vous pouvez changer de région :

1. **Mettre à jour `terraform.tfvars`** :
```hcl
location = "westeurope"  # Au lieu de francecentral
```

2. **Vérifier que le Resource Group existe dans cette région** ou le créer :
```bash
az group create --name fabadiRG --location westeurope
```

3. **Relancer Terraform** :
```bash
terraform apply
```

---

### Solution 4 : Ne Pas Utiliser d'IP Publique (Avancé)

Si vous n'avez pas besoin d'accéder à la VM depuis Internet :

1. **Modifier `Brief/modules/vm/main.tf`** pour ne pas créer d'IP publique
2. **Utiliser Azure Bastion** ou un VPN pour accéder à la VM

⚠️ **Note** : Cette solution est complexe et nécessite des modifications importantes du code.

---

## 🎯 Solution Recommandée

**Utilisez Standard SKU** (Solution 1) :
- Le code a déjà été mis à jour
- C'est la solution la plus simple
- Le coût supplémentaire est minimal (~$3-4/mois)

---

## 📋 Après la Correction

Une fois le SKU changé en Standard, relancez :

```bash
# Dans le conteneur Docker
terraform apply
```

Terraform devrait maintenant créer l'IP publique avec succès.

---

## 💰 Coûts Standard SKU vs Basic SKU

| SKU | Coût | Limite |
|-----|------|--------|
| Basic | Gratuit | Limite stricte (0 dans votre cas) |
| Standard | ~$0.005/heure (~$3-4/mois) | Limite beaucoup plus élevée |

---

## 🔒 Sécurité avec Standard SKU

Les IP publiques Standard SKU sont **plus sécurisées** :
- Par défaut, elles bloquent tout le trafic entrant
- Vous devez explicitement autoriser le trafic via une Network Security Group
- C'est déjà configuré dans le module VM (règle SSH sur le port 22)

---

*Guide pour résoudre l'erreur de limite d'IP publiques Basic*
