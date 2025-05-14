@echo off
setlocal enabledelayedexpansion

echo ===================================
echo Arret des environnements
echo ===================================
echo.

echo Choisissez l'environnement a arreter:
echo 1. Supabase uniquement
echo 2. Odoo Enterprise uniquement
echo 3. Coolify uniquement
echo 4. Supabase + Odoo Enterprise
echo 5. Tous les environnements
echo.

set /p choix="Votre choix (1-5): "

cd ..

if "%choix%"=="1" (
    echo.
    echo Arret de l'environnement Supabase...
    cd supabase
    docker-compose down
    cd ..
    echo.
    echo Supabase a ete arrete avec succes!
) else if "%choix%"=="2" (
    echo.
    echo Arret de l'environnement Odoo Enterprise...
    cd odoo
    docker-compose down
    cd ..
    echo.
    echo Odoo Enterprise a ete arrete avec succes!
) else if "%choix%"=="3" (
    echo.
    echo Arret de l'environnement Coolify...
    cd coolify
    docker-compose down
    cd ..
    echo.
    echo Coolify a ete arrete avec succes!
) else if "%choix%"=="4" (
    echo.
    echo Arret des environnements Supabase et Odoo Enterprise...
    cd supabase
    docker-compose down
    cd ..
    cd odoo
    docker-compose down
    cd ..
    echo.
    echo Supabase et Odoo Enterprise ont ete arretes avec succes!
) else if "%choix%"=="5" (
    echo.
    echo Arret de tous les environnements...
    docker-compose down
    echo.
    echo Tous les environnements ont ete arretes avec succes!
) else (
    echo Choix invalide. Veuillez relancer le script.
    exit /b 1
)

echo.
echo Arret termine avec succes!
echo.

endlocal
