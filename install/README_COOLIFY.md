# Coolify - Documentation

## Présentation

Coolify est une plateforme d'auto-hébergement open source qui vous permet de déployer facilement vos applications, bases de données et services. C'est une alternative à Heroku, Netlify, Vercel, etc.

## Architecture

L'installation de Coolify comprend les services suivants:

1. **coolify**: Serveur principal de Coolify
2. **coolify-db**: Base de données PostgreSQL pour Coolify
3. **coolify-redis**: Serveur Redis pour la mise en cache et les files d'attente

## Installation

### Prérequis

- Docker et Docker Compose installés
- Au moins 2 Go de RAM disponible
- Au moins 5 Go d'espace disque

### Installation automatique

Utilisez le script d'installation correspondant à votre système d'exploitation:

- Windows: `install.bat` (option 3)
- Linux: `install.sh` (option 3)
- macOS: `install_mac.sh` (option 3)

### Installation manuelle

```bash
cd coolify
docker-compose up -d
```

## Accès à Coolify

- **Interface web**: http://localhost:8080

Lors de la première connexion, vous devrez créer un compte administrateur.

## Configuration

Le fichier `coolify/.env` contient les variables d'environnement pour configurer Coolify:

```
# Sécurité
COOLIFY_SECRET_KEY=changeme

# Base de données
COOLIFY_DB_USER=postgres
COOLIFY_DB_PASSWORD=postgres
COOLIFY_DB_NAME=coolify
COOLIFY_DATABASE_URL=postgresql://postgres:postgres@coolify-db:5432/coolify

# Port
COOLIFY_PORT=8080

# Image
COOLIFY_IMAGE=ghcr.io/coollabsio/coolify:latest
```

## Fonctionnalités

Coolify offre de nombreuses fonctionnalités:

- Déploiement automatique depuis GitHub, GitLab, etc.
- Support pour de nombreux frameworks et langages
- Gestion des bases de données
- Gestion des certificats SSL
- Surveillance des applications
- Gestion des domaines
- Gestion des variables d'environnement
- Gestion des secrets
- Gestion des sauvegardes
- Gestion des logs
- Gestion des utilisateurs et des équipes

## Utilisation

### Déployer une application

1. Connectez-vous à l'interface web de Coolify
2. Cliquez sur "New Resource" > "Application"
3. Sélectionnez votre source de code (GitHub, GitLab, etc.)
4. Configurez les paramètres de déploiement
5. Cliquez sur "Deploy"

### Gérer une base de données

1. Connectez-vous à l'interface web de Coolify
2. Cliquez sur "New Resource" > "Database"
3. Sélectionnez le type de base de données
4. Configurez les paramètres
5. Cliquez sur "Create"

## Maintenance

### Démarrer Coolify

```bash
cd coolify
docker-compose up -d
```

### Arrêter Coolify

```bash
cd coolify
docker-compose down
```

### Voir les logs

```bash
cd coolify
docker-compose logs -f
```

### Redémarrer Coolify

```bash
cd coolify
docker-compose restart
```

### Mettre à jour Coolify

```bash
cd coolify
docker-compose pull
docker-compose up -d
```

## Résolution des problèmes

### Problème de connexion à l'interface web

Si vous ne pouvez pas accéder à l'interface web de Coolify:

1. Vérifiez que tous les services sont en cours d'exécution:
   ```bash
   docker-compose ps
   ```

2. Vérifiez les logs du service Coolify:
   ```bash
   docker-compose logs coolify
   ```

3. Assurez-vous que le port 8080 n'est pas utilisé par un autre service:
   ```bash
   netstat -tuln | grep 8080
   ```

### Problème de connexion à la base de données

Si Coolify ne peut pas se connecter à sa base de données:

1. Vérifiez que le service `coolify-db` est en cours d'exécution:
   ```bash
   docker ps | grep coolify-db
   ```

2. Vérifiez les logs de la base de données:
   ```bash
   docker-compose logs coolify-db
   ```

3. Vérifiez la configuration de la base de données dans le fichier `.env`

### Réinitialiser Coolify

Si vous souhaitez réinitialiser complètement Coolify:

```bash
cd coolify
docker-compose down -v
docker-compose up -d
```

**Attention**: Cette opération supprimera toutes les données de Coolify.

## Ressources

- [Documentation officielle](https://coolify.io/docs)
- [GitHub](https://github.com/coollabsio/coolify)
- [Discord](https://discord.gg/coolify)
