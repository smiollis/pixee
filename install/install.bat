@echo off
setlocal enabledelayedexpansion

echo ===================================
echo Installation de l'environnement de developpement
echo ===================================
echo.

echo Choisissez l'environnement a installer:
echo 1. Supabase (environnement dedie)
echo 2. Odoo Enterprise (environnement dedie)
echo 3. Coolify (environnement dedie)
echo.

set /p choix="Votre choix (1-3): "

if "%choix%"=="1" (
    echo.
    echo Installation de l'environnement Supabase...
    cd ..
    cd supabase
    docker-compose up -d
    echo.
    echo Supabase est accessible a l'adresse:
    echo - Studio: http://localhost:3000
    echo - API REST: http://localhost:8000
    echo - pgAdmin: http://localhost:5050
    echo.
    echo Identifiants pgAdmin:
    echo - Email: admin@example.com
    echo - Mot de passe: admin
) else if "%choix%"=="2" (
    echo.
    echo Installation de l'environnement Odoo Enterprise...
    cd ..
    cd odoo
    docker-compose up -d
    echo.
    echo Odoo est accessible a l'adresse:
    echo - Interface web: http://localhost:8069
    echo.
    echo Identifiants Odoo:
    echo - Base de donnees: odoo
    echo - Utilisateur: admin
    echo - Mot de passe: admin
) else if "%choix%"=="3" (
    echo.
    echo Installation de l'environnement Coolify...
    cd ..
    cd coolify
    docker-compose up -d
    echo.
    echo Coolify est accessible a l'adresse:
    echo - Interface web: http://localhost:8080
) else (
    echo Choix invalide. Veuillez relancer le script.
    exit /b 1
)

echo.
echo Installation terminee avec succes!
echo.

endlocal
