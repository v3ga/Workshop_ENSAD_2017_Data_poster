class ColumnBlock
{
  float x, y, w, h;
  color c;

  // ------------------------------------
  ColumnBlock(color c_, float x_, float y_, float w_, float h_)
  {
    this.c = c_;
    this.x = x_;
    this.y = y_;
    this.w = w_;
    this.h = h_;
  }

  // ------------------------------------
  void draw()
  {
    noStroke();
    fill(c);
    rect(x,y,w,h);
  }
}