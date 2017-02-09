class ScrapImages extends Thread
{
  String command;

  // ------------------------------------
  ScrapImages(String command_)
  {
    this.command = command_;
  }

  // ------------------------------------
  void run()
  {
    StringBuffer output = new StringBuffer();
    try 
    {
      Process p = Runtime.getRuntime().exec(command);
      p.waitFor();
      BufferedReader reader = new BufferedReader(new InputStreamReader(p.getInputStream()));
      String line = "";
      while ((line = reader.readLine())!= null) {
        output.append(line + "\n");
      }
      println( output.toString() );
    }
    catch (Exception e) 
    {
      e.printStackTrace();
    }
  }
}