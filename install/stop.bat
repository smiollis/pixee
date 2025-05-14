@echo off
setlocal enabledelayedexpansion

echo ===================================
echo Arret des environnements Docker
echo ===================================
echo.

cd ..

echo.
echo Quel environnement souhaitez-vous arreter?
echo 1) Supabase uniquement
echo 2) Odoo Enterprise uniquement
echo 3) Coolify uniquement
echo 4) Supabase + Odoo Enterprise
echo 5) Tous les environnements
echo.

set /p choice="Votre choix (1-5): "

if "%choice%"=="1" (
    echo.
    echo Arret de l'environnement Supabase...
    cd supabase
    docker-compose down
) else if "%choice%"=="2" (
    echo.
    echo Arret de l'environnement Odoo Enterprise...
    cd odoo
    docker-compose down
) else if "%choice%"=="3" (
    echo.
    echo Arret de l'environnement Coolify...
    cd coolify
    docker-compose down
) else if "%choice%"=="4" (
    echo.
    echo Arret des environnements Supabase et Odoo Enterprise...
    docker-compose stop supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
    docker-compose rm -f supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
) else if "%choice%"=="5" (
    echo.
    echo Arret de tous les environnements...
    docker-compose down
) else (
    echo.
    echo Choix invalide. Veuillez selectionner une option entre 1 et 5.
    exit /b 1
)

echo.
echo Environnement(s) arrete(s) avec succes!
echo.

endlocal
