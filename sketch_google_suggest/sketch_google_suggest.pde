// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;
import java.net.URLEncoder;

// ------------------------------------
// Timer
Timer timerLoadData;
// Période
float periodLoadData = 10.0;
// Adresse Google
String url = "http://google.com/complete/search?client=chrome&q=";
// Termes séparés par des virgules
String[] terms = new String[]{"montre", "moi"};

// ------------------------------------
void setup()
{
  timerLoadData = new Timer(false);
  timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, (long) periodLoadData*1000);
}

// ------------------------------------
void draw()
{
}

// ------------------------------------
void loadData()
{
  JSONArray data = loadJSONArray( makeUrl( terms ) );
  JSONArray suggests = data.getJSONArray(1);
  println(suggests);
}

// ------------------------------------
String makeUrl(String[] terms)
{
  String urlTerms=url;
  try
  {
    String sep = "";
    for (int i=0; i< terms.length ; i++)
    {
      urlTerms+= (sep+URLEncoder.encode(terms[i], "UTF-8")  );            
      sep = "+";    
    }
  } catch( Exception e )
  {
  }

  return urlTerms; 
}