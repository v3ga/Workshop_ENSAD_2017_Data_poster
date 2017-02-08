// ------------------------------------
import codeanticode.syphon.*;
import toxi.color.*;
import toxi.math.*;
import java.util.*;
import java.nio.file.*;
import static java.nio.file.StandardWatchEventKinds.*;


// ------------------------------------
ColumnColor column;
SyphonServer server;


// ------------------------------------
void settings() 
{
  size(400,400, P3D);
  PJOGL.profile=1;
}

// ------------------------------------
void setup() 
{
  server = new SyphonServer(this, "Processing Syphon");

  column = new ColumnColor( "data/instagram/",0,0,width,height);
  column.start();
}

// ------------------------------------
void draw() 
{
  background(0);
  column.draw();
  server.sendScreen();
}