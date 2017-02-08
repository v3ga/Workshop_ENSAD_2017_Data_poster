class ColumnColor extends WatchDir
{
  String dir;
  float x, y, w, h;
  WatchDir wd;
  float lasty;

  ArrayList<ColumnBlock> blocks;

  // ------------------------------------
  ColumnColor(String dir_, float x_, float y_, float w_, float h_)
  {
    super(sketchPath(dir_));

    this.dir = dir_;
    this.x = x_; 
    this.y = y_; 
    this.w = w_; 
    this.h = h_; 
    
    this.lasty = y;
    
    this.blocks = new ArrayList<ColumnBlock>();
  }

  // ------------------------------------
  // in thread
  public void processFileCreated(String filename)
  {
    if (filename.equals(".DS_Store")) return;
    
    String pathFile = dir+filename;
    println(" - processing file '" + pathFile + "'");
    
    PImage img = loadImage(pathFile);
    ArrayList hist = createHistogramFromImage(img.pixels, img.pixels.length, 0.1, true);    
    
    int nbBlocks = min(hist.size(), 6);
    float y = lasty;
    for (int i=0; i<nbBlocks; i++)
    {
      HistEntry e = (HistEntry) hist.get(i);
      float h = e.freq * 400;
      
      this.blocks.add( new ColumnBlock(e.col.toARGB(),this.x,this.y+y,this.w,h) );  
  
       y+=h;
    }
    lasty = y;
  }

  synchronized public void draw()
  {
    for (ColumnBlock block : blocks)
    {
      block.draw();
    }
  }

}