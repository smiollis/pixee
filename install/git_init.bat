@echo off
setlocal enabledelayedexpansion

echo ===================================
echo Initialisation du depot Git et push vers GitHub
echo ===================================
echo.

echo Avant d'executer ce script, assurez-vous d'avoir:
echo 1. Cree un depot GitHub nomme 'pixee' manuellement sur https://github.com/new
echo 2. Genere un token d'acces personnel avec les droits 'repo' sur https://github.com/settings/tokens
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
echo Configuration du depot distant...
git remote add origin https://github.com/%username%/pixee.git

echo.
echo Push vers GitHub...
git push -u origin main

echo.
echo Depot Git initialise et pousse vers GitHub avec succes!
echo.

endlocal
