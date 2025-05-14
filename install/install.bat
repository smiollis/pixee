@echo off
setlocal enabledelayedexpansion

echo ===================================
echo Installation des environnements Docker
echo ===================================
echo.

cd ..

:: Verifier si Docker est installe
docker --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Docker n'est pas installe. Veuillez installer Docker Desktop pour Windows avant de continuer.
    echo Telechargez-le sur https://www.docker.com/products/docker-desktop
    exit /b 1
)

:: Verifier si Docker Compose est installe
docker-compose --version >nul 2>&1
if %errorlevel% neq 0 (
    echo Docker Compose n'est pas installe. Il est normalement inclus avec Docker Desktop pour Windows.
    echo Veuillez verifier votre installation Docker.
    exit /b 1
)

:: Verifier si Docker est en cours d'execution
docker info >nul 2>&1
if %errorlevel% neq 0 (
    echo Docker n'est pas en cours d'execution. Veuillez demarrer Docker Desktop avant de continuer.
    exit /b 1
)

:: Verifier si le reseau Docker existe deja
for /f "tokens=2 delims==" %%a in ('findstr "NETWORK_NAME" .env') do set NETWORK_NAME=%%a
set NETWORK_NAME=%NETWORK_NAME:"=%
set NETWORK_NAME=%NETWORK_NAME:'=%
if "%NETWORK_NAME%"=="" set NETWORK_NAME=app-network

:: Creer le reseau s'il n'existe pas
docker network inspect %NETWORK_NAME% >nul 2>&1
if %errorlevel% neq 0 (
    echo Creation du reseau Docker %NETWORK_NAME%...
    docker network create %NETWORK_NAME%
)

echo.
echo Quel environnement souhaitez-vous installer?
echo 1) Supabase uniquement
echo 2) Odoo Enterprise uniquement
echo 3) Coolify uniquement
echo 4) Supabase + Odoo Enterprise
echo 5) Tous les environnements
echo.

set /p choice="Votre choix (1-5): "

if "%choice%"=="1" (
    echo.
    echo Installation de l'environnement Supabase...
    
    :: Creer les repertoires necessaires
    if not exist volumes\db\pgdata mkdir volumes\db\pgdata
    if not exist volumes\db\init mkdir volumes\db\init
    if not exist volumes\kong mkdir volumes\kong
    if not exist volumes\pgadmin mkdir volumes\pgadmin
    
    :: Copier le fichier de configuration Kong
    if not exist volumes\kong\kong.yml (
        copy volumes\kong\kong.yml.example volumes\kong\kong.yml
    )
    
    :: Demarrer l'environnement Supabase
    cd supabase
    docker-compose up -d
) else if "%choice%"=="2" (
    echo.
    echo Installation de l'environnement Odoo Enterprise...
    
    :: Creer les repertoires necessaires
    if not exist volumes\odoo\db mkdir volumes\odoo\db
    if not exist volumes\odoo\addons mkdir volumes\odoo\addons
    if not exist volumes\odoo\filestore mkdir volumes\odoo\filestore
    if not exist volumes\odoo\config mkdir volumes\odoo\config
    if not exist volumes\odoo\db-init mkdir volumes\odoo\db-init
    
    :: Demarrer l'environnement Odoo
    cd odoo
    docker-compose up -d
) else if "%choice%"=="3" (
    echo.
    echo Installation de l'environnement Coolify...
    
    :: Creer les repertoires necessaires
    if not exist volumes\coolify\db mkdir volumes\coolify\db
    if not exist volumes\storage mkdir volumes\storage
    
    :: Demarrer l'environnement Coolify
    cd coolify
    docker-compose up -d
) else if "%choice%"=="4" (
    echo.
    echo Installation des environnements Supabase et Odoo Enterprise...
    
    :: Creer les repertoires necessaires pour Supabase
    if not exist volumes\db\pgdata mkdir volumes\db\pgdata
    if not exist volumes\db\init mkdir volumes\db\init
    if not exist volumes\kong mkdir volumes\kong
    if not exist volumes\pgadmin mkdir volumes\pgadmin
    
    :: Copier le fichier de configuration Kong
    if not exist volumes\kong\kong.yml (
        copy volumes\kong\kong.yml.example volumes\kong\kong.yml
    )
    
    :: Creer les repertoires necessaires pour Odoo
    if not exist volumes\odoo\db mkdir volumes\odoo\db
    if not exist volumes\odoo\addons mkdir volumes\odoo\addons
    if not exist volumes\odoo\filestore mkdir volumes\odoo\filestore
    if not exist volumes\odoo\config mkdir volumes\odoo\config
    if not exist volumes\odoo\db-init mkdir volumes\odoo\db-init
    
    :: Demarrer les environnements Supabase et Odoo
    docker-compose up -d supabase-db supabase-rest supabase-kong supabase-meta supabase-studio supabase-pgadmin odoo-db odoo-enterprise
) else if "%choice%"=="5" (
    echo.
    echo Installation de tous les environnements...
    
    :: Creer les repertoires necessaires pour Supabase
    if not exist volumes\db\pgdata mkdir volumes\db\pgdata
    if not exist volumes\db\init mkdir volumes\db\init
    if not exist volumes\kong mkdir volumes\kong
    if not exist volumes\pgadmin mkdir volumes\pgadmin
    
    :: Copier le fichier de configuration Kong
    if not exist volumes\kong\kong.yml (
        copy volumes\kong\kong.yml.example volumes\kong\kong.yml
    )
    
    :: Creer les repertoires necessaires pour Odoo
    if not exist volumes\odoo\db mkdir volumes\odoo\db
    if not exist volumes\odoo\addons mkdir volumes\odoo\addons
    if not exist volumes\odoo\filestore mkdir volumes\odoo\filestore
    if not exist volumes\odoo\config mkdir volumes\odoo\config
    if not exist volumes\odoo\db-init mkdir volumes\odoo\db-init
    
    :: Creer les repertoires necessaires pour Coolify
    if not exist volumes\coolify\db mkdir volumes\coolify\db
    if not exist volumes\storage mkdir volumes\storage
    
    :: Demarrer tous les environnements
    docker-compose up -d
) else (
    echo.
    echo Choix invalide. Veuillez selectionner une option entre 1 et 5.
    exit /b 1
)

echo.
echo Environnement(s) installe(s) avec succes!
echo.
echo Acces aux environnements:
echo.

if "%choice%"=="1" goto :supabase
if "%choice%"=="2" goto :odoo
if "%choice%"=="3" goto :coolify
if "%choice%"=="4" goto :supabase_odoo
if "%choice%"=="5" goto :all

:supabase
for /f "tokens=2 delims==" %%a in ('findstr "STUDIO_PORT" .env') do set STUDIO_PORT=%%a
set STUDIO_PORT=%STUDIO_PORT:"=%
set STUDIO_PORT=%STUDIO_PORT:'=%
if "%STUDIO_PORT%"=="" set STUDIO_PORT=3000

for /f "tokens=2 delims==" %%a in ('findstr "REST_PORT" .env') do set REST_PORT=%%a
set REST_PORT=%REST_PORT:"=%
set REST_PORT=%REST_PORT:'=%
if "%REST_PORT%"=="" set REST_PORT=8000

for /f "tokens=2 delims==" %%a in ('findstr "PGADMIN_PORT" .env') do set PGADMIN_PORT=%%a
set PGADMIN_PORT=%PGADMIN_PORT:"=%
set PGADMIN_PORT=%PGADMIN_PORT:'=%
if "%PGADMIN_PORT%"=="" set PGADMIN_PORT=5050

echo Supabase Studio: http://localhost:%STUDIO_PORT%
echo Supabase API REST: http://localhost:%REST_PORT%
echo pgAdmin: http://localhost:%PGADMIN_PORT%
echo   - Email: admin@example.com
echo   - Mot de passe: admin
echo.

if "%choice%"=="1" goto :end
if "%choice%"=="4" goto :odoo
goto :end

:odoo
for /f "tokens=2 delims==" %%a in ('findstr "ODOO_PORT" .env') do set ODOO_PORT=%%a
set ODOO_PORT=%ODOO_PORT:"=%
set ODOO_PORT=%ODOO_PORT:'=%
if "%ODOO_PORT%"=="" set ODOO_PORT=8069

echo Odoo Enterprise: http://localhost:%ODOO_PORT%
echo   - Base de donnees: odoo
echo   - Utilisateur: admin
echo   - Mot de passe: admin
echo.

if "%choice%"=="2" goto :end
if "%choice%"=="4" goto :end
goto :coolify

:coolify
for /f "tokens=2 delims==" %%a in ('findstr "COOLIFY_PORT" .env') do set COOLIFY_PORT=%%a
set COOLIFY_PORT=%COOLIFY_PORT:"=%
set COOLIFY_PORT=%COOLIFY_PORT:'=%
if "%COOLIFY_PORT%"=="" set COOLIFY_PORT=8080

echo Coolify: http://localhost:%COOLIFY_PORT%
echo.

goto :end

:supabase_odoo
goto :supabase

:all
goto :supabase

:end
echo Note: Sur Windows, vous devrez peut-etre autoriser Docker a acceder aux dossiers montes.
echo Si vous rencontrez des problemes de permissions, allez dans Docker Desktop Settings ^> Resources ^> File Sharing
echo et ajoutez les dossiers necessaires.

endlocal
