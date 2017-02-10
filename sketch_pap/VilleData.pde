class VilleData
{
  String nom;
  String url;
  int x;

  // Liste des annonces
  ArrayList<Annonce> annonces;
  Annonce annonceCurrent;
  int annonceCurrentIndex=0;
  int nbPages = 0;

  PGraphics offscreen;
  float xText = 0; 
  float wText = 0;

  int m2 = 40;
  float fonteSize = 110;
  float fonteOffset = 60;
  PFont fonte;


  // ------------------------------------
  VilleData(String nom_, String url_, int x_, int w_)
  {
    this.nom = nom_;
    this.url = url_;
    this.x = x_;
    this.offscreen = createGraphics(w_, height);
    this.annonces = new ArrayList<Annonce>();
  }

  // ------------------------------------
  void loadData()
  {
    try
    {
      Document doc = Jsoup.connect(url).get(); 

      // Pagination    
      Elements pagination = doc.select(".pagination ul li");
      //    println( pagination.size()-1 );
      nbPages = pagination.size() > 1 ? pagination.size()-1 : 1;

      // Extract annonces from page
      Elements results = doc.select(".search-results-item");
      for (Element result : results)
      {
        Elements elmtTitle = result.select(".title-item .h1");
        Elements elmtPrice = result.select(".title-item .price");
        Elements elmtDesc = result.select(".box-body .item-description");

        if (elmtTitle.size() == 1 && elmtPrice.size() == 1 )
        {
          println( " - title = " + Jsoup.parse(elmtTitle.html()).text() + " / prix = " + Jsoup.parse(elmtPrice.html()).text() );
          println( " - description = " + Jsoup.parse(elmtDesc.html()).text());
          annonces.add( new Annonce(
            Jsoup.parse(elmtTitle.html()).text(), 
            Jsoup.parse(elmtPrice.html()).text(), 
            Jsoup.parse(elmtDesc.html()).text()
            ) );
        }
      }
    }
    catch(Exception e)
    {
    }
    selectAnnonce();
  }

  // ------------------------------------
  void selectAnnonce()
  {
    annonceCurrent = (Annonce) annonces.get(annonceCurrentIndex);


    m2 = 9;
    Iterator it = blocs.entrySet().iterator();
    int mindist = 100000;
    while (it.hasNext())
    {
      Map.Entry pair = (Map.Entry)it.next();
      // System.out.println(pair.getKey() + " = " + pair.getValue());
      int value = (int)pair.getKey();
      int dist = abs(value - annonceCurrent.surface);
      if (dist < mindist)
      {
        mindist = dist;
        m2 = value;
      }
    }

    if (m2 < 20) 
    {
      fonte = fontes[0];
      fonteSize = 2 * hauteurBlock;
      fonteOffset = hauteurBlock-10;
    }
    else if (m2 < 30)
    {
      fonte = fontes[1];
      fonteSize = 3 * hauteurBlock;
      fonteOffset = 1.5*hauteurBlock;
    }
    else 
    {
      fonte = fontes[2];
      fonteSize = 4 * hauteurBlock;
      fonteOffset = 2*hauteurBlock;
    }
    offscreen.beginDraw();
    offscreen.textFont(fonte, fonteSize);
    wText = offscreen.textWidth(annonceCurrent.description);
    offscreen.endDraw();

    xText = offscreen.width + 5;
  }

  // ------------------------------------
  void render()
  {
    offscreen.beginDraw();
    offscreen.background(255);

    offscreen.image( blocs.get(m2), 0, 0 );
    offscreen.fill(0, 0, 0);
    offscreen.text(annonceCurrent.description, (int)xText, offscreen.height/2 + fonteOffset);

    offscreen.endDraw();

    xText = xText - vitesseText;
    if (xText + wText < 0)
    {
      annonceCurrentIndex  = (annonceCurrentIndex+1)%annonces.size();
      selectAnnonce();
    }
  }

  // ------------------------------------
  void draw()
  {
    image(offscreen, x, 0);
  }
}