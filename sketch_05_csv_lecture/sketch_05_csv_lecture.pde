// Données lues depuis le fichier .csv
// // http://opendata.bordeaux.fr/content/palmares-prenoms
Table data;

// Variable qui représente une ligne en mémoire
TableRow ligne;

// Variable qui contient l'index de la ligne en train d'être lue
int ligneIndex=0;

// --------------------------------------------------------
void setup()
{
  // Dimension de la fenêtre
  size(600,600);
  
  // Chargement des données
  // "header" signifie que le fichier .csv comporte une ligne de description (nommage des colonnes)
  data = loadTable("prenoms.csv", "header");
  // println(data.getColumnCount());
  // Première ligne
  ligne = data.getRow(ligneIndex);
  println(ligne);
}

// --------------------------------------------------------
void draw()
{
  background(255);
  // Si la ligne est valide ... 
  if (ligne != null)
  {
    fill(200);
    textSize(20);
    text(ligne.getString("ANNEE"), 10, 50);

    fill(0);
    textSize(50);
    text(ligne.getString("PREMPRENOM") + "("+ ligne.getString("NOMBREPREMPRENOM") +")", 10, 300);
  }
}

// --------------------------------------------------------
void keyPressed()
{
  // On incrémente d'une ligne
  ligneIndex = ligneIndex + 1;
  // Et on récupère les données associées en mémoire, symbolisées par la variable ligne
  ligne = data.getRow(ligneIndex);
}