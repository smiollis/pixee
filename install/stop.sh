#!/bin/bash

echo "==================================="
echo "Arrêt des environnements Docker"
echo "==================================="
echo ""

cd ..

echo ""
echo "Quel environnement souhaitez-vous arrêter?"
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
        echo "Arrêt de l'environnement Supabase..."
        cd supabase
        docker-compose down
        ;;
    2)
        echo ""
        echo "Arrêt de l'environnement Odoo Enterprise..."
        cd odoo
        docker-compose down
        ;;
    3)
        echo ""
        echo "Arrêt de l'environnement Coolify..."
        cd coolify
        docker-compose down
        ;;
    4)
        echo ""
        echo "Arrêt des environnements Supabase et Odoo Enterprise..."
        docker-compose stop supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
        docker-compose rm -f supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
        ;;
    5)
        echo ""
        echo "Arrêt de tous les environnements..."
        docker-compose down
        ;;
    *)
        echo ""
        echo "Choix invalide. Veuillez sélectionner une option entre 1 et 5."
        exit 1
        ;;
esac

echo ""
echo "Environnement(s) arrêté(s) avec succès!"
echo ""
