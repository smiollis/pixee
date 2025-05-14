# Guide d'utilisation de Supabase

Ce document explique comment utiliser l'environnement Supabase dans ce projet.

## Présentation

Supabase est une alternative open source à Firebase qui offre une base de données PostgreSQL avec une API REST automatique, une authentification, des fonctions en temps réel et un stockage de fichiers. Dans ce projet, nous utilisons une configuration Docker personnalisée pour déployer Supabase localement.

## Composants

L'environnement Supabase est composé de plusieurs services :

1. **supabase-db** : Base de données PostgreSQL
2. **supabase-rest** : API REST PostgREST
3. **supabase-kong** : API Gateway Kong
4. **supabase-meta** : Service de métadonnées PostgreSQL
5. **supabase-studio** : Interface d'administration
6. **supabase-pgadmin** : Interface d'administration PostgreSQL

## Configuration

La configuration de Supabase se fait via plusieurs fichiers :

1. **`.env`** à la racine du projet : Contient les variables d'environnement globales
2. **`supabase/.env`** : Contient les variables d'environnement spécifiques à Supabase
3. **`volumes/kong/kong.yml`** : Configuration de l'API Gateway Kong

### Variables d'environnement importantes

```
# Ports
POSTGRES_PORT=5432
STUDIO_PORT=3000
REST_PORT=8000
KONG_PORT=8443
PGADMIN_PORT=5050

# Configuration des performances Supabase
SUPABASE_MAX_CONNECTIONS=100
SUPABASE_SHARED_BUFFERS=256MB
SUPABASE_EFFECTIVE_CACHE_SIZE=1GB
SUPABASE_MAINTENANCE_WORK_MEM=64MB
SUPABASE_MAX_WORKER_PROCESSES=4
```

## Installation

Pour installer uniquement l'environnement Supabase :

### Windows

```
cd install
install.bat
```

Puis sélectionnez l'option "1) Supabase uniquement".

### Linux

```
cd install
chmod +x install.sh
./install.sh
```

Puis sélectionnez l'option "1) Supabase uniquement".

### macOS

```
cd install
chmod +x install_mac.sh
./install_mac.sh
```

Puis sélectionnez l'option "1) Supabase uniquement".

## Démarrage et arrêt

### Démarrage

Pour démarrer uniquement l'environnement Supabase :

#### Windows

```
cd install
start.bat
```

Puis sélectionnez l'option "1) Supabase uniquement".

#### Linux/macOS

```
cd install
./start.sh
```

Puis sélectionnez l'option "1) Supabase uniquement".

### Arrêt

Pour arrêter uniquement l'environnement Supabase :

#### Windows

```
cd install
stop.bat
```

Puis sélectionnez l'option "1) Supabase uniquement".

#### Linux/macOS

```
cd install
./stop.sh
```

Puis sélectionnez l'option "1) Supabase uniquement".

## Mise à jour

Pour mettre à jour uniquement l'environnement Supabase :

### Windows

```
cd install
update.bat
```

Puis sélectionnez l'option "1) Supabase uniquement".

### Linux/macOS

```
cd install
./update.sh
```

Puis sélectionnez l'option "1) Supabase uniquement".

## Accès aux interfaces

Une fois l'environnement Supabase démarré, vous pouvez accéder aux différentes interfaces :

### Supabase Studio

- URL : http://localhost:3000
- Interface d'administration principale pour gérer votre base de données, vos API, vos authentifications, etc.

### API REST

- URL : http://localhost:8000
- Point d'entrée pour l'API REST générée automatiquement à partir de votre schéma de base de données

### pgAdmin

- URL : http://localhost:5050
- Email : admin@example.com
- Mot de passe : admin
- Interface d'administration PostgreSQL pour gérer directement votre base de données

## Structure des dossiers

```
volumes/
├── db/
│   ├── pgdata/       # Données PostgreSQL
│   └── init/         # Scripts d'initialisation de la base de données
├── kong/
│   └── kong.yml      # Configuration de l'API Gateway Kong
└── pgadmin/          # Données pgAdmin
```

## Utilisation de l'API REST

L'API REST est générée automatiquement à partir de votre schéma de base de données. Vous pouvez l'utiliser pour effectuer des opérations CRUD sur vos tables.

### Exemple de requête

```bash
# Récupérer tous les enregistrements d'une table
curl -X GET "http://localhost:8000/rest/v1/ma_table" \
  -H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0"

# Insérer un nouvel enregistrement
curl -X POST "http://localhost:8000/rest/v1/ma_table" \
  -H "apikey: eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZS1kZW1vIiwicm9sZSI6ImFub24iLCJleHAiOjE5ODM4MTI5OTZ9.CRXP1A7WOeoJeXxjNni43kdQwgnWNReilDMblYTn_I0" \
  -H "Content-Type: application/json" \
  -d '{"colonne1": "valeur1", "colonne2": "valeur2"}'
```

## Personnalisation des performances

Vous pouvez personnaliser les paramètres de performance de Supabase en modifiant les variables d'environnement dans le fichier `.env` à la racine du projet :

```
# Configuration des performances Supabase
SUPABASE_MAX_CONNECTIONS=100
SUPABASE_SHARED_BUFFERS=256MB
SUPABASE_EFFECTIVE_CACHE_SIZE=1GB
SUPABASE_MAINTENANCE_WORK_MEM=64MB
SUPABASE_MAX_WORKER_PROCESSES=4
```

Ces paramètres sont passés à l'image Docker PostgreSQL via des variables d'environnement.

## Sauvegarde et restauration

### Sauvegarde

Pour sauvegarder la base de données Supabase :

```bash
docker exec -t supabase-db pg_dump -U postgres postgres > supabase_backup.sql
```

### Restauration

Pour restaurer la base de données Supabase à partir d'une sauvegarde :

```bash
cat supabase_backup.sql | docker exec -i supabase-db psql -U postgres -d postgres
```

## Logs

Pour voir les logs des différents services :

```bash
# Base de données PostgreSQL
docker logs -f supabase-db

# API REST
docker logs -f supabase-rest

# API Gateway Kong
docker logs -f supabase-kong

# Service de métadonnées
docker logs -f supabase-meta

# Interface d'administration
docker logs -f supabase-studio

# pgAdmin
docker logs -f supabase-pgadmin
```

## Dépannage

### Problèmes de permissions

Si vous rencontrez des problèmes de permissions sur les dossiers montés, assurez-vous que Docker a les droits d'accès aux dossiers concernés.

### Problèmes de connexion à la base de données

Si vous ne pouvez pas vous connecter à la base de données via pgAdmin ou l'API REST, vérifiez que le conteneur `supabase-db` est bien démarré et que les informations de connexion sont correctes.

### Problèmes d'API REST

Si l'API REST ne fonctionne pas correctement, vérifiez la configuration de Kong dans le fichier `volumes/kong/kong.yml` et assurez-vous que les services `supabase-rest` et `supabase-kong` sont bien démarrés.
