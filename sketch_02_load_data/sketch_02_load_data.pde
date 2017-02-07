String[] valeurs;
float valeur = 0.0;

void setup()
{
  size(500,500);
  valeurs = loadStrings("valeurs.txt");
}

void draw()
{
  background(255);
  stroke(0);
  noFill();
  for (int i=0; i<valeurs.length; i=i+1)
  {
    valeur = float( valeurs[i] );
    rect(i*10, 0, 10, valeur);
    //line(i*10+5, 0, i*10+5, valeur);
  }
}