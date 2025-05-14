# Guide d'importation manuelle des produits dans Supabase

Ce guide visuel vous explique comment importer manuellement les données du fichier CSV `produits_ok_source.csv` dans Supabase en utilisant l'interface utilisateur.

## Étape 1 : Connexion à Supabase

1. Connectez-vous à votre compte Supabase à l'adresse [https://app.supabase.io](https://app.supabase.io)
2. Sélectionnez votre projet dans la liste des projets

## Étape 2 : Création de la table

1. Dans le menu latéral, cliquez sur "Table Editor"
2. Cliquez sur le bouton "Create a new table"

   ![Créer une nouvelle table](https://placeholder.com/create-table)

3. Remplissez les informations de la table :
   - Nom de la table : `produits`
   - Description : `Table des produits importée depuis produits_ok_source.csv`
   - Schéma : `public` (par défaut)

4. Ajoutez les colonnes suivantes :

   | Nom de la colonne | Type de données | Valeur par défaut | Contraintes |
   |-------------------|-----------------|-------------------|-------------|
   | id_pixee | int8 | nextval('produits_id_pixee_seq'::regclass) | Primary Key |
   | code_barre | text | NULL | |
   | asin | text | NULL | |
   | ean | text | NULL | |
   | titre | text | NULL | |
   | fonctionnalites | text | NULL | |
   | images | text | NULL | |
   | fabricant | text | NULL | |
   | marque | text | NULL | |
   | couleur | text | NULL | |
   | hauteur_article_cm | numeric | NULL | |
   | largeur_article_cm | numeric | NULL | |
   | longueur_article_cm | numeric | NULL | |
   | poids_article_g | numeric | NULL | |
   | date_creation | timestamptz | now() | |
   | date_modification | timestamptz | now() | |

5. Cliquez sur "Save" pour créer la table

   ![Configuration de la table](https://placeholder.com/table-config)

## Étape 3 : Création des index

1. Dans le menu latéral, cliquez sur "SQL Editor"
2. Cliquez sur "New Query"
3. Copiez-collez le code SQL suivant :

```sql
-- Création d'index sur les colonnes fréquemment utilisées pour les recherches
CREATE INDEX idx_produits_code_barre ON produits(code_barre);
CREATE INDEX idx_produits_asin ON produits(asin);
CREATE INDEX idx_produits_ean ON produits(ean);

-- Création d'une fonction pour mettre à jour automatiquement la date de modification
CREATE OR REPLACE FUNCTION update_modified_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.date_modification = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Création d'un déclencheur pour mettre à jour automatiquement la date de modification
CREATE TRIGGER set_modification_timestamp
BEFORE UPDATE ON produits
FOR EACH ROW
EXECUTE FUNCTION update_modified_column();

-- Commentaires sur la table et les colonnes pour une meilleure documentation
COMMENT ON TABLE produits IS 'Table des produits importée depuis produits_ok_source.csv';
COMMENT ON COLUMN produits.id_pixee IS 'Identifiant unique auto-incrémenté';
COMMENT ON COLUMN produits.code_barre IS 'Code-barres du produit';
COMMENT ON COLUMN produits.asin IS 'Amazon Standard Identification Number';
COMMENT ON COLUMN produits.ean IS 'European Article Number';
COMMENT ON COLUMN produits.titre IS 'Titre du produit';
COMMENT ON COLUMN produits.fonctionnalites IS 'Caractéristiques et fonctionnalités du produit';
COMMENT ON COLUMN produits.images IS 'URLs des images du produit, séparées par des virgules';
COMMENT ON COLUMN produits.fabricant IS 'Nom du fabricant';
COMMENT ON COLUMN produits.marque IS 'Marque du produit';
COMMENT ON COLUMN produits.couleur IS 'Couleur du produit';
COMMENT ON COLUMN produits.hauteur_article_cm IS 'Hauteur du produit en centimètres';
COMMENT ON COLUMN produits.largeur_article_cm IS 'Largeur du produit en centimètres';
COMMENT ON COLUMN produits.longueur_article_cm IS 'Longueur du produit en centimètres';
COMMENT ON COLUMN produits.poids_article_g IS 'Poids du produit en grammes';
COMMENT ON COLUMN produits.date_creation IS 'Date de création de l''enregistrement';
COMMENT ON COLUMN produits.date_modification IS 'Date de dernière modification de l''enregistrement';
```

4. Cliquez sur "Run" pour exécuter la requête

   ![Exécution de la requête SQL](https://placeholder.com/run-sql)

5. **Important** : Supabase Studio ne sauvegarde pas automatiquement les requêtes SQL. Si vous souhaitez conserver cette requête, vous devrez la sauvegarder localement ou la copier dans un fichier texte.

## Étape 4 : Importation des données CSV

1. Retournez à la section "Table Editor"
2. Sélectionnez la table "produits" dans la liste des tables
3. Cliquez sur le bouton "Import data"

   ![Importer des données](https://placeholder.com/import-data)

4. Dans la fenêtre d'importation, cliquez sur "Browse" et sélectionnez le fichier `produits_ok_source.csv`
5. Configurez les options d'importation :
   - Format : CSV
   - Délimiteur : Virgule (,)
   - Traiter la première ligne comme en-tête : Coché
   - Ignorer les lignes vides : Coché

   ![Configuration de l'importation](https://placeholder.com/import-config)

6. Vérifiez la correspondance des colonnes :
   - Assurez-vous que chaque colonne du CSV est correctement mappée à la colonne correspondante dans la table
   - Pour la colonne id_pixee, sélectionnez "Use values from file" pour utiliser les valeurs du fichier CSV

   ![Correspondance des colonnes](https://placeholder.com/column-mapping)

7. Cliquez sur "Import" pour lancer l'importation
8. Attendez que l'importation se termine. Pour les fichiers volumineux, cela peut prendre plusieurs minutes.

   ![Progression de l'importation](https://placeholder.com/import-progress)

## Étape 5 : Vérification de l'importation

1. Une fois l'importation terminée, vous devriez voir un message de confirmation
2. Vous pouvez maintenant voir les données dans la table "produits"

   ![Données importées](https://placeholder.com/imported-data)

3. Pour vérifier le nombre total d'enregistrements, allez dans la section "SQL Editor", créez une nouvelle requête et exécutez :

```sql
-- Pour compter le nombre total d'enregistrements
SELECT COUNT(*) FROM produits;
```

4. Pour visualiser les 10 premiers enregistrements :

```sql
-- Pour visualiser les 10 premiers enregistrements
SELECT * FROM produits LIMIT 10;
```

## Étape 6 : Configuration des politiques de sécurité (optionnel)

1. Dans le menu latéral, cliquez sur "Authentication" puis "Policies"
2. Sélectionnez la table "produits" dans la liste
3. Par défaut, RLS (Row Level Security) est désactivé. Pour l'activer, cliquez sur "Enable RLS"

   ![Activer RLS](https://placeholder.com/enable-rls)

4. Une fois RLS activé, vous devez créer des politiques pour autoriser l'accès aux données
5. Cliquez sur "Create a new policy"
6. Configurez la politique selon vos besoins, par exemple :
   - Nom : "Lecture des produits pour utilisateurs authentifiés"
   - Opération : SELECT
   - Utilisateurs : authenticated
   - Condition : true (pour permettre à tous les utilisateurs authentifiés de lire les données)

   ![Création d'une politique](https://placeholder.com/create-policy)

7. Cliquez sur "Save" pour créer la politique
8. Répétez les étapes 5-7 pour créer d'autres politiques selon vos besoins (INSERT, UPDATE, DELETE)

## Conclusion

Vous avez maintenant créé une table "produits" dans Supabase et importé les données du fichier CSV. La table est configurée avec un identifiant auto-incrémenté (id_pixee) et des index pour optimiser les performances des requêtes. Un déclencheur a également été mis en place pour mettre à jour automatiquement la date de modification lorsque les données sont modifiées.

Pour toute modification future des données, vous pouvez utiliser l'interface "Table Editor" de Supabase ou exécuter des requêtes SQL dans la section "SQL Editor".
