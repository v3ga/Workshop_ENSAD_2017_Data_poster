class Query
{
  String what = "";
  int count = 0;
  long lastTimestamp=0;
  
  
  
  // ------------------------------------
  Query(String what_)
  {
    this.what = what_;
  }

  // ------------------------------------
  void run()
  {
    try
    {
      Response response= Jsoup.connect(url+"&q="+what)
        .ignoreContentType(true)
        .userAgent("Mozilla/5.0 (Windows NT 6.1; Win64; x64; rv:25.0) Gecko/20100101 Firefox/25.0")  
        .referrer("http://www.google.com")   
        .timeout(12000) 
        .followRedirects(true)
        .execute();

      String data = response.parse().select("body").html();
      JSONObject obj = parseJSONObject(data);
      JSONArray values = obj.getJSONArray("data");

      // println("----------------------");
      
      count = 0;
      for (int i=0; i<values.size(); i++)
      {
        JSONArray a = values.getJSONArray(i);
        long timestamp = a.getLong(0);
        int nb = a.getInt(1); 
        if (timestamp > lastTimestamp)
        {
          count += nb;
          lastTimestamp = timestamp;
          
          Timestamp time = new Timestamp(timestamp);
          // println( time + " ["+what+"] — " + nb + " / " + count  ); 
        }
      }
    }
    catch (Exception e) 
    {
    }
  }
}