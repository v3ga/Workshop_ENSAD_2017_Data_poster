class Mur
{
  float x,w;
  float yBlock=0;
  float heightBlock = 50;
  // Timer
  Timer timerLoadData;
  // Période
  float periodLoadData = 10.0;
  // Termes séparés par des virgules
  String[] terms;
  // Mots
  ArrayList<BlockMot> blocks;
  
  // ------------------------------------
  Mur(float x_, float w_, String[] terms_)
  {
    this.x = x_;
    this.w = w_;
    this.terms = terms_;
  }  

  // ------------------------------------
  void setup()
  {
    blocks = new ArrayList<BlockMot>();
    BlockMot blockStart = new BlockMot(this, RiTa.untokenize(terms), yBlock, heightBlock );
    blockStart.setAlpha(255);
    blocks.add(blockStart);
    yBlock+=50;

    timerLoadData = new Timer(false);
    timerLoadData.scheduleAtFixedRate(new DataLoadTask(this), 0, (long) periodLoadData*1000);
  }

  // ------------------------------------
  void loadData()
  {
    JSONArray data = loadJSONArray( makeUrl( terms ) );
    JSONArray suggests = data.getJSONArray(1);
    int suggestNb = suggests.size();
    int suggestRnd = (int)random( suggestNb );

    String[] words = RiTa.tokenize( suggests.getString(suggestRnd) );

    if (words.length > terms.length)
    {
      String[] newTokens = new String[words.length-terms.length];
      for (int i=terms.length; i<words.length; i++)
      {
        newTokens[i-terms.length] = words[i]; 
      }
      // Block text
      String blockTxt = RiTa.untokenize(newTokens);
      
      terms = new String[1];
      terms[0] = words[words.length-1];
      
      BlockMot blockStart = new BlockMot(this, RiTa.untokenize(newTokens), yBlock, heightBlock );
      blockStart.setAlpha(255);
      blocks.add(blockStart);
      yBlock+=50;
    }
  }

  // ------------------------------------
  synchronized void draw()
  {
    pushStyle();
    noStroke();
    fill(0);
    rect(x,0,this.w,height);
    for (BlockMot block : blocks)
      block.draw();
    popStyle();
  }
}