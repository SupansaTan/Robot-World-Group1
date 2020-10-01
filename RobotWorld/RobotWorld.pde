World WD;
Robot RB;
Target TG;
Obstruction[] barrier = new Obstruction[5];

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
  
  // create all obstruction 
  for(int i=0; i < 5; i++){
    barrier[i] = new Obstruction(WD.getSize());
  }
}

void draw(){
  background(0);
  WD.draw();
  RB.draw();
  TG.draw();
  
  for(Obstruction br : barrier){
      br.draw();
  }
}

class World {
  int maxX, maxY; // maximum of both position x and y
  int Color, size; 
  String[] Map;
  IntList rowsWhite = new IntList();
  IntList colsWhite = new IntList();
  
  World(){
    maxX = this.getMaxX();
    maxY = this.getMaxY();
    this.blockWhite();
    size = rowsWhite.size();
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
  
  void blockWhite(){
    // contains row and column that the robot can walk 
    for(int i=0; i<maxX; i++){
      for(int j=0; j<maxY; j++){
        if(this.getMap(i,j)){
          rowsWhite.append(i);
          colsWhite.append(j);
        }
      }
    }
  }
  
  int getRowWhite(int index){
    return rowsWhite.get(index);
  }
  
  int getColWhite(int index){
    return colsWhite.get(index);
  }
  
  int getSize(){
    return size;
  }
  
  void deleteList(int index){
    rowsWhite.remove(index);
    colsWhite.remove(index);
    this.size -= 1;
  }
}

class Robot {
  int posX, posY, direction, rand;
  
  Robot() {
    rand = (int)random(WD.getSize());
    WD.deleteList(rand);
    posX = WD.getRowWhite(rand);
    posY = WD.getColWhite(rand);
    WD.deleteList(rand);
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
  int rand; // random index 
  
  Target(){
    rand = (int)random(WD.getSize());
    posX = WD.getRowWhite(rand);
    posY = WD.getColWhite(rand);
    WD.deleteList(rand);
  }
  
  void draw(){
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
  int row, col, size, rand;
  
  Obstruction(int sizeList){
    rand = (int)random(sizeList);
    row = WD.getRowWhite(rand);
    col = WD.getColWhite(rand);
    WD.deleteList(rand);
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
