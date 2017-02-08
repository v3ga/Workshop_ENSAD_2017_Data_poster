class Candidat
{
  String id = "";
  String[] hashtag;
  PImage img;
  float imgAlpha = 0.0;
  float imgAlphaDuration = 2.0;
  float popularity = 0;  
  int twitCount = 0;
  int twitCountAll = 0;
  long twitLastId = 0;

  Candidat(String id_, String[] hashtag_)
  {
    this.id = id_;
    this.hashtag = hashtag_;
    this.img = loadImage(this.id+".jpg");
  }


  // ------------------------------------
  void getNewTweets()
  {
    println(">>>>>> " + this.id);

    for (int i=0; i<hashtag.length; i++)
    {
      try
      {
        List<Status> tweets = null;
        Query query = new Query(this.hashtag[i]);
        if (twitLastId > 0)
          query.setSinceId(twitLastId);

        println("------ search for " + this.hashtag[i]);  

        QueryResult result = twitter.search(query);
        tweets = result.getTweets();

        twitCount += tweets.size();

        println("------ found " + tweets.size() + " tweet(s) - total = " + twitCount);  

        for (Status status : tweets)
        {
          // println("["+status.getId()+"] " + status.getText());
          if (status.getId() > twitLastId)
            twitLastId = status.getId();
        }

        println("------ last id= " + twitLastId);
      }
      catch (TwitterException te)
      {
        println("------ failed to search tweets: " + te.getMessage());
      }

    }
      saveData();
  }

  // --------------------------------------------
  void computePopularity(ArrayList<Candidat> candidates)
  {
    twitCountAll = 0;
    for (Candidat candidat : candidates)
    {
      twitCountAll += candidat.twitCount;
    }
    popularity = (float) twitCount / (float)twitCountAll;
  }

  // --------------------------------------------
  void animateAlpha()
  {
    Ani.to(this,imgAlphaDuration,"imgAlpha", 255.0*popularity); 
    println(255.0*popularity);
  }

  // --------------------------------------------
  void loadData()
  {
    try
    {
      processing.data.JSONObject json = loadJSONObject(getFilePathData());
      if (json != null)
      {
        twitLastId = json.getLong("twitLastId");
        twitCount = json.getInt("twitCount");
      }
    } 
    catch (Exception e) {
    }
  }

  // --------------------------------------------
  void saveData()
  {
    processing.data.JSONObject json = new processing.data.JSONObject();
    json.setLong("twitLastId", twitLastId);
    json.setInt("twitCount", twitCount);
    saveJSONObject(json, getFilePathData());
  }

  // --------------------------------------------
  String getFilePathData()
  {
    return "data/"+this.id+".json";
  }

  // --------------------------------------------
  String toString()
  {
    return this.id + " - twitCount=" + twitCount + " / "+twitCountAll+" - popularity="+nf(popularity, 1, 3)+"%";
  }
}