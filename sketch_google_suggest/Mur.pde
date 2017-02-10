class Mur
{
  float x, w;
  float yBlock=0;
  // Timer
  Timer timerLoadData;
  // Termes séparés par des virgules
  String[] terms, newTerms, startTerms;
  boolean hasNewTerms = false;
  boolean bClearBlocks = false;
  // Mots
  ArrayList<BlockMot> blocks;
  BlockMot blockPrevious;
  color c;
  float scrollY = 0;
  String lang;

  // ------------------------------------
  Mur(String lang_, color c_, float x_, float w_, String[] terms_)
  {
    this.lang = lang_;
    this.c = c_;
    this.x = x_;
    this.w = w_;
    this.terms = terms_;
    this.startTerms = new String[terms.length];
    arrayCopy(terms,0,startTerms,0,terms.length);
  }  

  // ------------------------------------
  void setup()
  {
    blocks = new ArrayList<BlockMot>();
    BlockMot blockStart = addBlock(terms);
    blockStart.setAlpha(255);
    blockPrevious = blockStart;

    timerLoadData = new Timer(false);
    timerLoadData.scheduleAtFixedRate(new DataLoadTask(this), 2*(long)periodLoadData*1000, (long) periodLoadData*1000);
  }

  // ------------------------------------
  String chooseSuggest(JSONArray suggests)
  {
    int suggestNb = suggests.size();
    String suggest = "";
    if (suggestNb == 0)
    {
      return RiTa.untokenize(startTerms);
    }

    boolean found = false;
    while (!found)
    {
      int suggestRnd = (int)random( suggestNb );
      suggest = suggests.getString(suggestRnd);
      if (suggest.length()>=4 && !suggest.substring(4).equals("http"))
      {
  //      String[] suggestWords = RiTa.tokenize( suggest );
//        if (suggestWords[0].equals(terms[0]))
        {
          found = true;
        }
      }
    }
    return suggest;
  }

  // ------------------------------------
  void loadData()
  {
    println("loadData()");
    println(" - terms = " + getString(terms));

    JSONArray data = loadJSONArray( makeUrl( terms, lang ) );
    JSONArray suggests = data.getJSONArray(1);

    println(suggests);
    
    String suggest = chooseSuggest(suggests);

    println(" - suggest = "+suggest);
    
    String[] suggestWords = RiTa.tokenize( suggest );
    println(" - suggestWords = "+getString(suggestWords));

    if (suggestWords.length > terms.length)
    {
      newTerms = new String[suggestWords.length-terms.length];
      for (int i=terms.length; i<suggestWords.length; i++)
      {
        println("suggestWords["+i+"]= "+suggestWords[i]);
        newTerms[i-terms.length] = suggestWords[i];
      }

      println(" - newTerms = "+getString(newTerms));
      
      hasNewTerms = true;
    }
  }

  // ------------------------------------
  BlockMot addBlock(String[] newterms_)
  {
      String s = RiTa.untokenize(newterms_);
      float widthBlock = textWidth(s);
      float xBlock = 0.5*(w - widthBlock) + random(-0.3*w,0.3*w);
      if (blockPrevious != null)
      {
        xBlock = blockPrevious.x + 0.5*blockPrevious.w + random(-0.9*widthBlock-0.9*blockPrevious.w/2, 0.9*blockPrevious.w/2);
      }
      if (xBlock<0) xBlock=0;
      if (xBlock+widthBlock>w) xBlock = w-widthBlock;
    
    
      BlockMot blockMot = new BlockMot(this, s, xBlock, yBlock, widthBlock, heightBlock );
      blocks.add(blockMot);
      yBlock+=heightBlock;
      
      return blockMot;
  }

  // ------------------------------------
  synchronized void draw()
  {
    if (hasNewTerms && newTerms!=null)
    {
      BlockMot blockNew = addBlock(newTerms);
      blockNew.begin();
      terms = new String[1];
      terms[0] = newTerms[newTerms.length-1];

      hasNewTerms = false;
      blockPrevious = blockNew;
      
      if (blockNew.y > 0.66*height)
      {
        Ani.to(this, scrollSpeed, "scrollY", scrollY-heightBlock);
      }
    }
    
    pushStyle();
    pushMatrix();
    noStroke();
    fill(c);
    translate(x,0);
    rect(0, 0, this.w, height);

    translate(0,scrollY);
    for (BlockMot block : blocks)
    {
      if (scrollY+block.y+heightBlock>0)
        block.draw();
    }
    popMatrix();
    popStyle();
  }
}