# Guide d'importation des produits dans Supabase

Ce guide explique comment créer une table pour les produits dans Supabase et comment importer les données du fichier CSV `produits_ok_source.csv`.

## Prérequis

- Un compte Supabase avec un projet créé
- Accès à l'interface d'administration de Supabase
- Le fichier CSV `produits_ok_source.csv` contenant les données des produits

## Étapes d'importation

### 1. Création de la table

Utilisez le script SQL fourni dans le fichier `create_table_produits_supabase.sql` pour créer la table des produits. Ce script peut être exécuté de plusieurs façons :

- **Via l'interface SQL de Supabase** :
  - Connectez-vous à votre projet Supabase
  - Allez dans la section "SQL Editor"
  - Créez une nouvelle requête (bouton "New Query")
  - Copiez-collez le contenu du fichier `create_table_produits_supabase.sql`
  - Exécutez le script en cliquant sur "Run"
  - **Important** : Supabase Studio ne sauvegarde pas automatiquement les requêtes SQL. Si vous souhaitez conserver cette requête, vous devrez la sauvegarder localement ou la copier dans un fichier texte.

- **Via la ligne de commande** (si vous avez accès à la base de données) :
  ```bash
  psql -h HOTE_SUPABASE -U UTILISATEUR -d BASE_DE_DONNEES -f create_table_produits_supabase.sql
  ```

### 2. Importation des données

Plusieurs méthodes sont disponibles pour importer les données du fichier CSV dans la table. Ces méthodes sont détaillées dans le fichier `import_produits_supabase.sql`.

#### Option 1 : Utilisation de la commande COPY de PostgreSQL

Si vous avez un accès direct à la base de données PostgreSQL de Supabase, vous pouvez utiliser la commande COPY :

```sql
COPY produits(id_pixee, code_barre, asin, ean, titre, fonctionnalites, images, fabricant, marque, couleur, 
              hauteur_article_cm, largeur_article_cm, longueur_article_cm, poids_article_g, 
              date_creation, date_modification)
FROM '/chemin/vers/produits_ok_source.csv' 
DELIMITER ',' 
CSV HEADER;
```

#### Option 2 : Utilisation de l'interface Supabase

1. Connectez-vous à votre projet Supabase
2. Allez dans la section "Table Editor"
3. Sélectionnez la table "produits"
4. Cliquez sur "Import data"
5. Sélectionnez le fichier CSV et configurez les options d'importation :
   - Assurez-vous que la première ligne est traitée comme en-tête
   - Vérifiez que les colonnes correspondent correctement
   - Définissez le délimiteur comme virgule ','
6. Cliquez sur "Import" pour lancer l'importation

#### Option 3 : Utilisation de l'API Supabase avec un script

Pour les fichiers volumineux, il est recommandé d'utiliser un script qui importe les données par lots. Des exemples de scripts en JavaScript et Python sont fournis dans le fichier `import_produits_supabase.sql`.

## Structure de la table

La table `produits` contient les colonnes suivantes :

| Colonne | Type | Description |
|---------|------|-------------|
| id_pixee | SERIAL | Identifiant unique auto-incrémenté (clé primaire) |
| code_barre | TEXT | Code-barres du produit |
| asin | TEXT | Amazon Standard Identification Number |
| ean | TEXT | European Article Number |
| titre | TEXT | Titre du produit |
| fonctionnalites | TEXT | Caractéristiques et fonctionnalités du produit |
| images | TEXT | URLs des images du produit, séparées par des virgules |
| fabricant | TEXT | Nom du fabricant |
| marque | TEXT | Marque du produit |
| couleur | TEXT | Couleur du produit |
| hauteur_article_cm | NUMERIC | Hauteur du produit en centimètres |
| largeur_article_cm | NUMERIC | Largeur du produit en centimètres |
| longueur_article_cm | NUMERIC | Longueur du produit en centimètres |
| poids_article_g | NUMERIC | Poids du produit en grammes |
| date_creation | TIMESTAMPTZ | Date de création de l'enregistrement |
| date_modification | TIMESTAMPTZ | Date de dernière modification de l'enregistrement |

## Fonctionnalités supplémentaires

Le script de création de la table inclut également :

- Des index sur les colonnes fréquemment utilisées pour les recherches (code_barre, asin, ean)
- Un déclencheur pour mettre à jour automatiquement la date de modification lors des mises à jour
- Des commentaires sur la table et les colonnes pour une meilleure documentation

## Vérification de l'importation

Après l'importation, vous pouvez vérifier que les données ont été correctement importées en exécutant les requêtes suivantes dans l'éditeur SQL de Supabase Studio (n'oubliez pas que ces requêtes ne seront pas sauvegardées automatiquement) :

```sql
-- Pour compter le nombre total d'enregistrements
SELECT COUNT(*) FROM produits;
```

```sql
-- Pour visualiser les 10 premiers enregistrements
SELECT * FROM produits LIMIT 10;
```

## Maintenance

Toutes les requêtes suivantes doivent être exécutées dans l'éditeur SQL de Supabase Studio. N'oubliez pas que Supabase Studio ne sauvegarde pas automatiquement ces requêtes.

### Mise à jour des données

Pour mettre à jour les données existantes, vous pouvez utiliser des requêtes SQL standard :

```sql
-- Exemple de mise à jour d'un produit
UPDATE produits
SET titre = 'Nouveau titre'
WHERE id_pixee = 123;
```

Notez que le déclencheur mettra automatiquement à jour la colonne `date_modification` sans que vous ayez à le spécifier.

### Suppression des données

Pour supprimer des données :

```sql
-- Exemple de suppression d'un produit
DELETE FROM produits WHERE id_pixee = 123;
```

### Réinitialisation de la table

Si vous souhaitez vider la table et réinitialiser la séquence d'auto-incrémentation :

```sql
-- Vider complètement la table et réinitialiser l'auto-incrémentation
TRUNCATE produits RESTART IDENTITY;
```

## Sécurité et permissions

Supabase utilise les politiques de sécurité Row Level Security (RLS) de PostgreSQL pour contrôler l'accès aux données. Voici comment configurer ces politiques pour la table `produits` :

1. Dans l'interface Supabase Studio, allez dans la section "Authentication" puis "Policies"
2. Sélectionnez la table "produits"
3. Par défaut, RLS est désactivé, ce qui signifie que toutes les requêtes ont un accès complet à la table
4. Pour activer RLS, cliquez sur le bouton "Enable RLS"
5. Une fois RLS activé, aucun accès n'est autorisé tant que vous n'avez pas défini des politiques spécifiques

Voici quelques exemples de politiques que vous pourriez créer (à exécuter dans l'éditeur SQL) :

```sql
-- Politique permettant à tous les utilisateurs authentifiés de lire les produits
CREATE POLICY "Lecture des produits pour utilisateurs authentifiés" 
ON produits FOR SELECT 
TO authenticated 
USING (true);

-- Politique permettant uniquement aux administrateurs de modifier les produits
CREATE POLICY "Modification des produits pour administrateurs" 
ON produits FOR UPDATE 
TO authenticated 
USING (auth.uid() IN (SELECT user_id FROM administrateurs));

-- Politique permettant uniquement aux administrateurs d'insérer des produits
CREATE POLICY "Insertion des produits pour administrateurs" 
ON produits FOR INSERT 
TO authenticated 
WITH CHECK (auth.uid() IN (SELECT user_id FROM administrateurs));

-- Politique permettant uniquement aux administrateurs de supprimer des produits
CREATE POLICY "Suppression des produits pour administrateurs" 
ON produits FOR DELETE 
TO authenticated 
USING (auth.uid() IN (SELECT user_id FROM administrateurs));
```

N'oubliez pas que ces requêtes SQL ne seront pas sauvegardées automatiquement dans Supabase Studio. Vous devriez les conserver dans un fichier séparé pour référence future.

Pour plus d'informations sur la configuration des politiques RLS dans Supabase, consultez la documentation officielle : https://supabase.com/docs/guides/auth/row-level-security
