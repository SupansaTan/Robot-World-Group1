World WD;
Robot RD;
Target TG;

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
  WD = new World();
  RD = new Robot();
  TG = new Target();
}

void draw() {
  fill(0);
  WD.draw();
  RD.draw();
  TG.draw(3,3);
}

class World {
  int maxX, maxY; // maximum of both position x and y
  int Color; 
  String[] Map;
  
  World(){
    maxX = this.getMaxX();
    maxY = this.getMaxY();
  }

  void draw() {
    int X = 600/maxX;
    int Y = 600/maxY;
    for (int i =0; i < (maxX ); i = i+1) {
      for (int j = 0; j < (maxY ); j = j+1) {
        if(WD.getMap(i,j) == true){
          Color = 250; // this block can walk
        }
        else{
          Color = 0; // this block can't walk 
        }
        fill(Color);
        strokeWeight(2);
        rect(i*X, j*Y, X, Y);
        strokeWeight(0);
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
  float posX, posY, direction;

  Robot() {
    posX = (int)random(WD.getMaxX());
    posY = (int)random(WD.getMaxY());
  }

  void draw() {
    fill(0,0,255);
    triangle((600/WD.getMaxX()*posX)+600/WD.getMaxX()/2, 600/WD.getMaxY()*posY, 600/WD.getMaxX()*posX, 600/WD.getMaxY()*(posY+1), 600/WD.getMaxX()*(posX+1), 600/WD.getMaxY()*(posY+1));
  }

  void move() {
  }
  
}

class Target {
  int posX, posY;
  
  Target(){
    posX = (int)random(WD.getMaxX());
    posY = (int)random(WD.getMaxY());
  }
  
  void draw(int posX,int posY) {
    fill(255,0,0);
    polygon((600/WD.getMaxX()*posX)+600/WD.getMaxX()/2, (600/WD.getMaxY()*posY)+600/WD.getMaxY()/2, 600/WD.getMaxX()/2.5, 8);
    fill(0);
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

  void draw(){
  }

  boolean hasBarrier(int posX, int posY){
    // check that position has barrier or not
    return true;
  }
}
