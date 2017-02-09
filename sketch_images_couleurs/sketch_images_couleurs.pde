// ------------------------------------
import codeanticode.syphon.*;
import toxi.color.*;
import toxi.math.*;
import java.util.*;
import java.nio.file.*;
import static java.nio.file.StandardWatchEventKinds.*;

// ------------------------------------
boolean __DEBUG__ = true;
float COLUMN_SPEED = 100;
int COLUMN_NB_COLORS = 6;


// ------------------------------------
ArrayList<ColumnColor> columns;
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

  columns = new ArrayList<ColumnColor>();
  columns.add( new ColumnColor("data/instagram/",0,0,width/2,height) );
  columns.add( new ColumnColor("data/pinterest/",width/2,0,width/2,height) );

  for (ColumnColor column : columns)
    column.start();
}

// ------------------------------------
void draw() 
{
  background(0);
  for (ColumnColor column : columns)
  {
    column.update();
    column.draw();
  }
  
  server.sendScreen();
}