// ------------------------------------
// Lib : https://jsoup.org/
import java.util.Timer;
import java.util.TimerTask;
import org.jsoup.*;
import java.net.URLDecoder;
import java.util.regex.*;

// ------------------------------------
// Timer
Timer timerLoadData;
// Période
float periodLoadData = 10.0;
// Adresse pap
String url = "http://www.pap.fr/annonce/locations-appartement-paris-75-g439-jusqu-a-800-euros";
// Liste des annonces
ArrayList<Annonce> annonces;
int nbPages = 0;


// ------------------------------------
void setup()
{
  // timerLoadData = new Timer(false);
  // timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, (long) periodLoadData*1000);
  
  annonces = new ArrayList<Annonce>();
  loadData();

  size(1024,768);
  noLoop();
}

// ------------------------------------
void draw()
{
  background(255);
  for (Annonce annonce : annonces)
    annonce.draw();
}


// ------------------------------------
void loadPage(int which)
{
  try
  {
    Document doc = Jsoup.connect(url).get(); 

    // Pagination    
    Elements pagination = doc.select(".pagination ul li");
    //    println( pagination.size()-1 );
    nbPages = pagination.size() > 1 ? pagination.size()-1 : 1;

    // Extract annonces from page
    Elements results = doc.select(".search-results-item");
    for (Element result : results)
    {
      Elements elmtTitle = result.select(".title-item .h1");
      Elements elmtPrice = result.select(".title-item .price");
      Elements elmtDesc = result.select(".box-body .item-description");
      
      if (elmtTitle.size() == 1 && elmtPrice.size() == 1 )
      {
         println( " - title = " + Jsoup.parse(elmtTitle.html()).text() + " / prix = " + Jsoup.parse(elmtPrice.html()).text() );
         println( " - description = " + Jsoup.parse(elmtDesc.html()).text());
        annonces.add( new Annonce(
          Jsoup.parse(elmtTitle.html()).text(),
          Jsoup.parse(elmtPrice.html()).text(),
          Jsoup.parse(elmtDesc.html()).text()
        ) );
          
      }
    }
  }
  catch(Exception e)
  {
  }
  
}

// ------------------------------------
void loadData()
{
  loadPage(0);
}

// ------------------------------------
class DataLoadTask extends TimerTask
{
  public void run() 
  {
    loadData();
  }
}