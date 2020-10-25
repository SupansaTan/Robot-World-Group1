World world;
Flowchart flowchart;
int[][] info = new int[4][2];
boolean load = true;

/////////////////////////////////////////////////////
//
// Programmer: Thanakrit-Bank
//
// Description: This method can make any shape for example triangle rectangle octagon and etc
// to use you must input parameter position x, position y, radius and amount point of angle you want.
// 
/////////////////////////////////////////////////////
void polygon(float x, float y, float radius, int npoints) {  // method for make any shape
  float angle = TWO_PI / npoints; //angle for edge corner from the center
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius;
    float sy = y + sin(a) * radius;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}

void setup() {
  
  readfile();
  size(600, 600);
  world = new World();
  flowchart = new Flowchart();
  
  // add statements in flowchart 
  flowchart.add("move()");
  flowchart.ifStatement("isBlocked()", "turnLeft()", "turnRight()");
  flowchart.add("move()");
  flowchart.render();
  
  int randX = (int)random(world.getMaxX()-1);
  int randY = (int)random(world.getMaxY()-1);
  
  while(!world.checkIsWhite(randX, randY) || (randX == 0 && randY == 0)){  // if the result of random is blackblock or (0,0)
     randX = (int)random(world.getMaxX()-1);     // random the new one
     randY = (int)random(world.getMaxY()-1);
  }
    world.robot= new Robot(0,0,0);
    world.target = new Target(randX, randY);
   
    world.inputProcessor = new InputProcessor();
  
    world.getMaxX();
    world.getMaxY();
}

/////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Read file and spilt "," and close file
// 
/////////////////////////////////////////////////////
  void readfile() { 
  BufferedReader reader = createReader("position.txt");
  String line = null;
  int i = 0;
  try {
    while ((line = reader.readLine()) != null) {
        String[] pieces = split(line,",");
        info[i][0] = int(pieces[0]);
        info[i][1] = int(pieces[1]);
        i++;
    }
    reader.close();
  }
  catch (NullPointerException e) {
    e.printStackTrace();
    load = false;
  }
  catch (IOException e) {
    e.printStackTrace();
    load = false;
  }
  if(i != 4){
    load = false;
  }
}

/////////////////////////////////////////////////////
//
// Programmer: Thanakrit-Bank
//
// Description: This method will draw world, robot and target and if the robot met the target it will show text "You Won".
// 
/////////////////////////////////////////////////////

void draw() {
  background(0);
  world.draw();
  world.robot.draw();
  world.target.draw();
  
  world.getFlow(flowchart);
  
  if (world.target.met(world.robot.getX(), world.robot.getY()) == true) {
    // when position of the robot is same as the target
    background(250); // color : grey 
    textSize(60);
    text("You Won", 150, 280);
    noLoop();   
  }
  
  //world.getFlow(flowchart);
}

/////////////////////////////////////////////////////
//
// Programmer: Thanakrit-Bank
//
// Description: This method will process the keypressed that called from control in class InputProcessor.
// 
/////////////////////////////////////////////////////

void keyPressed() {
  world.inputProcessor.control();  
}

class World {
  int maxX, maxY;
  Robot robot;
  Target target;
  InputProcessor inputProcessor;
  String[] Map;

  void draw() {
    int X = width/maxX;
    int Y = height/maxY;
    int  colour;
    for (int i =0; i < (maxX ); i = i+1) {
      for (int j = 0; j < (maxY ); j = j+1) {
        if (world.getMap(i, j) == true) {
          colour = 250;
        }
        else {
          colour = 0;
        }
        fill(colour);
        rect(i*X, j*Y, X, Y);
      }
    }
  }
  
  void saveFile(String name){
      PrintWriter output;
      output = createWriter(name);
      output.println(world.getMaxX() + ","  + world.getMaxY());
      output.println(world.robot.getX() + "," + world.robot.getY());
      output.println(world.target.getPosX() + "," + world.target.getPosY());
      output.println(world.robot.direction + ","+0);
      output.flush();
      output.close();    
  }
  
  /////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Get number of string in array and return
// 
/////////////////////////////////////////////////////

  int getMaxX() { 
    // return horizontal block counts
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    maxX = mapread.length;
    return maxX;
  }
  
    /////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description:Get number of string in list that already "," and "-"
// 
/////////////////////////////////////////////////////

  int getMaxY() { 
    // return vertical block counts
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    String[] block = split(mapread[Y], '-');
    maxY = block.length;
    return maxY;
  }
  
      /////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Read file and retrun wanted block as boolean  
// 
/////////////////////////////////////////////////////
  boolean getMap(int X, int Y) { 
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    String[] block = split(mapread[Y], '-');
    return(boolean(int(block[X])));
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: check the block that color white or not? (the robot can walk pass white block) 
  // 
  /////////////////////////////////////////////////////
  boolean checkIsWhite(int blockX, int blockY){
    return world.getMap(blockX, blockY);
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: get all command in flowchart
  // 
  /////////////////////////////////////////////////////
  void getFlow(Flowchart flow)
  {
    for (int i=0; i < flow.getSize(); i++){
      if(!(flow.elements == null))
      {
        String command = flow.getFlowchart();
        
        if (command.charAt(0) == '[')
        {
          // if...else statement
          String[] statements = command.substring(1,command.length()-1).split(",");
          String condition = statements[0];
          String ifTrue = statements[1];
          String ifFalse = statements[2];
          
          // do if...else statement
          if(this.executeCommand(condition))
          {
            this.executeCommand(ifTrue);
          }
          else
          {
            this.executeCommand(ifFalse);
          }
        }
        else
        {
          this.executeCommand(command);
        }
      }
    }
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: execute the command from flowchart to control robot
  // 
  /////////////////////////////////////////////////////
  boolean executeCommand(String cmd)
  {
    if(cmd.equals("move()"))
    {
      world.robot.move();
      return true;
    }
    else if(cmd.equals("turnLeft()"))
    {
      world.robot.turnLeft();
      return true;
    }
    else if(cmd.equals("turnRight()"))
    {
      world.robot.turnRight();
      return true;
    }
    else if(cmd.equals("isBlocked()"))
    {
      return world.robot.isBlocked();
    }
    return false;
  }
}

class Robot {
  int direction; // 0:headup 1:headright 2:headdown 3:headleft
  int posX, posY;
  int headPosX, headPosY;
  int leftPosX, leftPosY;
  int rightPosX, rightPosY;
  
  Robot(int px,int py,int di) { 
    posX = px;
    posY = py;
    direction = di;
  }
  
        /////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: draw three line to form triangle using another method
// 
/////////////////////////////////////////////////////
  void draw() { 
    if (direction == 0) {
      world.robot.headUp();
    }
    else if (direction ==1) {
      world.robot.headRight();
    } 
    else if (direction ==2) {
      world.robot.headDown();
    } 
    else if (direction ==3) {
      world.robot.headLeft();
    }

    stroke(0, 0, 255);
    strokeWeight(4);
    line(headPosX, headPosY, leftPosX, leftPosY);
    line(leftPosX, leftPosY, rightPosX, rightPosY);
    line(rightPosX, rightPosY, headPosX, headPosY);
    strokeWeight(2);
    stroke(0);
  }
  
////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Change value of treeline coordinate
// 
/////////////////////////////////////////////////////
  void headUp() { 
    headPosX = int(width/world.getMaxX()*posX)+width/world.getMaxX()/2;
    headPosY =int(height/world.getMaxY()*posY);
    leftPosX = int(width/world.getMaxX()*posX);
    leftPosY = int(height/world.getMaxY()*(posY+1));
    rightPosX = int(width/world.getMaxX()*(posX+1)); 
    rightPosY = int(height/world.getMaxY()*(posY+1));
  }
  
  /////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Change value of treeline coordinate
// 
/////////////////////////////////////////////////////
  
  void headDown() {
    headPosX = int((width/world.getMaxX()*posX)+width/world.getMaxX()/2);
    headPosY =int(height/world.getMaxY()*(posY+1));
    leftPosX = int(width/world.getMaxX()*posX);
    leftPosY = int(height/world.getMaxY()*posY);
    rightPosX = int(width/world.getMaxX()*(posX+1)); 
    rightPosY = int (height/world.getMaxY()*posY);
  }
  
/////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Change value of treeline coordinate
// 
/////////////////////////////////////////////////////
  void headLeft() {
    headPosX = int(width/world.getMaxX()*(posX+1));
    headPosY =int(height/world.getMaxY()*posY+1);
    leftPosX = int(width/world.getMaxX()*(posX));
    leftPosY = int((height/world.getMaxY()*posY)+width/world.getMaxX()/2);
    rightPosX = int(width/world.getMaxX()*(posX+1)); 
    rightPosY = int (height/world.getMaxY()*(posY+1));
  }
  
/////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Change value of treeline coordinate
// 
/////////////////////////////////////////////////////

  void headRight() {
    headPosX = int(width/world.getMaxX()*posX);
    headPosY =int(height/world.getMaxY()*posY);
    leftPosX = int(width/world.getMaxX()*(posX+1));
    leftPosY = int((height/world.getMaxY()*posY)+height/world.getMaxX()/2);
    rightPosX = int(width/world.getMaxX()*(posX)); 
    rightPosY = int (height/world.getMaxY()*(posY+1));
  }
  
  /////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Change value of direction
// 
/////////////////////////////////////////////////////
  void turnLeft() {
    if (direction == 0) {
      direction = 3;
    } 
    else {
      direction -= 1;
    }
  }
  
  /////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Change value of direction
// 
/////////////////////////////////////////////////////

  void turnRight() {
    if (direction == 3 ) {
      direction = 0;
    } 
    else {
      direction += 1;
    }
  }
  
/////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: CChange value of row or column of robot by 1
// 
/////////////////////////////////////////////////////
  void move() {
    if (direction == 0 && !this.isAtTopEdge() && world.checkIsWhite(posX, posY-1) ) {
      posY -= 1;
    } 
    else if (direction ==1 && !this.isAtRightEdge(world.getMaxX()) && world.checkIsWhite(posX+1, posY) ) {
      posX += 1;
    } 
    else if (direction ==2 && !this.isAtBottomEdge(world.getMaxY()) && world.checkIsWhite(posX, posY+1)) {
      posY += 1;
    } 
    else if (direction ==3 && !this.isAtLeftEdge() && world.checkIsWhite(posX-1, posY) ) {
      posX-= 1;
    }
    
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: for get position x of the robot (row)
  // 
  /////////////////////////////////////////////////////
  int getX() {
    return(posX);
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: for get position y of the robot (column)
  // 
  /////////////////////////////////////////////////////
  int getY() {
    return(posY);
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: check head of robot is at top edge of widget or not?
  // 
  /////////////////////////////////////////////////////
  boolean isAtTopEdge(){
      return posY <= 0;
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: check head of robot is at bottom edge of widget or not?
  // 
  /////////////////////////////////////////////////////
  boolean isAtBottomEdge(int worldMaxY){
      return posY >= worldMaxY-1;
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: check head of robot is at left edge of widget or not?
  // 
  /////////////////////////////////////////////////////
  boolean isAtLeftEdge(){
      return posX <= 0;
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: check head of robot is at right edge of widget or not?
  // 
  /////////////////////////////////////////////////////
  boolean isAtRightEdge(int worldMaxX){
    return posX >= worldMaxX-1;
  }
  
  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: check font of the robot is can walk or not?
  // 
  /////////////////////////////////////////////////////
  boolean isBlocked()
  {
    if(direction == 0 && (posY <= 0 || !world.checkIsWhite(posX, posY-1)))
    {
      return true;
    }
    else if (direction == 1 && (posY >= world.getMaxY()-1 || !world.checkIsWhite(posX+1, posY)))
    {
      return true;
    }
    else if (direction == 2 && (posX <= 0 || !world.checkIsWhite(posX, posY+1)))
    {
      return true;
    }
    else if (direction == 3 && (posX >= world.getMaxX()-1 || !world.checkIsWhite(posX-1, posY)))
    {
      return true;
    }
    else
    {
      return false;
    }
  }
}

class Target {
  int posX, posY;
  
  Target(int x, int y) {
    posX = x;
    posY = y;
  }
  
  /////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: Ccheck the target met the robot or not by using row and column
// 
/////////////////////////////////////////////////////
  
  boolean met(int X, int Y) {  
    
    if (X == posX && Y == posY) {
      // when the robot is on target
      return true;
    } 
    else {
      return false;
    }
  }
  
/////////////////////////////////////////////////////
//
// Programmer: Sikarin
//
// Description: find coordinate and draw polygon 
// 
/////////////////////////////////////////////////////
  void draw() { 
    fill(255, 0, 0);
    float actualPosX = (width/world.getMaxX()*posX)+width/world.getMaxX()/2;
    float actualPosY = (height/world.getMaxY()*posY)+height/world.getMaxY()/2;
    float radius =  width/world.getMaxX()/2;
    int cornerNumber = 8; //octagon 
    polygon(actualPosX, actualPosY, radius, cornerNumber) ;
    fill(0);
  }

  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: for get position x of the target
  // 
  /////////////////////////////////////////////////////
  int getPosX() {
    return posX;
  }

  /////////////////////////////////////////////////////
  //
  // Programmer: Supansa Tantulset
  //
  // Description: for get position y of the target
  // 
  /////////////////////////////////////////////////////
  int getPosY() {
    return posY;
  }
}

class InputProcessor {
  /////////////////////////////////////////////////////
//
// Programmer: Thanakrit-Bank
//
// Description: This method will receive the input from key on the keyboard and then will process the robot move, turnLeft, turnRight method
// and if the key is 's' will save the file in position.txt and if key is 'l' will load the file.
// 
/////////////////////////////////////////////////////
  void control() {
    switch(keyCode) {
      // when pressed arrow button
    
      case UP:
        // when pressed arrow up
        world.robot.move();
        break;
      
      case LEFT:
        // when pressed arrow left
        world.robot.turnLeft();
        break;
      
      case RIGHT:
        // when pressed arrow right
        world.robot.turnRight();
        break;
    }
    if (key == 's') {
      world.saveFile("position.txt");
    }
    if (key == 'l') {  
       world.robot= new Robot(info[1][0],info[1][1],info[3][0]);
       world.target = new Target(info[2][0],info[2][1]);  
    }  
  }
}
