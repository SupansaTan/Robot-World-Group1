World WD;
Robot RB;
Target TG;

void polygon(float x, float y, float radius, int npoints) {
  // method for make any shape
  
  float angle = TWO_PI / npoints;
  beginShape();
  
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  
  endShape(CLOSE);
}

void setup(){
  size(600, 600);
  WD = new World();
  RB = new Robot();
  TG = new Target();
}

void draw(){
  background(0);
  WD.draw();
  RB.draw();
  TG.draw();
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

  void draw(){
    if(keyPressed){
      // when pressed button
      this.move();
    }
    
    fill(0,0,255);
    triangle((600/WD.getMaxX()*this.posX)+600/WD.getMaxX()/2, 600/WD.getMaxY()*this.posY, 600/WD.getMaxX()*this.posX, 600/WD.getMaxY()*(this.posY+1), 600/WD.getMaxX()*(this.posX+1), 600/WD.getMaxY()*(this.posY+1));
  }

  void move(){
    switch(keyCode){
      // when pressed arrow button
      
      case UP:
        // move forward
        this.posY -= 1;
        break;
        
      case DOWN:
        // move backward
        this.posY += 1;
        break;
        
      case LEFT:
        // move left
        this.posX -= 1;
        break;
        
      case RIGHT:
        // move right
        this.posX += 1;
        break;
    }  
  }
}

class Target {
  int posX, posY;
  
  Target(){
    posX = (int)random(WD.getMaxX());
    posY = (int)random(WD.getMaxY());
  }
  
  void draw() {
    fill(255,0,0);
    polygon((600/WD.getMaxX()*this.posX)+600/WD.getMaxX()/2, (600/WD.getMaxY()*this.posY)+600/WD.getMaxY()/2, 600/WD.getMaxX()/2.5, 8);
  }

  int getPosX() {
    return this.posX;
  }

  int getPosY() {
    return this.posY;
  }
}

class Obstruction {
  int row, col, size;

  void draw(){
  }

  boolean hasBarrier(int row, int column){
    // check that position has barrier or not
    return true;
  }
}
