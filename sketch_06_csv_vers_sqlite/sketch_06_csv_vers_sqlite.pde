
// Import des librairies
// BezierSQLib > http://bezier.de/processing/libs/sql/
import de.bezier.data.sql.*;

// Outil
// > SQLite Manager add-on pour Firefox
// Utile pour visualiser un fichier .sqlite
// Et effectuer des requêtes manuelles

// Données lues depuis le fichier .csv
Table data;

// Object qui représente la connexion à la base de données sqlite
// Nous allons l'utiliser en écriture ici
SQLite db;

// --------------------------------------------------------
void setup()
{
  // Chargement des données
  // "header" signifie que le fichier .csv comporte une ligne de description (nommage des colonnes)
  data = loadTable("prenoms.csv", "header");
  
  // Connexion à la base de données
  // Au préalable : créer un fichier vide "prenoms.sqlite" (avec un éditeur de texte par exemple)
  // TODO : ce serait possible de le créer directement ici, par programmation
  try{
    db = new SQLite(this, "prenoms.sqlite");
  }catch(Exception e)
{}
  
  // Si on est bien connecté
  if ( db.connect()==true )
  {
    // Création de la table prenoms (si elle n'existe pas déjà)
    String query = "CREATE TABLE IF NOT EXISTS prenoms (";
    query += "PRENOM varchar(30),";
    query += "ANNEE smallint,";
    query += "OCCURRENCE smallint,";
    query += "ORDRE smallint";
    query += ")";
    println(query);
    db.execute( query );

    // Avant d'insérer des éléments, on efface toutes les entrées de la table
    // pour ne pas accumuler les données si on relance le programme plusieurs fois
    db.execute( "DELETE FROM prenoms" );
    
    // Lecture des données du fichier .csv
    // et génération des requêtes d'insertion dans a table de la base
    // Attention aux types de données ! Les chaînes (varchar) nécessitent des guillements simples '
    // Les nombres (smallint) n'en ont pas besoin
    for (TableRow row : data.rows())
    {
      String queryInsert = "INSERT INTO prenoms (`PRENOM`,`ANNEE`, `OCCURRENCE`, `ORDRE`) VALUES (";
      queryInsert += "'"+row.getString("PREMPRENOM")+"',";
      queryInsert += "'"+row.getString("ANNEE")+"',";
      queryInsert += row.getInt("NOMBREPREMPRENOM")+",";
      queryInsert += row.getInt("ORDRE")+")";
      //println( queryInsert );
      db.execute( queryInsert );
    }
  } 
}

// --------------------------------------------------------
void draw()
{
}

// --------------------------------------------------------
public void dispose()
{}