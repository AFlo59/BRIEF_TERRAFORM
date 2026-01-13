#!/bin/bash
# Script pour nettoyer et réinitialiser complètement

echo "🧹 Nettoyage complet..."
rm -rf .terraform terraform.tfstate* .terraform.lock.hcl hello_world.txt

echo "🚀 Réinitialisation..."
./run.sh init

echo "📋 Plan..."
./run.sh plan

echo "⚙️  Application..."
./run.sh apply -auto-approve

echo "✅ Vérification..."
ls -la hello_world.txt
cat hello_world.txt
