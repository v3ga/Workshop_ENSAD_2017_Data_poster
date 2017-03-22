// Importation des librairies temboo
import com.temboo.core.*;
import com.temboo.Library.Twitter.Search.*;

// Objet de type TemboSession qui stocke les informations
// relatives à l'application twitter
TembooSession session = new TembooSession("v3ga", "myFirstApp", "######");

// Profil Twitter sur Temboo
String twitterProfile = "ENSAD";

// Objet de type JSONArray qui va stocker les tweets retournés 
JSONArray tweets;

// ----------------------------------------------
void setup() 
{
  // Récupère les tweets 
  tweets = findTweets("#ChasseALHomme",30);

  // Les imprime dans la console
  int nbTweets = tweets.size();
  for (int i=0; i<nbTweets; i++)
  {
    println("["+i+"]"+tweets.getJSONObject(i).getString("text") );
    println("--------");
  }
}

// ----------------------------------------------
void draw()
{

}