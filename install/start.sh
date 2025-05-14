#!/bin/bash

echo "==================================="
echo "Demarrage des environnements"
echo "==================================="
echo ""

echo "Choisissez l'environnement a demarrer:"
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
        echo "Demarrage de l'environnement Supabase..."
        docker-compose up -d supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin
        echo ""
        echo "Supabase est accessible a l'adresse:"
        echo "- Studio: http://localhost:3000"
        echo "- API REST: http://localhost:8000"
        echo "- pgAdmin: http://localhost:5050"
        ;;
    2)
        echo ""
        echo "Demarrage de l'environnement Odoo Enterprise..."
        docker-compose up -d odoo-db odoo-enterprise
        echo ""
        echo "Odoo est accessible a l'adresse:"
        echo "- Interface web: http://localhost:8069"
        ;;
    3)
        echo ""
        echo "Demarrage de l'environnement Coolify..."
        docker-compose up -d coolify coolify-db coolify-redis
        echo ""
        echo "Coolify est accessible a l'adresse:"
        echo "- Interface web: http://localhost:8080"
        ;;
    4)
        echo ""
        echo "Demarrage des environnements Supabase et Odoo Enterprise..."
        docker-compose up -d supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
        echo ""
        echo "Supabase est accessible a l'adresse:"
        echo "- Studio: http://localhost:3000"
        echo "- API REST: http://localhost:8000"
        echo "- pgAdmin: http://localhost:5050"
        echo ""
        echo "Odoo est accessible a l'adresse:"
        echo "- Interface web: http://localhost:8069"
        ;;
    5)
        echo ""
        echo "Demarrage de tous les environnements..."
        docker-compose up -d
        echo ""
        echo "Supabase est accessible a l'adresse:"
        echo "- Studio: http://localhost:3000"
        echo "- API REST: http://localhost:8000"
        echo "- pgAdmin: http://localhost:5050"
        echo ""
        echo "Odoo est accessible a l'adresse:"
        echo "- Interface web: http://localhost:8069"
        echo ""
        echo "Coolify est accessible a l'adresse:"
        echo "- Interface web: http://localhost:8080"
        ;;
    *)
        echo "Choix invalide. Veuillez relancer le script."
        exit 1
        ;;
esac

echo ""
echo "Demarrage termine avec succes!"
echo ""
