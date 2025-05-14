@echo off
setlocal enabledelayedexpansion

echo ===================================
echo Initialisation du depot Git et push vers GitHub
echo ===================================
echo.

set /p username="Entrez votre nom d'utilisateur GitHub: "
set /p token="Entrez votre token d'acces personnel GitHub: "

cd ..

echo.
echo Initialisation du depot Git local...
git init
git add .
git commit -m "Initial commit"

echo.
echo Creation du depot GitHub...
curl -X POST -H "Authorization: token %token%" -H "Accept: application/vnd.github.v3+json" https://api.github.com/user/repos -d "{\"name\":\"pixee\",\"private\":false,\"description\":\"Environnements de developpement Docker pour Supabase, Odoo et Coolify\"}"

echo.
echo Configuration du depot distant...
git remote add origin https://github.com/%username%/pixee.git

echo.
echo Push vers GitHub...
git push -u origin master

echo.
echo Depot Git initialise et pousse vers GitHub avec succes!
echo.

endlocal
