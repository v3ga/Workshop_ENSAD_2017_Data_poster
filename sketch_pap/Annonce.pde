class Annonce
{
  String title;
  String price;
  String description;
  
  int priceInt = 0;
  int surface = 0;
  int arrondissement = 0;


  // ------------------------------------
  Annonce(String title_, String price_, String description_)
  {
    this.title = title_;
    this.price = price_;
    this.description = description_;
    
    extractData();
  }
  
  // ------------------------------------
  void extractData()
  {
    Pattern patternTitle = Pattern.compile("[0-9]+");
    Matcher matcherTitle = patternTitle.matcher( this.title+"/"+this.price );
    int index=0;
    while(matcherTitle.find()) 
    {
//        println(matcherTitle.group());
      if (index == 0) arrondissement = int(matcherTitle.group());
      if (index == 1) surface = int(matcherTitle.group());
      if (index == 2) priceInt = int(matcherTitle.group());
      index++;  
    }
  }

  // ------------------------------------
  void draw()
  {
      float x = random(width);
      float y = random(height);
      float w = sqrt( surface ) * 50;
      noFill();
      stroke(0);
      rect( x, y, w, w  );
      fill(0);
      text(description,x,y,w,w);

  }

}