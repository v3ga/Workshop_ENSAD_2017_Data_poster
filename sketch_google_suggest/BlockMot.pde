class BlockMot
{
  Mur mur;
  String txt;
  float x, y, h;
  float alpha;

  // ------------------------------------
  BlockMot(Mur mur_, String txt_, float y_, float h_)
  {
    this.mur = mur_;
    this.txt = txt_;
    this.alpha = 0;
    this.x = random(width);
    this.y = y_;
    this.h = h_;
  }

  // ------------------------------------
  void setAlpha(float alpha_)
  {
    this.alpha = alpha_;
  }
  
  // ------------------------------------
  void begin()
  {
    Ani.to(this, 1, "alpha", 255);
  }

  // ------------------------------------
  void draw()
  {
    textFont(fonteMur);
    float w = textWidth(this.txt);
    if (x+w>=width)
      x = width-w-20;
    noStroke();
    fill(#FFFFFF);
    rect(x,y,w,h);
    fill(0);
    text(txt,x,y+44);
  }
}