// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;
import java.util.List;
import twitter4j.conf.*;
import twitter4j.*;
import twitter4j.auth.*;
import twitter4j.api.*;

// ------------------------------------
// Timer
Timer timerLoadData;
// Période
float periodLoadData = 30.0;
// Objet twitter
Twitter twitter;

// ------------------------------------
void setup()
{
  ConfigurationBuilder cb = new ConfigurationBuilder();
  cb.setOAuthConsumerKey("");
  cb.setOAuthConsumerSecret("");
  cb.setOAuthAccessToken("");
  cb.setOAuthAccessTokenSecret("");
  
  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();


  timerLoadData = new Timer(false);
  timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, (long) periodLoadData*1000);
  
  size(800,600);
}

// ------------------------------------
void draw()
{
  
}

// ------------------------------------
void loadData()
{
  getNewTweets("#poutou");
}

// ------------------------------------
List<Status> getNewTweets(String searchString)
{
    List<Status> tweets = null;
    try
    {
        Query query = new Query(searchString);
        // query.setSinceId(828900908977242112L);
        QueryResult result = twitter.search(query);
        tweets = result.getTweets();
        
        for (Status status : tweets)
        {
          println("["+status.getId()+"] " + status.getText());
        }
        
    }
    catch (TwitterException te)
    {
        println("Failed to search tweets: " + te.getMessage());
    }
    
    return tweets;
}

// ------------------------------------
class DataLoadTask extends TimerTask
{

  public void run() 
  {
//    println("run called");
    loadData();
  }
}