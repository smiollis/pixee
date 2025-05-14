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

# Configuration du serveur SFTP
SFTP_PORT=2222
SFTP_USER=odoo
SFTP_PASSWORD=odoo
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

## Accès SFTP

Un serveur SFTP est inclus pour faciliter l'accès aux fichiers de configuration et aux modules additionnels :

- Hôte : localhost
- Port : 2222
- Utilisateur : odoo
- Mot de passe : odoo
- Répertoires accessibles :
  - `/addons` : Modules additionnels
  - `/config` : Fichiers de configuration, y compris odoo.conf

Vous pouvez vous connecter au serveur SFTP en utilisant n'importe quel client SFTP comme FileZilla, WinSCP ou Cyberduck.

### Exemple de connexion avec FileZilla

1. Ouvrez FileZilla
2. Entrez les informations suivantes :
   - Hôte : `sftp://localhost`
   - Port : `2222`
   - Identifiant : `odoo`
   - Mot de passe : `odoo`
3. Cliquez sur "Connexion rapide"

### Exemple de connexion en ligne de commande

```bash
# Avec sftp
sftp -P 2222 odoo@localhost

# Avec scp pour télécharger un fichier
scp -P 2222 odoo@localhost:/config/odoo.conf .

# Avec scp pour uploader un fichier
scp -P 2222 mon_module.zip odoo@localhost:/addons/
```

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

Pour installer des modules additionnels, vous pouvez :

1. **Via SFTP** : Uploader les modules dans le dossier `/addons` via le serveur SFTP
2. **Manuellement** : Placer les modules dans le dossier `volumes/odoo/addons/` sur votre machine hôte

Les modules seront automatiquement détectés par Odoo au démarrage.

## Personnalisation des performances

Vous pouvez personnaliser les paramètres de performance d'Odoo de deux façons :

### 1. Via les variables d'environnement

Modifiez les variables d'environnement dans le fichier `.env` à la racine du projet :

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

Ces paramètres sont passés à l'image Docker via des variables d'environnement.

### 2. Via le fichier de configuration

Pour une configuration plus stable, modifiez directement le fichier `volumes/odoo/config/odoo.conf` :

```
; Configuration des performances
workers = 2
max_cron_threads = 1
limit_memory_hard = 2684354560
limit_memory_soft = 2147483648
limit_request = 8192
limit_time_cpu = 600
limit_time_real = 1200
```

> **Note importante** : Pour éviter les problèmes de substitution de variables, le fichier `odoo.conf` utilise maintenant des valeurs fixes au lieu des variables d'environnement. Si vous modifiez les valeurs dans le fichier `.env`, vous devrez également les mettre à jour manuellement dans le fichier `odoo.conf`.

## Modification du fichier de configuration Odoo

Pour modifier le fichier de configuration d'Odoo (`odoo.conf`), vous pouvez :

1. **Via SFTP** : Accéder au fichier `/config/odoo.conf` via le serveur SFTP, le télécharger, le modifier et le réuploader
2. **Manuellement** : Modifier le fichier `volumes/odoo/config/odoo.conf` sur votre machine hôte

Après avoir modifié le fichier de configuration, vous devez redémarrer le conteneur Odoo pour que les changements prennent effet :

```bash
docker restart odoo-enterprise
```

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

Pour voir les logs du serveur SFTP :

```bash
docker logs -f odoo-sftp
```

## Dépannage

### Problèmes de permissions

Si vous rencontrez des problèmes de permissions sur les dossiers montés, assurez-vous que Docker a les droits d'accès aux dossiers concernés.

### Problèmes de connexion à la base de données

Si Odoo ne peut pas se connecter à la base de données, vérifiez que le conteneur `odoo-db` est bien démarré et que les informations de connexion sont correctes dans le fichier `volumes/odoo/config/odoo.conf`.

### Problèmes de mémoire

Si Odoo consomme trop de mémoire, ajustez les paramètres `ODOO_LIMIT_MEMORY_HARD` et `ODOO_LIMIT_MEMORY_SOFT` dans le fichier `.env` à la racine du projet.

### Problèmes de connexion SFTP

Si vous ne pouvez pas vous connecter au serveur SFTP :

1. Vérifiez que le conteneur `odoo-sftp` est bien démarré : `docker ps | grep odoo-sftp`
2. Vérifiez que le port 2222 est bien ouvert : `netstat -an | grep 2222`
3. Vérifiez les logs du serveur SFTP : `docker logs -f odoo-sftp`
