# Supabase - Documentation

## Présentation

Supabase est une alternative open source à Firebase qui fournit tous les services backend dont vous avez besoin pour développer votre application:

- Base de données PostgreSQL
- API REST automatique
- Authentification et autorisation
- Stockage de fichiers
- Interface d'administration

## Architecture

L'installation de Supabase comprend les services suivants:

1. **supabase-db**: Base de données PostgreSQL
2. **supabase-rest**: API REST automatique (PostgREST)
3. **supabase-kong**: API Gateway pour gérer les requêtes
4. **supabase-meta**: Service de métadonnées pour la base de données
5. **supabase-studio**: Interface d'administration
6. **supabase-pgadmin**: Interface de gestion de la base de données

## Installation

### Prérequis

- Docker et Docker Compose installés
- Au moins 2 Go de RAM disponible
- Au moins 5 Go d'espace disque

### Installation automatique

Utilisez le script d'installation correspondant à votre système d'exploitation:

- Windows: `install.bat` (option 1)
- Linux: `install.sh` (option 1)
- macOS: `install_mac.sh` (option 1)

### Installation manuelle

```bash
cd supabase
docker-compose up -d
```

## Accès aux services

- **Studio**: http://localhost:3000
- **API REST**: http://localhost:8000
- **pgAdmin**: http://localhost:5050
  - Email: admin@example.com
  - Mot de passe: admin

## Configuration

Le fichier `supabase/.env` contient les variables d'environnement pour configurer Supabase:

```
# Base de données PostgreSQL
POSTGRES_PASSWORD=postgres
POSTGRES_USER=postgres
POSTGRES_DB=postgres
POSTGRES_PORT=5434

# JWT Secrets
JWT_SECRET=your-super-secret-jwt-token-with-at-least-32-characters
ANON_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...
SERVICE_ROLE_KEY=eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...

# Ports
STUDIO_PORT=3000
REST_PORT=8000
KONG_PORT=8443
PGADMIN_PORT=5050

# PgAdmin
PGADMIN_DEFAULT_EMAIL=admin@example.com
PGADMIN_DEFAULT_PASSWORD=admin
```

## Utilisation avec Odoo

Supabase est configuré pour être accessible depuis Odoo. Pour connecter Odoo à la base de données Supabase:

1. Assurez-vous que le service `supabase-db` est en cours d'exécution
2. Utilisez les informations de connexion suivantes dans Odoo:
   - Hôte: `supabase-db`
   - Port: `5432`
   - Utilisateur: `postgres`
   - Mot de passe: `postgres`
   - Base de données: `postgres`

## Maintenance

### Démarrer Supabase

```bash
cd supabase
docker-compose up -d
```

### Arrêter Supabase

```bash
cd supabase
docker-compose down
```

### Voir les logs

```bash
cd supabase
docker-compose logs -f
```

### Redémarrer un service spécifique

```bash
cd supabase
docker-compose restart [service]
```

### Sauvegarder la base de données

```bash
docker exec -t supabase-db pg_dump -U postgres postgres > backup.sql
```

### Restaurer la base de données

```bash
cat backup.sql | docker exec -i supabase-db psql -U postgres -d postgres
```

## Résolution des problèmes

### Problème de connexion à la base de données

Si vous ne pouvez pas vous connecter à la base de données:

1. Vérifiez que le service `supabase-db` est en cours d'exécution:
   ```bash
   docker ps | grep supabase-db
   ```

2. Vérifiez les logs de la base de données:
   ```bash
   docker-compose logs supabase-db
   ```

3. Assurez-vous que les ports ne sont pas utilisés par d'autres services:
   ```bash
   netstat -tuln | grep 5432
   ```

### Studio ne se charge pas

Si l'interface Studio ne se charge pas:

1. Vérifiez que tous les services sont en cours d'exécution:
   ```bash
   docker-compose ps
   ```

2. Vérifiez les logs du service Studio:
   ```bash
   docker-compose logs supabase-studio
   ```

3. Assurez-vous que le port 3000 n'est pas utilisé par un autre service:
   ```bash
   netstat -tuln | grep 3000
