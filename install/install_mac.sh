#!/bin/bash

echo "==================================="
echo "Installation de l'environnement de développement"
echo "==================================="
echo

echo "Choisissez l'environnement à installer:"
echo "1. Supabase (environnement dédié)"
echo "2. Odoo Enterprise (environnement dédié)"
echo "3. Coolify (environnement dédié)"
echo

read -p "Votre choix (1-3): " choix

if [ "$choix" = "1" ]; then
    echo
    echo "Installation de l'environnement Supabase..."
    cd ..
    cd supabase
    docker-compose up -d
    echo
    echo "Supabase est accessible à l'adresse:"
    echo "- Studio: http://localhost:3000"
    echo "- API REST: http://localhost:8000"
    echo "- pgAdmin: http://localhost:5050"
    echo
    echo "Identifiants pgAdmin:"
    echo "- Email: admin@example.com"
    echo "- Mot de passe: admin"
elif [ "$choix" = "2" ]; then
    echo
    echo "Installation de l'environnement Odoo Enterprise..."
    cd ..
    cd odoo
    docker-compose up -d
    echo
    echo "Odoo est accessible à l'adresse:"
    echo "- Interface web: http://localhost:8069"
    echo
    echo "Identifiants Odoo:"
    echo "- Base de données: odoo"
    echo "- Utilisateur: admin"
    echo "- Mot de passe: admin"
elif [ "$choix" = "3" ]; then
    echo
    echo "Installation de l'environnement Coolify..."
    cd ..
    cd coolify
    docker-compose up -d
    echo
    echo "Coolify est accessible à l'adresse:"
    echo "- Interface web: http://localhost:8080"
else
    echo "Choix invalide. Veuillez relancer le script."
    exit 1
fi

echo
echo "Installation terminée avec succès!"
echo

# Ouvrir les services dans le navigateur par défaut
if [ "$choix" = "1" ] || [ "$choix" = "4" ]; then
    open http://localhost:3000
elif [ "$choix" = "2" ] || [ "$choix" = "4" ]; then
    open http://localhost:8069
elif [ "$choix" = "3" ] || [ "$choix" = "4" ]; then
    open http://localhost:8080
fi
