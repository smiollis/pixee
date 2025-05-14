# Guide d'utilisation de Coolify

Ce document explique comment utiliser l'environnement Coolify dans ce projet.

## Présentation

Coolify est une plateforme d'auto-hébergement open source qui vous permet de déployer facilement des applications, des bases de données et des services sur votre propre infrastructure. C'est une alternative à des services comme Heroku ou Netlify, mais entièrement sous votre contrôle.

## Composants

L'environnement Coolify est composé de plusieurs services :

1. **coolify** : L'application principale Coolify
2. **coolify-db** : Base de données PostgreSQL pour Coolify
3. **coolify-redis** : Cache Redis pour Coolify

## Configuration

La configuration de Coolify se fait via plusieurs fichiers :

1. **`.env`** à la racine du projet : Contient les variables d'environnement globales
2. **`coolify/.env`** : Contient les variables d'environnement spécifiques à Coolify

### Variables d'environnement importantes

```
# Ports
COOLIFY_PORT=8080
COOLIFY_SECRET_KEY=votre_clé_secrète
COOLIFY_DATABASE_URL=postgresql://coolify:coolify@coolify-db:5432/coolify
COOLIFY_REDIS_URL=redis://coolify-redis:6379
```

## Installation

Pour installer uniquement l'environnement Coolify :

### Windows

```
cd install
install.bat
```

Puis sélectionnez l'option "3) Coolify uniquement".

### Linux

```
cd install
chmod +x install.sh
./install.sh
```

Puis sélectionnez l'option "3) Coolify uniquement".

### macOS

```
cd install
chmod +x install_mac.sh
./install_mac.sh
```

Puis sélectionnez l'option "3) Coolify uniquement".

## Démarrage et arrêt

### Démarrage

Pour démarrer uniquement l'environnement Coolify :

#### Windows

```
cd install
start.bat
```

Puis sélectionnez l'option "3) Coolify uniquement".

#### Linux/macOS

```
cd install
./start.sh
```

Puis sélectionnez l'option "3) Coolify uniquement".

### Arrêt

Pour arrêter uniquement l'environnement Coolify :

#### Windows

```
cd install
stop.bat
```

Puis sélectionnez l'option "3) Coolify uniquement".

#### Linux/macOS

```
cd install
./stop.sh
```

Puis sélectionnez l'option "3) Coolify uniquement".

## Mise à jour

Pour mettre à jour uniquement l'environnement Coolify :

### Windows

```
cd install
update.bat
```

Puis sélectionnez l'option "3) Coolify uniquement".

### Linux/macOS

```
cd install
./update.sh
```

Puis sélectionnez l'option "3) Coolify uniquement".

## Accès à l'interface web

Une fois l'environnement Coolify démarré, vous pouvez y accéder via votre navigateur web :

- URL : http://localhost:8080

Lors de la première connexion, vous devrez créer un compte administrateur.

## Structure des dossiers

```
volumes/
├── coolify/
│   └── db/         # Données PostgreSQL pour Coolify
└── storage/        # Stockage pour les applications déployées
```

## Utilisation de Coolify

### Première connexion

1. Accédez à http://localhost:8080
2. Créez un compte administrateur
3. Configurez votre instance Coolify

### Déploiement d'applications

Coolify vous permet de déployer facilement des applications à partir de différentes sources :

1. **GitHub/GitLab** : Connectez votre compte GitHub ou GitLab pour déployer directement depuis vos dépôts
2. **Docker** : Déployez des images Docker depuis Docker Hub ou d'autres registres
3. **Bases de données** : Déployez des bases de données comme PostgreSQL, MySQL, MongoDB, etc.

### Gestion des ressources

Coolify vous permet de gérer facilement vos ressources :

1. **Applications** : Gérez vos applications déployées
2. **Bases de données** : Gérez vos bases de données
3. **Services** : Gérez d'autres services comme Redis, RabbitMQ, etc.
4. **Environnements** : Créez et gérez différents environnements (production, staging, développement)

### Surveillance

Coolify offre des fonctionnalités de surveillance pour vos applications et services :

1. **Logs** : Consultez les logs de vos applications
2. **Métriques** : Surveillez les performances de vos applications
3. **Alertes** : Configurez des alertes pour être notifié en cas de problème

## Intégration avec d'autres services

Coolify peut être intégré avec d'autres services de ce projet :

### Intégration avec Supabase

Vous pouvez utiliser Coolify pour déployer des applications qui utilisent Supabase comme backend :

1. Configurez l'URL de l'API Supabase dans votre application : `http://supabase-kong:8000`
2. Utilisez les variables d'environnement pour configurer l'accès à Supabase

### Intégration avec Odoo

Vous pouvez utiliser Coolify pour déployer des applications qui se connectent à Odoo :

1. Configurez l'URL de l'API Odoo dans votre application : `http://odoo-enterprise:8069`
2. Utilisez les variables d'environnement pour configurer l'accès à Odoo

## Sauvegarde et restauration

### Sauvegarde

Pour sauvegarder la base de données Coolify :

```bash
docker exec -t coolify-db pg_dump -U coolify coolify > coolify_backup.sql
```

### Restauration

Pour restaurer la base de données Coolify à partir d'une sauvegarde :

```bash
cat coolify_backup.sql | docker exec -i coolify-db psql -U coolify -d coolify
```

## Logs

Pour voir les logs des différents services :

```bash
# Application Coolify
docker logs -f coolify

# Base de données PostgreSQL pour Coolify
docker logs -f coolify-db

# Cache Redis pour Coolify
docker logs -f coolify-redis
```

## Dépannage

### Problèmes de permissions

Si vous rencontrez des problèmes de permissions sur les dossiers montés, assurez-vous que Docker a les droits d'accès aux dossiers concernés.

### Problèmes de connexion à la base de données

Si Coolify ne peut pas se connecter à sa base de données, vérifiez que le conteneur `coolify-db` est bien démarré et que les informations de connexion sont correctes dans le fichier `coolify/.env`.

### Problèmes de déploiement

Si vous rencontrez des problèmes lors du déploiement d'applications avec Coolify :

1. Vérifiez les logs de l'application Coolify
2. Assurez-vous que Docker a suffisamment de ressources (CPU, mémoire)
3. Vérifiez que les ports nécessaires sont disponibles
