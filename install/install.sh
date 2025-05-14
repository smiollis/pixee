#!/bin/bash

echo "==================================="
echo "Installation des environnements Docker"
echo "==================================="
echo ""

cd ..

# Vérifier si Docker est installé
if ! command -v docker &> /dev/null; then
    echo "Docker n'est pas installé. Veuillez installer Docker avant de continuer."
    exit 1
fi

# Vérifier si Docker Compose est installé
if ! command -v docker-compose &> /dev/null; then
    echo "Docker Compose n'est pas installé. Veuillez installer Docker Compose avant de continuer."
    exit 1
fi

# Vérifier si le réseau Docker existe déjà
NETWORK_NAME=$(grep NETWORK_NAME .env | cut -d '=' -f2 | tr -d '"' | tr -d "'")
if [ -z "$NETWORK_NAME" ]; then
    NETWORK_NAME="app-network"
fi

# Créer le réseau s'il n'existe pas
if ! docker network inspect $NETWORK_NAME >/dev/null 2>&1; then
    echo "Création du réseau Docker $NETWORK_NAME..."
    docker network create $NETWORK_NAME
fi

echo ""
echo "Quel environnement souhaitez-vous installer?"
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
        echo "Installation de l'environnement Supabase..."
        
        # Créer les répertoires nécessaires
        mkdir -p volumes/db/pgdata
        mkdir -p volumes/db/init
        mkdir -p volumes/kong
        mkdir -p volumes/pgadmin
        
        # Copier le fichier de configuration Kong
        if [ ! -f volumes/kong/kong.yml ]; then
            cp volumes/kong/kong.yml.example volumes/kong/kong.yml
        fi
        
        # Démarrer l'environnement Supabase
        cd supabase
        docker-compose up -d
        ;;
    2)
        echo ""
        echo "Installation de l'environnement Odoo Enterprise..."
        
        # Créer les répertoires nécessaires
        mkdir -p volumes/odoo/db
        mkdir -p volumes/odoo/addons
        mkdir -p volumes/odoo/filestore
        mkdir -p volumes/odoo/config
        mkdir -p volumes/odoo/db-init
        
        # Démarrer l'environnement Odoo
        cd odoo
        docker-compose up -d
        ;;
    3)
        echo ""
        echo "Installation de l'environnement Coolify..."
        
        # Créer les répertoires nécessaires
        mkdir -p volumes/coolify/db
        mkdir -p volumes/storage
        
        # Démarrer l'environnement Coolify
        cd coolify
        docker-compose up -d
        ;;
    4)
        echo ""
        echo "Installation des environnements Supabase et Odoo Enterprise..."
        
        # Créer les répertoires nécessaires pour Supabase
        mkdir -p volumes/db/pgdata
        mkdir -p volumes/db/init
        mkdir -p volumes/kong
        mkdir -p volumes/pgadmin
        
        # Copier le fichier de configuration Kong
        if [ ! -f volumes/kong/kong.yml ]; then
            cp volumes/kong/kong.yml.example volumes/kong/kong.yml
        fi
        
        # Créer les répertoires nécessaires pour Odoo
        mkdir -p volumes/odoo/db
        mkdir -p volumes/odoo/addons
        mkdir -p volumes/odoo/filestore
        mkdir -p volumes/odoo/config
        mkdir -p volumes/odoo/db-init
        
        # Démarrer les environnements Supabase et Odoo
        docker-compose up -d supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
        ;;
    5)
        echo ""
        echo "Installation de tous les environnements..."
        
        # Créer les répertoires nécessaires pour Supabase
        mkdir -p volumes/db/pgdata
        mkdir -p volumes/db/init
        mkdir -p volumes/kong
        mkdir -p volumes/pgadmin
        
        # Copier le fichier de configuration Kong
        if [ ! -f volumes/kong/kong.yml ]; then
            cp volumes/kong/kong.yml.example volumes/kong/kong.yml
        fi
        
        # Créer les répertoires nécessaires pour Odoo
        mkdir -p volumes/odoo/db
        mkdir -p volumes/odoo/addons
        mkdir -p volumes/odoo/filestore
        mkdir -p volumes/odoo/config
        mkdir -p volumes/odoo/db-init
        
        # Créer les répertoires nécessaires pour Coolify
        mkdir -p volumes/coolify/db
        mkdir -p volumes/storage
        
        # Démarrer tous les environnements
        docker-compose up -d
        ;;
    *)
        echo ""
        echo "Choix invalide. Veuillez sélectionner une option entre 1 et 5."
        exit 1
        ;;
esac

echo ""
echo "Environnement(s) installé(s) avec succès!"
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
