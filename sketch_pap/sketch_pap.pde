// ------------------------------------
// Lib : https://jsoup.org/
import java.util.Timer;
import java.util.TimerTask;
import org.jsoup.*;

// ------------------------------------
// Timer
Timer timerLoadData;
// Période
float periodLoadData = 10.0;
// Adresse pap
String url = "http://www.pap.fr/annonce/locations-appartement-paris-75-g439-jusqu-a-800-euros";


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
  try
  {
    Document doc = Jsoup.connect(url).get(); 

    // Pagination    
    Elements pagination = doc.select(".pagination ul li");
//    println( pagination.size()-1 );
    int nbPages = pagination.size() > 1 ? pagination.size()-1 : 1;
    for (int i=0 ; i < nbPages ; i++)
    {
          
    }



    // Extract annonces from page
    
/*    Elements results = doc.select(".search-results-item");
    for(Element result : results)
    {
      println("-----------------");
      println( result.html() );
    }
*/  }
  catch(Exception e)
  {
  }
}

// ------------------------------------
class DataLoadTask extends TimerTask
{
  public void run() 
  {
    loadData();
  }
}