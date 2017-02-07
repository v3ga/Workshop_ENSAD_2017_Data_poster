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
  cb.setOAuthConsumerKey("*****YOUR-KEY-HERE******");
  cb.setOAuthConsumerSecret("*************YOUR-KEY-HERE*************");
  cb.setOAuthAccessToken("*************YOUR-KEY-HERE***************");
  cb.setOAuthAccessTokenSecret("**********YOUR-KEY-HERE***************");
  
  TwitterFactory tf = new TwitterFactory(cb.build());
  twitter = tf.getInstance();


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
}

// ------------------------------------
List<Status> getNewTweets(String searchString)
{
    List<Status> tweets = null;
    try
    {
        Query query = new Query(searchString);
        QueryResult result = twitter.search(query);
        tweets = result.getTweets();
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