World WD = new World();
Robot RB= new Robot();
Target TG = new Target();
String[] Map;
  int i;

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
 i = 0;
}

void draw() {
  WD.getMaxX();
  WD.getMaxY();
if(i> 0){
background(0); 
WD.draw();

  TG.draw(3, 3);

  delay(1000);
  RB.moveLeft();
}else{

  background(0); 
  WD.draw();
  RB.draw(2, 0);


  TG.draw(3, 3);
}
i +=1;
}

class World {
  int maxX, maxY, Col;

  //int[][] block;

  void draw() {
    int X= 600/maxX;
    int Y= 600/maxY;
    for (int i =0; i < (maxX ); i = i+1) {
      for (int j = 0; j < (maxY ); j = j+1) {
        if (WD.getMap(i, j) == true) {
          Col = 250;
        } else {
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
  int direction;
  int posiX, posiY;
  Robot() {
  }

  void draw(int posX, int posY) {
    posiX = posX;
    posiY = posY;
    fill(0, 0, 255);
    triangle(float((600/WD.getMaxX()*posiX)+600/WD.getMaxX()/2), float(600/WD.getMaxY()*posiY), float(600/WD.getMaxX()*posiX), float(600/WD.getMaxY()*(posiY+1)), float(600/WD.getMaxX()*(posiX+1)), float(600/WD.getMaxY()*(posiY+1)));
    fill(0);
  }

  void moveUp() {
    posiY -= 1;
    RB.draw(posiX, posiY);
  }
  void moveDown() {
    posiY += 1;

    fill(0, 0, 255);
    triangle(float((600/WD.getMaxX()*posiX)+600/WD.getMaxX()/2), float(600/WD.getMaxY()*(posiY+1)), float(600/WD.getMaxX()*posiX), float(600/WD.getMaxY()*posiY), float(600/WD.getMaxX()*(posiX+1)), float(600/WD.getMaxY()*posiY));
    fill(0);
  }

  void moveLeft() {
    posiX -= 1;

    fill(0, 0, 255);
    triangle(float(600/WD.getMaxX()*(posiX+1)), float(600/WD.getMaxY()*posiY+1), float(600/WD.getMaxX()*(posiX)), float((600/WD.getMaxY()*posiY)+600/WD.getMaxX()/2), float(600/WD.getMaxX()*(posiX+1)), float(600/WD.getMaxY()*(posiY+1)));
    fill(0);
  }
  void moveRight() {
    posiX += 1;

    fill(0, 0, 255);
    triangle(float(600/WD.getMaxX()*posiX), float(600/WD.getMaxY()*posiY), float(600/WD.getMaxX()*(posiX+1)), float((600/WD.getMaxY()*posiY)+600/WD.getMaxX()/2), float(600/WD.getMaxX()*(posiX)), float(600/WD.getMaxY()*(posiY+1)));
    fill(0);
  }
}

class Target {
  int posX, posY;
  void draw(int posX, int posY) {
    fill(255, 0, 0);
    polygon((600/WD.getMaxX()*posX)+600/WD.getMaxX()/2, (600/WD.getMaxY()*posY)+600/WD.getMaxY()/2, 600/WD.getMaxX()/2, 8);
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
  //int[][] walls;

  void draw() {
  }

  boolean block() {

    return true;
  }
}
