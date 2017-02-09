class BlocMot
{
  String mot;
  int x,y;
  PImage img;

  BlocMot(JSONObject obj_)
  {
    this.mot = obj_.getString("mot");
    this.x = obj_.getInt("x");
    this.y = obj_.getInt("y");
    
    img = loadImage(this.mot+".png");
  }
  
  BlocMot(String mot_, int x_, int y_)
  {
    this.mot = mot_;
    this.x = x_;
    this.y = y_;
  }
  
  

}