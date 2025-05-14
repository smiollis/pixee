@echo off
echo Installation de Coolify sur Windows avec Docker Desktop
echo =====================================================

echo Vérification de Docker Desktop...
docker info > nul 2>&1
if %errorlevel% neq 0 (
    echo Docker Desktop n'est pas en cours d'exécution. Veuillez démarrer Docker Desktop et réessayer.
    exit /b 1
)

echo Docker Desktop est en cours d'exécution.
echo.

echo Lancement de Coolify...
cd %~dp0
docker-compose up -d

if %errorlevel% neq 0 (
    echo Une erreur s'est produite lors du lancement de Coolify.
    exit /b 1
)

echo.
echo Coolify a été lancé avec succès!
echo.
echo Vous pouvez accéder à l'interface web de Coolify à l'adresse:
echo http://localhost:8080
echo.
echo Lors de la première connexion, vous devrez créer un compte administrateur.
echo.
echo Pour arrêter Coolify, exécutez: docker-compose down
echo Pour redémarrer Coolify, exécutez: docker-compose restart
echo.
echo Profitez de Coolify!
