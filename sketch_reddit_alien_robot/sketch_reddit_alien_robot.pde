
// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;
import org.jsoup.*;
import org.jsoup.Connection.Response;
import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;

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
// arduino
Arduino arduino;

// ------------------------------------
void setup()
{
  // size(500,500);
  timerLoadData = new Timer(false);
  timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, (long) periodLoadData*1000);
}

// ------------------------------------
void draw()
{
  background(0);
}

// ------------------------------------
JSONObject query(String what)
{
  try
  {
    Response response= Jsoup.connect(url+"&q="+what)
      .ignoreContentType(true)
      .userAgent("Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0")  
      .referrer("http://www.google.com")   
      .timeout(12000) 
      .followRedirects(true)
      .execute();

    String data = response.parse().select("body").html();
    return parseJSONObject(data);
  }
  catch (Exception e) {
  }
  return null;
}

// ------------------------------------
void loadData()
{
  JSONObject dataAlien = query("robot");
//  JSONArray dataRobot = query("alien");
  
//  println( dataAlien );
}

// ------------------------------------
class DataLoadTask extends TimerTask
{
  public void run() 
  {
    loadData();
  }
}