# Odoo Enterprise - Documentation

## Présentation

Odoo est une suite d'applications d'entreprise open source qui couvre tous les besoins de votre entreprise: CRM, e-commerce, comptabilité, inventaire, point de vente, gestion de projet, etc.

Cette installation utilise l'image Docker officielle d'Odoo Enterprise version 18:
`ofleet/odoo:18-20250301-enterprise@sha256:fae3c3b165ea52c9a120ceff290667f89b80b9ec93b5a4cd5b90b79cecbecad4`

## Architecture

L'installation d'Odoo comprend les services suivants:

1. **odoo-db**: Base de données PostgreSQL dédiée à Odoo
2. **odoo-enterprise**: Serveur Odoo Enterprise

## Installation

### Prérequis

- Docker et Docker Compose installés
- Au moins 2 Go de RAM disponible
- Au moins 5 Go d'espace disque
- Au moins 1 Go d'espace disque supplémentaire pour la base de données Odoo

### Installation automatique

Utilisez le script d'installation correspondant à votre système d'exploitation:

- Windows: `install.bat` (option 2)
- Linux: `install.sh` (option 2)
- macOS: `install_mac.sh` (option 2)

### Installation manuelle

```bash
cd odoo
docker-compose up -d
```

## Accès à Odoo

- **Interface web**: http://localhost:8069
  - Base de données: odoo
  - Utilisateur: admin
  - Mot de passe: admin

## Configuration

Le fichier `odoo/.env` contient les variables d'environnement pour configurer Odoo:

```
# Base de données
ODOO_DB_HOST=odoo-db
ODOO_DB_PORT=5432
ODOO_DB_USER=odoo
ODOO_DB_PASSWORD=odoo
ODOO_DB_NAME=odoo
ODOO_ADMIN_PASSWORD=admin

# Ports
ODOO_PORT=8069
ODOO_LONGPOLLING_PORT=8072

# Image Odoo
ODOO_IMAGE=ofleet/odoo:18-20250301-enterprise@sha256:fae3c3b165ea52c9a120ceff290667f89b80b9ec93b5a4cd5b90b79cecbecad4
```

Le fichier `volumes/odoo/config/odoo.conf` contient la configuration d'Odoo:

```ini
[options]
addons_path = /mnt/extra-addons
data_dir = /var/lib/odoo
admin_passwd = admin
db_host = odoo-db
db_port = 5432
db_user = odoo
db_password = odoo
db_name = odoo
```

## Base de données dédiée

Odoo est configuré pour utiliser sa propre base de données PostgreSQL. La configuration est la suivante:

1. Le service `odoo-db` est une instance PostgreSQL dédiée à Odoo
2. Un utilisateur `odoo` avec le mot de passe `odoo` est automatiquement créé
3. Une base de données `odoo` est automatiquement créée

Ces paramètres peuvent être modifiés dans le fichier `odoo/.env`.

## Modules personnalisés

Pour ajouter des modules personnalisés à Odoo:

1. Placez vos modules dans le dossier `volumes/odoo/addons`
2. Redémarrez le service Odoo:
   ```bash
   cd odoo
   docker-compose restart
   ```
3. Mettez à jour la liste des modules dans l'interface Odoo:
   - Activez le mode développeur
   - Allez dans Applications > Mettre à jour la liste des applications
   - Recherchez et installez vos modules

## Maintenance

### Démarrer Odoo

```bash
cd odoo
docker-compose up -d
```

### Arrêter Odoo

```bash
cd odoo
docker-compose down
```

### Voir les logs

```bash
cd odoo
docker-compose logs -f
```

### Redémarrer Odoo

```bash
cd odoo
docker-compose restart
```

### Accéder au shell Odoo

```bash
docker exec -it odoo-enterprise bash
```

### Exécuter une commande Odoo

```bash
docker exec -it odoo-enterprise odoo --help
```

## Résolution des problèmes

### Problème de connexion à la base de données

Si Odoo ne peut pas se connecter à la base de données:

1. Vérifiez que le service `odoo-db` est en cours d'exécution:
   ```bash
   docker ps | grep odoo-db
   ```

2. Vérifiez que l'utilisateur `odoo` existe dans la base de données:
   ```bash
   docker exec -it odoo-db psql -U postgres -c "SELECT 1 FROM pg_roles WHERE rolname='odoo'"
   ```

3. Vérifiez que la base de données `odoo` existe:
   ```bash
   docker exec -it odoo-db psql -U postgres -c "SELECT 1 FROM pg_database WHERE datname='odoo'"
   ```

4. Vérifiez les logs d'Odoo:
   ```bash
   docker-compose logs odoo-enterprise
   ```

### Odoo ne démarre pas

Si le service Odoo ne démarre pas:

1. Vérifiez les logs:
   ```bash
   docker-compose logs odoo-enterprise
   ```

2. Vérifiez que le port 8069 n'est pas utilisé par un autre service:
   ```bash
   netstat -tuln | grep 8069
   ```

3. Vérifiez que les volumes sont correctement montés:
   ```bash
   docker inspect odoo-enterprise
