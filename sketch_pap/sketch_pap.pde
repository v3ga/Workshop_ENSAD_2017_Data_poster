// ------------------------------------
// Lib : https://jsoup.org/
import org.jsoup.*;
import java.net.URLDecoder;
import java.util.regex.*;
import java.util.*;

// ------------------------------------
// Villes
ArrayList<VilleData> villes;
HashMap<Integer, PImage> blocs;

PFont[] fontes;
float vitesseText = 5;
float hauteurBlock = 40;

// ------------------------------------
void setup()
{
  // timerLoadData = new Timer(false);
  // timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, (long) periodLoadData*1000);
  
  fontes = new PFont[4];

  fontes[0] = loadFont("Helvetica-Bold-140.vlw");
  fontes[1] = loadFont("Courier-140.vlw");
  fontes[2] = loadFont("Courier-140.vlw");
  fontes[3] = loadFont("Courier-140.vlw");
  
  blocs = new HashMap<Integer, PImage>();
  blocs.put( 9 , loadImage("9m2.png") );
  blocs.put( 20 , loadImage("20m2.png") );
  blocs.put( 30 , loadImage("30m2.png") );
  blocs.put( 40 , loadImage("40m2.png") );
  
  
  villes = new ArrayList<VilleData>();
  villes.add( new VilleData("Paris",       "http://www.pap.fr/annonce/locations-appartement-paris-75-g439-jusqu-a-800-euros", 0, width/2));
  villes.add( new VilleData("Marseille",    "http://www.pap.fr/annonce/locations-appartement-marseille-13-g12024-jusqu-a-800-euros", width/2, width/2));
  
  for (VilleData ville : villes)
    ville.loadData();

  size(1280, 768);
}


// ------------------------------------
void draw()
{
  background(255);
  for (VilleData ville : villes)
  {
    ville.render();
    ville.draw();
  }
  
}