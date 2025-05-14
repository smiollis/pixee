# Guide d'utilisation d'Odoo Enterprise

Ce document explique comment utiliser l'environnement Odoo Enterprise dans ce projet.

## Présentation

Odoo Enterprise est un ERP complet qui offre une suite d'applications métier intégrées. Dans ce projet, nous utilisons l'image Docker officielle d'Odoo Enterprise `ofleet/odoo:18-20250301-enterprise` qui inclut toutes les fonctionnalités de la version Enterprise.

## Configuration

La configuration d'Odoo se fait via plusieurs fichiers :

1. **`.env`** à la racine du projet : Contient les variables d'environnement globales
2. **`odoo/.env`** : Contient les variables d'environnement spécifiques à Odoo
3. **`volumes/odoo/config/odoo.conf`** : Fichier de configuration d'Odoo

### Variables d'environnement importantes

```
# Image Odoo Enterprise
ODOO_IMAGE=ofleet/odoo:18-20250301-enterprise@sha256:fae3c3b165ea52c9a120ceff290667f89b80b9ec93b5a4cd5b90b79cecbecad4

# Configuration des performances Odoo
ODOO_WORKERS=2
ODOO_MAX_CRON_THREADS=1
ODOO_LIMIT_MEMORY_HARD=2684354560
ODOO_LIMIT_MEMORY_SOFT=2147483648
ODOO_LIMIT_REQUEST=8192
ODOO_LIMIT_TIME_CPU=600
ODOO_LIMIT_TIME_REAL=1200

# Ports
ODOO_PORT=8069
ODOO_LONGPOLLING_PORT=8072
```

## Installation

Pour installer uniquement l'environnement Odoo Enterprise :

### Windows

```
cd install
install.bat
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

### Linux

```
cd install
chmod +x install.sh
./install.sh
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

### macOS

```
cd install
chmod +x install_mac.sh
./install_mac.sh
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

## Démarrage et arrêt

### Démarrage

Pour démarrer uniquement l'environnement Odoo Enterprise :

#### Windows

```
cd install
start.bat
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

#### Linux/macOS

```
cd install
./start.sh
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

### Arrêt

Pour arrêter uniquement l'environnement Odoo Enterprise :

#### Windows

```
cd install
stop.bat
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

#### Linux/macOS

```
cd install
./stop.sh
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

## Mise à jour

Pour mettre à jour uniquement l'environnement Odoo Enterprise :

### Windows

```
cd install
update.bat
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

### Linux/macOS

```
cd install
./update.sh
```

Puis sélectionnez l'option "2) Odoo Enterprise uniquement".

## Accès à l'interface web

Une fois l'environnement Odoo Enterprise démarré, vous pouvez y accéder via votre navigateur web :

- URL : http://localhost:8069
- Base de données : odoo
- Utilisateur : admin
- Mot de passe : admin

## Structure des dossiers

```
volumes/odoo/
├── addons/         # Modules additionnels
├── config/         # Configuration Odoo
│   └── odoo.conf   # Fichier de configuration principal
├── db/             # Données PostgreSQL
├── db-init/        # Scripts d'initialisation de la base de données
└── filestore/      # Stockage des fichiers (pièces jointes, etc.)
```

## Installation de modules additionnels

Pour installer des modules additionnels, placez-les dans le dossier `volumes/odoo/addons/`. Ils seront automatiquement détectés par Odoo au démarrage.

## Personnalisation des performances

Vous pouvez personnaliser les paramètres de performance d'Odoo en modifiant les variables d'environnement dans le fichier `.env` à la racine du projet :

```
# Configuration des performances Odoo
ODOO_WORKERS=2                    # Nombre de workers (processus)
ODOO_MAX_CRON_THREADS=1           # Nombre de threads pour les tâches planifiées
ODOO_LIMIT_MEMORY_HARD=2684354560 # Limite mémoire dure (2.5 Go)
ODOO_LIMIT_MEMORY_SOFT=2147483648 # Limite mémoire souple (2 Go)
ODOO_LIMIT_REQUEST=8192           # Nombre maximum de requêtes
ODOO_LIMIT_TIME_CPU=600           # Limite de temps CPU (10 minutes)
ODOO_LIMIT_TIME_REAL=1200         # Limite de temps réel (20 minutes)
```

Ces paramètres sont utilisés dans le fichier `volumes/odoo/config/odoo.conf` et sont passés à l'image Docker via des variables d'environnement.

## Sauvegarde et restauration

### Sauvegarde

Pour sauvegarder la base de données Odoo :

```bash
docker exec -t odoo-db pg_dump -U odoo odoo > odoo_backup.sql
```

### Restauration

Pour restaurer la base de données Odoo à partir d'une sauvegarde :

```bash
cat odoo_backup.sql | docker exec -i odoo-db psql -U odoo -d odoo
```

## Logs

Pour voir les logs d'Odoo :

```bash
docker logs -f odoo-enterprise
```

Pour voir les logs de la base de données PostgreSQL d'Odoo :

```bash
docker logs -f odoo-db
```

## Dépannage

### Problèmes de permissions

Si vous rencontrez des problèmes de permissions sur les dossiers montés, assurez-vous que Docker a les droits d'accès aux dossiers concernés.

### Problèmes de connexion à la base de données

Si Odoo ne peut pas se connecter à la base de données, vérifiez que le conteneur `odoo-db` est bien démarré et que les informations de connexion sont correctes dans le fichier `volumes/odoo/config/odoo.conf`.

### Problèmes de mémoire

Si Odoo consomme trop de mémoire, ajustez les paramètres `ODOO_LIMIT_MEMORY_HARD` et `ODOO_LIMIT_MEMORY_SOFT` dans le fichier `.env` à la racine du projet.
