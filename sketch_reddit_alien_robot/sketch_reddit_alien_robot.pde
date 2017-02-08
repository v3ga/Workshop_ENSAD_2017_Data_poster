// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;

// ------------------------------------
// Timer
Timer timerLoadData;
// Période
float periodLoadData = 60.0; // en secondes
// Paramètres 
// voir https://pushshift.io/enhancing-reddit-api-and-search/
String unit = "minute";
String count = "60";
String url = "https://api.pushshift.io/reddit/activity?event=t1&unit="+unit+"&count="+count;

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
JSONArray query(String what)
{
    return loadJSONArray( url+"&q="+what );
}

// ------------------------------------
void loadData()
{
   JSONArray dataAlien = query("robot");
   JSONArray dataRobot = query("alien");

}

// ------------------------------------
class DataLoadTask extends TimerTask
{
  public void run() 
  {
    loadData();
  }
}