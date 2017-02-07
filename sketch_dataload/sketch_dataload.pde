// ------------------------------------
import java.util.Timer;
import java.util.TimerTask;

// ------------------------------------
Timer timerLoadData;

// ------------------------------------
void setup()
{
  timerLoadData = new Timer(false);
  // 
  timerLoadData.scheduleAtFixedRate(new DataLoadTask(), 0, 1*1000);
}

// ------------------------------------
void draw()
{

}

// ------------------------------------
void loadData()
{
  // println("load");
}