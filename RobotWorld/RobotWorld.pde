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
  IntList rowsWhite = new IntList();
  IntList colsWhite = new IntList();
  Obstruction[] barrier = new Obstruction[5];
  
  World(){
    maxX = this.getMaxX();
    maxY = this.getMaxY();
    
    // create all obstruction 
    for(int i=0; i < 5; i++){
      barrier[i] = new Obstruction(maxX, maxY);
    }
  }
  
  void draw() {
    int X = 600/maxX;
    int Y = 600/maxY;
    for (int i =0; i < (maxX ); i = i+1) {
      for (int j = 0; j < (maxY ); j = j+1) {
        if(WD.getMap(i,j) == true){
          Color = 250; // this block can walk
          rowsWhite.append(i);
          colsWhite.append(j);
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
    
    for(Obstruction br : barrier){
      br.draw();
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
  int posX, posY, direction;
  
  Robot() {
    posX = (int)random(WD.getMaxX());
    posY = (int)random(WD.getMaxY());
    direction = 0;
  }

  void draw(){
    if(keyPressed){
      // when pressed button
      this.move();
    }

    // set position of head triangle
    int headPosX = (int)((width/WD.getMaxX()*this.posX)+ (600/WD.getMaxX()/2) - (cos(direction+radians(180))));
    int headPosY = (int)((height/WD.getMaxY()*this.posY) + height/120 - (sin(direction+radians(180))));
    
    // set position of left triangle
    int leftPosX = (int)((width/WD.getMaxX() * this.posX) + width/120 - (cos(direction+radians(90))));
    int leftPosY = (int)((height/WD.getMaxY() * (this.posY+1)) - height/120 - (sin(direction+radians(90))));
    
    // set position of right triangle
    int rightPosX = (int)((width/WD.getMaxX() * (this.posX+1)) - width/120 - (cos(direction+radians(90))));
    int rightPosY = (int)((height/WD.getMaxY() * (this.posY+1)) - height/120 - (sin(direction+radians(90))));
    
    fill(0,0,255);
    triangle(headPosX, headPosY, leftPosX, leftPosY, rightPosX, rightPosY);
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
  
  Obstruction(int rowMax, int colMax){
    row = (int)random(rowMax);
    col = (int)random(colMax);
    size = 50;
  }

  void draw(){
    int posX = (int)(60*(this.row) + 5);
    int posY = (int)(60*(this.col) + 5);
    
    fill(131,105,83); // brown color
    strokeWeight(2);
    rect(posX, posY, size, size);
    fill(0);
    line(posX, posY, posX+size, posY+size);
    line(posX, posY+size, posX+size, posY);
    strokeWeight(1);
  }

  boolean hasBarrier(int row, int column){
    // check that position has barrier or not
    return true;
  }
}
