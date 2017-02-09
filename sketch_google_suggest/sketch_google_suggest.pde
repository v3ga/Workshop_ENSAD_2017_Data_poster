
// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;
import java.net.URLEncoder;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import rita.*;

// ------------------------------------
// Adresse Google
String url = "http://google.com/complete/search?client=chrome&q=";
// « Murs »
ArrayList<Mur> murs;

// Fonte
PFont fonteMur; 

// ------------------------------------
void setup()
{
  Ani.init(this);
  fonteMur = loadFont("Arial-Black-48.vlw");
  murs = new ArrayList<Mur>();
  murs.add( new Mur(0, width/2, new String[]{ "comment faire" }) );
  for (Mur mur : murs)
    mur.setup();
  size(1600,1200);    
}

// ------------------------------------
void draw()
{
  background(0);
  for (Mur mur : murs)
    mur.draw();
}

// ------------------------------------
String makeUrl(String[] terms)
{
  String urlTerms=url;
  try
  {
    String sep = "";
    for (int i=0; i< terms.length; i++)
    {
      urlTerms+= (sep+URLEncoder.encode(terms[i], "UTF-8")  );            
      sep = "+";
    }
  } 
  catch( Exception e )
  {
  }

  return urlTerms;
}