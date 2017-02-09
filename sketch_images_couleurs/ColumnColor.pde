class ColumnColor extends WatchDir
{
  String dir;
  float x, y, w, h;
  WatchDir wd;
  float lasty;
  float yFirstBlock = 0;

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
    ArrayList hist = createHistogramFromImage(img.pixels, img.pixels.length, COLUMN_TOLERANCE_COLORS, true);    

    int nbBlocks = min(hist.size(), COLUMN_NB_COLORS);
    float freqTotal = 0;
    for (int i=0; i<nbBlocks; i++)
    {
      HistEntry e = (HistEntry) hist.get(i);
      freqTotal += e.freq;
    }

    float hBlock = 0; 
    for (int i=nbBlocks-1; i>=0; i--)
    {
      HistEntry e = (HistEntry) hist.get(i);
      hBlock = e.freq / freqTotal * height;
      yFirstBlock -= hBlock;
      this.blocks.add( new ColumnBlock(e.col.toARGB(), this.x, yFirstBlock, this.w, hBlock) );
    }
  }


  // ------------------------------------
  synchronized public void update()
  {
    if (yFirstBlock < 0)
    {
      yFirstBlock += COLUMN_SPEED * 0.02;
      for (ColumnBlock block : blocks)
      {
        block.y += COLUMN_SPEED * 0.02;
      }
    } else
    {
      yFirstBlock = 0;
    }
  }

  // ------------------------------------
  synchronized public void draw()
  {
    for (ColumnBlock block : blocks)
    {
      block.draw();
    }
    
    if (__DEBUG__)
    {
      fill(255);
      text(yFirstBlock, this.x + 5, 12);
    }
  }
}