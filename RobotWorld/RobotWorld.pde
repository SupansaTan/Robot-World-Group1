World world;

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
  world = new World();
  world.robot = new Robot();
  world.target = new Target();
  
  // create all obstruction 
  for(int i=0; i < 5; i++){
    world.barriers[i] = new Obstruction(world.getSize());
  }
}

void draw(){
  background(0);
  world.draw();
  world.robot.draw();
  world.target.draw();
  
  for(Obstruction barrier : world.barriers){
      barrier.draw();
  }
}

void keyPressed(){
  world.robot.move();
  world.robot.hasPressedKey = true;
}

void keyReleased(){
  world.robot.hasPressedKey = false;
}

class World {
  int maxX, maxY; // maximum of both position x and y
  int Color, size; 
  String[] Map;
  IntList rowsWhite = new IntList();
  IntList colsWhite = new IntList();
  
  public Robot robot;
  public Target target;
  Obstruction[] barriers;
  
  World(){
    maxX = this.getMaxX();
    maxY = this.getMaxY();
    this.blockWhite();
    size = rowsWhite.size();
    barriers = new Obstruction[5]; 
  }
  
  void draw() {
    int X = 600/maxX;
    int Y = 600/maxY;
    for (int i =0; i < (maxX ); i = i+1) {
      for (int j = 0; j < (maxY ); j = j+1) {
        if(world.getMap(i,j) == true){
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
  int posX, posY,  rand;
  float direction;
  public boolean hasPressedKey = false;
  
  Robot() {
    rand = (int)random(world.getSize());
    posX = world.getRowWhite(rand);
    posY = world.getColWhite(rand);
    world.deleteList(rand);
    direction = radians(90);
  }

  void draw(){
    
    // find the center point of the block to be the center of triangle
    int centerX = (int)((width/world.getMaxX() * (this.posX+1)) - (width/world.getMaxX() * (this.posX)))/2 + (width/world.getMaxX()*this.posX);
    int centerY = (int)((height/world.getMaxY() * (this.posY+1)) - (height/world.getMaxY() * (this.posY)))/2 + (height/world.getMaxY()*this.posY);
    
    // set position of head triangle
    float headPosX = centerX - 25 * (cos(direction+radians(0)));
    float headPosY = centerY - 25 * (sin(direction+radians(0)));
    
    // set position of left triangle
    float leftPosX = centerX - 32 * (cos(direction+radians(135)));
    float leftPosY = centerY - 32 * (sin(direction+radians(135)));
    
    // set position of right triangle
    float rightPosX = centerX - 32 * (cos(direction+radians(225)));
    float rightPosY = centerY - 32 * (sin(direction+radians(225)));;
    
    fill(0,0,255);
    triangle(headPosX, headPosY, leftPosX, leftPosY, rightPosX, rightPosY);
  }

  void move(){
    if(hasPressedKey == false){
      switch(keyCode){
        // when pressed arrow button
        
        case UP:
          // move forward
          this.posY -= 1;
          direction = radians(90);
          break;
          
        case DOWN:
          // move backward
          this.posY += 1;
          direction = radians(270);
          break;
          
        case LEFT:
          // move left
          this.posX -= 1;
          direction = radians(0);
          break;
          
        case RIGHT:
          // move right
          this.posX += 1;
          direction = radians(180);
          break;
      }  
    }
  }
}

class Target {
  int posX, posY;
  int rand; // random index 
  
  Target(){
    rand = (int)random(world.getSize());
    posX = world.getRowWhite(rand);
    posY = world.getColWhite(rand);
    world.deleteList(rand);
  }
  
  void draw(){
    fill(255,0,0);
    polygon((600/world.getMaxX()*this.posX)+600/world.getMaxX()/2, (600/world.getMaxY()*this.posY)+600/world.getMaxY()/2, 600/world.getMaxX()/2.5, 8);
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
    row = world.getRowWhite(rand);
    col = world.getColWhite(rand);
    world.deleteList(rand);
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
