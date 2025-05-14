#!/bin/bash

echo "==================================="
echo "Initialisation du depot Git et push vers GitHub"
echo "==================================="
echo ""

read -p "Entrez votre nom d'utilisateur GitHub: " username
read -p "Entrez votre token d'acces personnel GitHub: " token

cd ..

echo ""
echo "Initialisation du depot Git local..."
git init
git add .
git commit -m "Initial commit"

echo ""
echo "Creation du depot GitHub..."
curl -X POST -H "Authorization: token $token" -H "Accept: application/vnd.github.v3+json" https://api.github.com/user/repos -d "{\"name\":\"pixee\",\"private\":false,\"description\":\"Environnements de developpement Docker pour Supabase, Odoo et Coolify\"}"

echo ""
echo "Configuration du depot distant..."
git remote add origin https://github.com/$username/pixee.git

echo ""
echo "Push vers GitHub..."
git push -u origin master

echo ""
echo "Depot Git initialise et pousse vers GitHub avec succes!"
echo ""
