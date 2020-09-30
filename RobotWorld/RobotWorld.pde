World WD = new World();
Robot RD= new Robot();
Target TG = new Target();
String[] Map;

void polygon(float x, float y, float radius, int npoints) {
  float angle = TWO_PI / npoints;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void setup() {
  size(600, 600);
}

void draw() {
WD.getMaxX();
WD.getMaxY();
  WD.draw();
  RD.draw(0,0);
  TG.draw(3,3);
}

class World {
  int maxX, maxY,Col;
  
  //int[][] block;

  void draw() {
    int X= 600/maxX;
    int Y= 600/maxY;
    for (int i =0; i < (maxX ); i = i+1) {
      for (int j = 0; j < (maxY ); j = j+1) {
        if(WD.getMap(i,j) == true){
          Col = 250;
        }else{
        Col = 0; 
      }
        fill(Col);
        rect(i*X, j*Y, X, Y);
      }
    }
  }

  int getMaxX() {
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    maxX = mapread.length;
    return maxX;
  }

  int getMaxY() {
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    String[] block = split(mapread[Y], '-');
    maxY = block.length;
    return maxY;
  }
  boolean getMap(int X, int Y) {
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    String[] block = split(mapread[Y], '-');

    return(boolean(int(block[X])));
  }
}

class Robot {
  int distance;
  int direction;

  Robot() {
  }

  void draw(int posiX,int posiY) {
    fill(0,0,255);
     triangle(float((600/WD.getMaxX()*posiX)+600/WD.getMaxX()/2),float(600/WD.getMaxY()*posiY),float(600/WD.getMaxX()*posiX),float(600/WD.getMaxY()*(posiY+1)),float(600/WD.getMaxX()*(posiX+1)), float(600/WD.getMaxY()*(posiY+1)));
   fill(0);
}

  void move() {
  }
}

class Target {
 int posX, posY;
  void draw(int posX,int posY) {
  polygon((600/WD.getMaxX()*posX)+600/WD.getMaxX()/2,(600/WD.getMaxY()*posY)+600/WD.getMaxY()/2,600/WD.getMaxX(), 8);
  }

  int getPosX() {
    return posX;
  }

  int getPosY() {
    return posY;
  }
}

class Obstruction {
  int size;
  float posX, posY;
  //int[][] walls;

  void draw() {
  }

  boolean block() {
    
    return true;
  }
}
