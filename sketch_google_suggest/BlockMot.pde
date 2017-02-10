class BlockMot
{
  Mur mur;
  String txt;
  float x, y, w, h;
  float alpha;

  // ------------------------------------
  BlockMot(Mur mur_, String txt_, float x_, float y_, float w_, float h_)
  {
    this.mur = mur_;
    this.txt = txt_;
    this.alpha = 0;
    this.x = x_;
    this.y = y_;
    this.w = w_;
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
     noStroke();
    fill(#FFFFFF,alpha);
    rect(x,y,w,h);
    fill(0,alpha);
    text(txt,x,y+yFontBaseline);
  }
}