# Guide d'installation et d'utilisation de Coolify sur Windows

Ce guide vous explique comment installer et utiliser Coolify sur Windows avec Docker Desktop.

## Qu'est-ce que Coolify?

Coolify est une plateforme d'auto-hébergement open-source qui vous permet de déployer facilement des applications, des bases de données et des services sur votre propre infrastructure. C'est une alternative à des services comme Heroku, Netlify, Vercel, etc.

## Prérequis

- Windows 10 ou 11
- Docker Desktop installé et en cours d'exécution
- Au moins 4 Go de RAM disponibles pour Docker
- Au moins 10 Go d'espace disque disponible

## Installation

1. Assurez-vous que Docker Desktop est en cours d'exécution
2. Double-cliquez sur le fichier `install.bat` dans ce répertoire
3. Attendez que l'installation soit terminée
4. Accédez à Coolify à l'adresse http://localhost:8080

## Première connexion

Lors de votre première connexion à Coolify, vous devrez:

1. Créer un compte administrateur
2. Configurer votre premier serveur (qui sera automatiquement configuré pour utiliser votre Docker Desktop local)
3. Créer votre premier projet

## Fonctionnalités principales

Coolify vous permet de:

- Déployer des applications à partir de GitHub, GitLab, ou d'autres dépôts Git
- Gérer des bases de données (PostgreSQL, MySQL, MongoDB, etc.)
- Configurer des services (Redis, MinIO, etc.)
- Gérer des certificats SSL
- Configurer des domaines personnalisés
- Surveiller vos ressources
- Gérer les sauvegardes
- Et bien plus encore!

## Gestion de Coolify

- Pour arrêter Coolify: `docker-compose down` (dans le répertoire coolify)
- Pour redémarrer Coolify: `docker-compose restart` (dans le répertoire coolify)
- Pour mettre à jour Coolify: `docker-compose pull && docker-compose up -d` (dans le répertoire coolify)

## Configuration avancée

Si vous souhaitez personnaliser la configuration de Coolify, vous pouvez modifier le fichier `docker-compose.yml` dans ce répertoire. Voici quelques paramètres importants:

- `COOLIFY_SECRET_KEY`: Clé secrète utilisée pour chiffrer les données sensibles. Changez-la pour une valeur sécurisée.
- `COOLIFY_PROXY_DOMAIN`: Domaine utilisé pour accéder à Coolify. Par défaut, c'est `localhost`.
- `COOLIFY_FORCE_REDIRECT_HTTPS`: Force la redirection vers HTTPS. Activez-le si vous utilisez un certificat SSL.

## Utilisation avec Supabase

Vous pouvez utiliser Coolify pour déployer et gérer votre propre instance de Supabase:

1. Dans l'interface de Coolify, créez un nouveau projet
2. Ajoutez une nouvelle ressource de type "Service"
3. Sélectionnez "Supabase" dans la liste des services disponibles
4. Configurez les paramètres selon vos besoins
5. Déployez le service

## Ressources utiles

- [Documentation officielle de Coolify](https://coolify.io/docs)
- [GitHub de Coolify](https://github.com/coollabsio/coolify)
- [Discord de Coolify](https://coolify.io/discord)

## Dépannage

Si vous rencontrez des problèmes:

1. Vérifiez les logs de Coolify: `docker-compose logs` (dans le répertoire coolify)
2. Redémarrez Coolify: `docker-compose restart` (dans le répertoire coolify)
3. Assurez-vous que Docker Desktop dispose de suffisamment de ressources (RAM, CPU)
4. Vérifiez que les ports nécessaires (8080) ne sont pas utilisés par d'autres applications
