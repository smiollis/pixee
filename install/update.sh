#!/bin/bash

echo "==================================="
echo "Mise a jour des environnements"
echo "==================================="
echo ""

echo "Choisissez l'environnement a mettre a jour:"
echo "1. Supabase uniquement"
echo "2. Odoo Enterprise uniquement"
echo "3. Coolify uniquement"
echo "4. Supabase + Odoo Enterprise"
echo "5. Tous les environnements"
echo ""

read -p "Votre choix (1-5): " choix

cd ..

case $choix in
    1)
        echo ""
        echo "Mise a jour de l'environnement Supabase..."
        cd supabase
        docker-compose pull
        docker-compose down
        docker-compose up -d
        cd ..
        echo ""
        echo "Supabase a ete mis a jour avec succes!"
        ;;
    2)
        echo ""
        echo "Mise a jour de l'environnement Odoo Enterprise..."
        cd odoo
        docker-compose pull
        docker-compose down
        docker-compose up -d
        cd ..
        echo ""
        echo "Odoo Enterprise a ete mis a jour avec succes!"
        ;;
    3)
        echo ""
        echo "Mise a jour de l'environnement Coolify..."
        cd coolify
        docker-compose pull
        docker-compose down
        docker-compose up -d
        cd ..
        echo ""
        echo "Coolify a ete mis a jour avec succes!"
        ;;
    4)
        echo ""
        echo "Mise a jour des environnements Supabase et Odoo Enterprise..."
        cd supabase
        docker-compose pull
        docker-compose down
        docker-compose up -d
        cd ..
        cd odoo
        docker-compose pull
        docker-compose down
        docker-compose up -d
        cd ..
        echo ""
        echo "Supabase et Odoo Enterprise ont ete mis a jour avec succes!"
        ;;
    5)
        echo ""
        echo "Mise a jour de tous les environnements..."
        cd supabase
        docker-compose pull
        docker-compose down
        docker-compose up -d
        cd ..
        cd odoo
        docker-compose pull
        docker-compose down
        docker-compose up -d
        cd ..
        cd coolify
        docker-compose pull
        docker-compose down
        docker-compose up -d
        cd ..
        echo ""
        echo "Tous les environnements ont ete mis a jour avec succes!"
        ;;
    *)
        echo "Choix invalide. Veuillez relancer le script."
        exit 1
        ;;
esac

echo ""
echo "Mise a jour terminee avec succes!"
echo ""
