# Environnements de développement

Ce projet contient les configurations Docker pour mettre en place trois environnements de développement distincts et indépendants:

- **Supabase**: Base de données PostgreSQL avec API REST et interface d'administration
- **Odoo Enterprise**: ERP complet basé sur l'image `ofleet/odoo:18-20250301-enterprise` avec sa propre base de données PostgreSQL
- **Coolify**: Plateforme de déploiement et d'hébergement avec sa propre base de données PostgreSQL

Chaque environnement est complètement isolé et peut être installé et exécuté indépendamment des autres, ou ensemble sur le même réseau Docker.

## Prérequis

- Docker et Docker Compose installés
- Au moins 4 Go de RAM disponible
- Au moins 10 Go d'espace disque
- Git installé (pour l'initialisation du dépôt)

## Structure du projet

```
.
├── coolify/                # Environnement Coolify
│   ├── docker-compose.yml  # Configuration Docker Compose pour Coolify
│   └── .env                # Variables d'environnement pour Coolify
├── odoo/                   # Environnement Odoo
│   ├── docker-compose.yml  # Configuration Docker Compose pour Odoo
│   └── .env                # Variables d'environnement pour Odoo
├── supabase/               # Environnement Supabase
│   ├── docker-compose.yml  # Configuration Docker Compose pour Supabase
│   └── .env                # Variables d'environnement pour Supabase
├── volumes/                # Volumes persistants
│   ├── db/                 # Données PostgreSQL pour Supabase
│   ├── kong/               # Configuration Kong API Gateway pour Supabase
│   ├── odoo/               # Configuration et modules Odoo
│   └── pgadmin/            # Configuration pgAdmin pour Supabase
├── install/                # Scripts d'installation et de gestion
│   ├── install.bat         # Script d'installation pour Windows
│   ├── install.sh          # Script d'installation pour Linux
│   ├── install_mac.sh      # Script d'installation pour macOS
│   ├── start.bat           # Script de démarrage pour Windows
│   ├── start.sh            # Script de démarrage pour Linux
│   ├── update.bat          # Script de mise à jour pour Windows
│   ├── update.sh           # Script de mise à jour pour Linux
│   ├── stop.bat            # Script d'arrêt pour Windows
│   ├── stop.sh             # Script d'arrêt pour Linux
│   ├── git_init.bat        # Script d'initialisation Git pour Windows
│   ├── git_init.sh         # Script d'initialisation Git pour Linux/macOS
│   ├── README_ODOO.md      # Documentation spécifique à Odoo
│   ├── README_SUPABASE.md  # Documentation spécifique à Supabase
│   └── README_COOLIFY.md   # Documentation spécifique à Coolify
├── .env                    # Variables d'environnement globales
├── docker-compose.yml      # Configuration Docker Compose principale
└── README.md               # Documentation principale
```

## Installation

### Windows

1. Ouvrez une invite de commande
2. Naviguez vers le dossier `install`
3. Exécutez `install.bat`
4. Choisissez l'environnement à installer (Supabase, Odoo ou Coolify)
5. Suivez les instructions à l'écran

### Linux

1. Ouvrez un terminal
2. Naviguez vers le dossier `install`
3. Rendez le script exécutable: `chmod +x install.sh`
4. Exécutez `./install.sh`
5. Choisissez l'environnement à installer (Supabase, Odoo ou Coolify)
6. Suivez les instructions à l'écran

### macOS

1. Ouvrez un terminal
2. Naviguez vers le dossier `install`
3. Rendez le script exécutable: `chmod +x install_mac.sh`
4. Exécutez `./install_mac.sh`
5. Choisissez l'environnement à installer (Supabase, Odoo ou Coolify)
6. Suivez les instructions à l'écran

## Gestion des environnements

### Démarrage des environnements

Pour démarrer un ou plusieurs environnements:

1. Naviguez vers le dossier `install`
2. Exécutez `start.bat` (Windows) ou `./start.sh` (Linux/macOS)
3. Choisissez l'environnement à démarrer:
   - Supabase uniquement
   - Odoo Enterprise uniquement
   - Coolify uniquement
   - Supabase + Odoo Enterprise
   - Tous les environnements

### Mise à jour des environnements

Pour mettre à jour un ou plusieurs environnements:

1. Naviguez vers le dossier `install`
2. Exécutez `update.bat` (Windows) ou `./update.sh` (Linux/macOS)
3. Choisissez l'environnement à mettre à jour:
   - Supabase uniquement
   - Odoo Enterprise uniquement
   - Coolify uniquement
   - Supabase + Odoo Enterprise
   - Tous les environnements

La mise à jour conserve toutes les données existantes.

### Arrêt des environnements

Pour arrêter un ou plusieurs environnements:

1. Naviguez vers le dossier `install`
2. Exécutez `stop.bat` (Windows) ou `./stop.sh` (Linux/macOS)
3. Choisissez l'environnement à arrêter:
   - Supabase uniquement
   - Odoo Enterprise uniquement
   - Coolify uniquement
   - Supabase + Odoo Enterprise
   - Tous les environnements

## Initialisation du dépôt Git

Pour initialiser le dépôt Git et le pousser vers GitHub:

### Prérequis

1. Créez un dépôt GitHub nommé 'pixee' manuellement sur https://github.com/new
2. Générez un token d'accès personnel avec les droits 'repo' sur https://github.com/settings/tokens

### Windows

1. Naviguez vers le dossier `install`
2. Exécutez `git_init.bat`
3. Entrez votre nom d'utilisateur GitHub et votre token d'accès personnel
4. Le script initialisera le dépôt Git local et le poussera vers GitHub

### Linux/macOS

1. Naviguez vers le dossier `install`
2. Rendez le script exécutable: `chmod +x git_init.sh`
3. Exécutez `./git_init.sh`
4. Entrez votre nom d'utilisateur GitHub et votre token d'accès personnel
5. Le script initialisera le dépôt Git local et le poussera vers GitHub

## Accès aux environnements

### Environnement Supabase

- **Studio**: http://localhost:3000
- **API REST**: http://localhost:8000
- **pgAdmin**: http://localhost:5050
  - Email: admin@example.com
  - Mot de passe: admin

### Environnement Odoo Enterprise

- **Interface web**: http://localhost:8069
  - Base de données: odoo
  - Utilisateur: admin
  - Mot de passe: admin

### Environnement Coolify

- **Interface web**: http://localhost:8080

## Configuration des environnements

### Configuration globale

Le fichier `.env` à la racine du projet contient les variables d'environnement globales qui s'appliquent à tous les environnements. Vous pouvez modifier ce fichier pour personnaliser la configuration globale, notamment:

- Ports des différents services
- Paramètres de performance pour Odoo, Supabase et Coolify
- Nom du réseau Docker

### Configuration spécifique à chaque environnement

Chaque environnement possède son propre fichier `.env` dans son répertoire respectif. Vous pouvez modifier ces fichiers pour personnaliser la configuration spécifique à chaque environnement.

#### Environnement Supabase

Le fichier `supabase/.env` contient les variables d'environnement pour configurer Supabase:

- Informations de connexion à la base de données
- Ports des différents services
- Clés JWT pour l'authentification

Pour plus de détails, consultez le fichier `install/README_SUPABASE.md`.

#### Environnement Odoo

Le fichier `odoo/.env` contient les variables d'environnement pour configurer Odoo:

- Informations de connexion à la base de données
- Ports des services Odoo
- Image Docker à utiliser

Pour plus de détails, consultez le fichier `install/README_ODOO.md`.

#### Environnement Coolify

Le fichier `coolify/.env` contient les variables d'environnement pour configurer Coolify:

- Clé secrète
- Informations de connexion à la base de données
- Port du service

Pour plus de détails, consultez le fichier `install/README_COOLIFY.md`.

## Personnalisation des performances

Vous pouvez personnaliser les paramètres de performance de chaque environnement en modifiant le fichier `.env` à la racine du projet:

### Odoo

```
# Configuration des performances Odoo
ODOO_WORKERS=2
ODOO_MAX_CRON_THREADS=1
ODOO_LIMIT_MEMORY_HARD=2684354560
ODOO_LIMIT_MEMORY_SOFT=2147483648
ODOO_LIMIT_REQUEST=8192
ODOO_LIMIT_TIME_CPU=600
ODOO_LIMIT_TIME_REAL=1200
```

### Supabase

```
# Configuration des performances Supabase
SUPABASE_MAX_CONNECTIONS=100
SUPABASE_SHARED_BUFFERS=256MB
SUPABASE_EFFECTIVE_CACHE_SIZE=1GB
SUPABASE_MAINTENANCE_WORK_MEM=64MB
SUPABASE_MAX_WORKER_PROCESSES=4
```

### Coolify

```
# Configuration des performances Coolify
COOLIFY_MAX_UPLOAD_SIZE=100M
COOLIFY_MAX_EXECUTION_TIME=300
COOLIFY_MEMORY_LIMIT=512M
```

## Maintenance manuelle des environnements

Si vous préférez gérer manuellement les environnements, vous pouvez utiliser les commandes Docker Compose directement:

### Environnement Supabase

Pour démarrer l'environnement Supabase:

```bash
cd supabase
docker-compose up -d
```

Pour arrêter l'environnement Supabase:

```bash
cd supabase
docker-compose down
```

Pour voir les logs de l'environnement Supabase:

```bash
cd supabase
docker-compose logs -f
```

### Environnement Odoo

Pour démarrer l'environnement Odoo:

```bash
cd odoo
docker-compose up -d
```

Pour arrêter l'environnement Odoo:

```bash
cd odoo
docker-compose down
```

Pour voir les logs de l'environnement Odoo:

```bash
cd odoo
docker-compose logs -f
```

### Environnement Coolify

Pour démarrer l'environnement Coolify:

```bash
cd coolify
docker-compose up -d
```

Pour arrêter l'environnement Coolify:

```bash
cd coolify
docker-compose down
```

Pour voir les logs de l'environnement Coolify:

```bash
cd coolify
docker-compose logs -f
```

### Tous les environnements ensemble

Pour démarrer tous les environnements ensemble:

```bash
docker-compose up -d
```

Pour arrêter tous les environnements:

```bash
docker-compose down
```

## Notes importantes

- L'image Odoo Enterprise utilisée est `ofleet/odoo:18-20250301-enterprise@sha256:fae3c3b165ea52c9a120ceff290667f89b80b9ec93b5a4cd5b90b79cecbecad4`
- Les données sont persistantes et stockées dans le dossier `volumes`
- Chaque environnement est complètement isolé et peut être installé et exécuté indépendamment des autres
- Les environnements utilisent des ports différents pour éviter les conflits
- Supabase utilise le port 5434 pour sa base de données PostgreSQL
- Odoo utilise le port 5433 pour sa base de données PostgreSQL
- Coolify utilise le port 5432 en interne pour sa base de données PostgreSQL (non exposé)
- Les scripts d'installation, de démarrage, de mise à jour et d'arrêt sont disponibles pour Windows, Linux et macOS
