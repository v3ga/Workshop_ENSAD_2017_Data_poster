// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;
import java.net.URLEncoder;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;
import rita.*;
import codeanticode.syphon.*;

// ------------------------------------
// Adresse Google
String url = "http://google.com/complete/search?client=chrome&hl=";

float periodLoadData = 2.0;

// « Murs »
ArrayList<Mur> murs;

// Fonte
PFont fonteMur; 
int fonteSizeMur = 20;
float heightBlock = 30;
float yFontBaseline = 24;

float scrollSpeed = 1.5;


// ------------------------------------
void setup()
{
  Ani.init(this);

  // Fontes
  fonteMur = loadFont("Arial-Black-48.vlw");
  textFont(fonteMur,fonteSizeMur);
  
  // Murs
  murs = new ArrayList<Mur>();
  murs.add( new Mur("fr", color(255,255,0), 0, width/3, new String[]{ "comment", "faire" }) );
  murs.add( new Mur("es", color(0,255,0), width/3, width/3, new String[]{ "comment", "dire"}) );
  murs.add( new Mur("it", color(0,0,255), 2*width/3, width/3, new String[]{ "comment", "jouer"}) );
  for (Mur mur : murs)
    mur.setup();
  size(1600,500);    

}

// ------------------------------------
void draw()
{
  background(0);
  for (Mur mur : murs)
    mur.draw();
}

// ------------------------------------
String makeUrl(String[] terms, String lang)
{
  String urlTerms=url+lang+"&q=";
  try
  {
    String sep = "";
    for (int i=0; i< terms.length; i++)
    {
      urlTerms+= (sep+URLEncoder.encode(terms[i], "UTF-8")  );            
      sep = "+";
      
    }
    println(urlTerms);
  } 
  catch( Exception e )
  {
  }

  return urlTerms;
}