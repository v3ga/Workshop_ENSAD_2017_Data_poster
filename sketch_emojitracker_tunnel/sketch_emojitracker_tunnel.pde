// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;
import java.net.URLEncoder;

// ------------------------------------
// Images
PImage[] images;
int nbImages = 40;

// Tunnel
float ZMIN = -3000;
float zVoyageurTarget = 0, zVoyageur = 0;
float papeur = 0.95;

// Timer
Timer timerLoadData;
// Période
float periodLoadData = 10.0;
// Data
String url = "http://emojitracker.com/api/rankings";
JSONArray dataEmoji;

// ------------------------------------
void setup()
{
  size(1459,974,P3D);

  images = new PImage[nbImages];
  for (int i=0; i<images.length; i++)
  {
      images[i] = loadImage("colo_"+nf(i,4)+".png");
  }

  //timerLoadData = new Timer(false);
  //timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, (long) periodLoadData*1000);

  loadDataEmoji();
  
  println( getScoreFor("1F60D") );
}

// ------------------------------------
void draw()
{
  background(255);
  // Centre de l'écran
  translate(width/2,height/2);

  // Position du voyageur
  zVoyageurTarget = map(mouseY - height/2,-height/2,height/2,0,-ZMIN*papeur);
  zVoyageur += (zVoyageurTarget - zVoyageur)*0.1;
  translate(0,0,zVoyageur);
  
  
  imageMode(CENTER);
  for (int i=0; i<images.length; i++)
  {
    pushMatrix();
    translate(0,0,map(i,0,images.length-1,ZMIN,0));
    image(images[i],0,0);
    popMatrix();
  }  
}

// ------------------------------------
void loadData()
{
}

// ------------------------------------
void loadDataEmoji()
{
  dataEmoji = loadJSONArray( url );
}

// ------------------------------------
int getScoreFor(String id)
{
  if (dataEmoji !=null)
  {
    int nbEmoji = dataEmoji.size();
    JSONObject emoji;
    for (int i=0;i<nbEmoji;i++)
    {
      emoji = dataEmoji.getJSONObject(i);
      if (emoji.getString("id").equals(id))
        return emoji.getInt("score");
    }
  }
  return 0;
}