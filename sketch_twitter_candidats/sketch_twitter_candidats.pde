// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;
import java.util.List;
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;
import de.looksgood.ani.*;
import de.looksgood.ani.easing.*;

// ------------------------------------
// Timer
Timer timerLoadData;
// Période
float periodLoadData = 30.0;
// Objet twitter
Twitter twitter;
// Les candidats
ArrayList<Candidat> candidates;
// Debug
boolean __DEBUG__ = true;

// ------------------------------------
void setup()
{
  Ani.init(this);
  
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("");
  cb.setOAuthConsumerSecret("");
  cb.setOAuthAccessToken("");
  cb.setOAuthAccessTokenSecret("");
  
  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();

  candidates = new ArrayList<Candidat>();
  candidates.add( new Candidat("fillon",      new String[]{ "#fillon" } ));
  candidates.add( new Candidat("melenchon",   new String[]{ "#melenchon"} ));
  candidates.add( new Candidat("macron",      new String[]{ "#macron"} ));
  candidates.add( new Candidat("hamon",       new String[]{ "#hamon"} ));
  candidates.add( new Candidat("lepen",       new String[]{ "#lepen"} ));

  for (Candidat candidat : candidates)
    candidat.loadData();

  timerLoadData = new Timer(false);
  timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, (long) periodLoadData*1000);
  
  size(576,1024);
}

// ------------------------------------
void draw()
{
  background(0);
  for (Candidat candidat : candidates)
  {
    tint(255, candidat.imgAlpha );
    image(candidat.img, 0,0);
  }

  if (__DEBUG__)
  {
    int y=20;
    fill(255);
    for (Candidat candidat : candidates)
    {
      text( candidat.toString(), 5,y );
      y += 15;
    }
  }
}

// ------------------------------------
void loadData()
{
  // Charge les tweets
  for (Candidat candidat : candidates)
    candidat.getNewTweets();
  // Calcule leur popularité
  for (Candidat candidat : candidates)
    candidat.computePopularity(candidates);
  // Anime le alpha en fonction de la popularité
  for (Candidat candidat : candidates)
    candidat.animateAlpha();
}

// ------------------------------------
class DataLoadTask extends TimerTask
{
  public void run() 
  {
    loadData();
  }
}