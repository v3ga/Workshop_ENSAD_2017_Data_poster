String[] data;

void setup()
{
  size(500,500);
  data = loadStrings("http://bit.ly/2eJT9I9");
  println( data.length );
}

void draw()
{
  background(128);
  //ellipse(250,250,float(data[0]),float(data[0]));
  for (int i=0; i < data.length ; i=i+1)
  {
    if (mouseX >= 10*i && mouseX <= 10*(i+1))
    {
      fill(0);
      text(data[i],4,490);
    }
    else
    {
      fill(255);
    }
    // line(10*i,0,10*i,float(data[i]));
    rect(10*i,0, 10, float(data[i]));
  }
  
}