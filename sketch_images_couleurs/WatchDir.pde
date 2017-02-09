class WatchDir extends Thread
{
  WatchService ws;


  // ------------------------------------
  WatchDir(String dir)
  {
    try
    {
      ws = FileSystems.getDefault().newWatchService();
      Path path = Paths.get(dir);
      path.register(ws, ENTRY_CREATE, ENTRY_DELETE, ENTRY_MODIFY);
    }
    catch(Exception e) {
    }
  }

  // ------------------------------------
  public void processFileCreated(String path)
  {
  }

  // ------------------------------------
  public void run()
  {
    while (true) {
      WatchKey key;
      try {
        key = ws.take();
      } 
      catch (InterruptedException ex) {
        return;
      }

      for (WatchEvent<?> event : key.pollEvents()) 
      {
        WatchEvent.Kind<?> kind = event.kind();

        WatchEvent<Path> ev = (WatchEvent<Path>) event;
        Path fileName = ev.context();

        if (kind == ENTRY_CREATE)
        {
          System.out.println(kind.name() + ": " + fileName);
          processFileCreated(fileName.toString());
        }
      }

      boolean valid = key.reset();
      if (!valid) {
        break;
      }
    }
  }
}