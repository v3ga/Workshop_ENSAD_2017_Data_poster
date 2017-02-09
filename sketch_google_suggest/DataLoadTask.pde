// ------------------------------------
class DataLoadTask extends TimerTask
{
  Mur parentWall;
  
  DataLoadTask(Mur parentWall_)
  {
    this.parentWall = parentWall_;
  }
  
  public void run() 
  {
    if (this.parentWall!= null)
    this.parentWall.loadData();
  }
}