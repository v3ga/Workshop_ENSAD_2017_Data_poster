
// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;
import org.jsoup.*;
import org.jsoup.Connection.Response;
import processing.serial.*;
import cc.arduino.*;
import org.firmata.*;
import java.sql.Timestamp;

// ------------------------------------
// Timer
Timer timerLoadData;

// Période
float periodLoadData = 60.0; // en secondes

// Paramètres 
// voir https://pushshift.io/enhancing-reddit-api-and-search/
String unit = "second";
String count = ""+int(periodLoadData);
String url = "https://api.pushshift.io/reddit/activity?event=t1&unit="+unit+"&count="+count;

// Queries
Query queryRobot, queryAlien;
int QUERY_COUNT_MAX = 5;

// Arduino
Arduino arduino;
int[] ledsRobot = {5, 2, 4}; 
int[] ledsAlien = {3, 6}; 



// ------------------------------------
void setup()
{
  size(200, 200);

  queryRobot = new Query("robot");
  queryAlien = new Query("alien");

  timerLoadData = new Timer(false);
  timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, (long) periodLoadData*1000);

  String[] arduinoList = (String[])Arduino.list();
  for (int i=0; i<arduinoList.length; i++)
  {
    println( i + " / " + arduinoList[i] );
  }

  arduino = new Arduino(this, Arduino.list()[4], 57600);
  arduino.pinMode(2, Arduino.OUTPUT);
}

// ------------------------------------
void draw()
{
  background(0);

  fill(255);
  text("robot : "+queryRobot.count, 5, 20);
  text("alien : "+queryAlien.count, 5, 35);

  // Debug
   // queryRobot.count = 2;
   // queryAlien.count = 1;

  // Robot
  lightLEDs(ledsRobot, queryRobot.count);
  lightLEDs(ledsAlien, queryAlien.count);
}

// ------------------------------------
void lightLEDs(int[] leds, int count)
{
  for (int i=0; i<leds.length; i++)
  {
    if ( i <= min(count-1, QUERY_COUNT_MAX))
    {
      arduino.digitalWrite(leds[i], Arduino.HIGH);
    } else
    {
      arduino.digitalWrite(leds[i], Arduino.LOW);
    }
  }
}

// ------------------------------------
void loadData()
{
  queryRobot.run();
  queryAlien.run();
}

// ------------------------------------
class DataLoadTask extends TimerTask
{
  public void run() 
  {
    loadData();
  }
}