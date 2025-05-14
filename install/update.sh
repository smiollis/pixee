#!/bin/bash

echo "==================================="
echo "Mise à jour des environnements Docker"
echo "==================================="
echo ""

cd ..

echo ""
echo "Quel environnement souhaitez-vous mettre à jour?"
echo "1) Supabase uniquement"
echo "2) Odoo Enterprise uniquement"
echo "3) Coolify uniquement"
echo "4) Supabase + Odoo Enterprise"
echo "5) Tous les environnements"
echo ""

read -p "Votre choix (1-5): " choice

case $choice in
    1)
        echo ""
        echo "Mise à jour de l'environnement Supabase..."
        cd supabase
        docker-compose pull
        docker-compose up -d
        ;;
    2)
        echo ""
        echo "Mise à jour de l'environnement Odoo Enterprise..."
        cd odoo
        docker-compose pull
        docker-compose up -d
        ;;
    3)
        echo ""
        echo "Mise à jour de l'environnement Coolify..."
        cd coolify
        docker-compose pull
        docker-compose up -d
        ;;
    4)
        echo ""
        echo "Mise à jour des environnements Supabase et Odoo Enterprise..."
        docker-compose pull supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
        docker-compose up -d supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
        ;;
    5)
        echo ""
        echo "Mise à jour de tous les environnements..."
        docker-compose pull
        docker-compose up -d
        ;;
    *)
        echo ""
        echo "Choix invalide. Veuillez sélectionner une option entre 1 et 5."
        exit 1
        ;;
esac

echo ""
echo "Environnement(s) mis à jour avec succès!"
echo ""
echo "Accès aux environnements:"
echo ""

if [ "$choice" == "1" ] || [ "$choice" == "4" ] || [ "$choice" == "5" ]; then
    STUDIO_PORT=$(grep STUDIO_PORT .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    REST_PORT=$(grep REST_PORT .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    PGADMIN_PORT=$(grep PGADMIN_PORT .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    
    echo "Supabase Studio: http://localhost:${STUDIO_PORT:-3000}"
    echo "Supabase API REST: http://localhost:${REST_PORT:-8000}"
    echo "pgAdmin: http://localhost:${PGADMIN_PORT:-5050}"
    echo "  - Email: admin@example.com"
    echo "  - Mot de passe: admin"
    echo ""
fi

if [ "$choice" == "2" ] || [ "$choice" == "4" ] || [ "$choice" == "5" ]; then
    ODOO_PORT=$(grep ODOO_PORT .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    
    echo "Odoo Enterprise: http://localhost:${ODOO_PORT:-8069}"
    echo "  - Base de données: odoo"
    echo "  - Utilisateur: admin"
    echo "  - Mot de passe: admin"
    echo ""
fi

if [ "$choice" == "3" ] || [ "$choice" == "5" ]; then
    COOLIFY_PORT=$(grep COOLIFY_PORT .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
    
    echo "Coolify: http://localhost:${COOLIFY_PORT:-8080}"
    echo ""
fi
