World WD = new World();
Robot RB= new Robot();
Target TG = new Target();
InputProcessor IP = new InputProcessor();
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
  TG.draw(3, 3);
  if (TG.met(RB.getX(), RB.getY()) == true) {
    background(250);
    textSize(60);
    text("You Won", 150, 280);
  }
  else if (i> 0) {
    background(0); 
    WD.draw();

    
    RB.draw();
    TG.draw(3, 3);
  }else {

    background(0);
    WD.draw();
    RB.initialDraw(0, 0);


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
  int headPosX;
  int headPosY;
  int leftPosX;
  int leftPosY;
  int rightPosX;
  int rightPosY;
  Robot() {
  }
  void initialDraw(int posX, int posY) {
    posiX = posX;
    posiY = posY;
    RB.draw();
  }
  void draw() {
    if (direction == 0) {
      RB.headUp();
    } else if (direction ==1) {
      RB.headRight();
    } else if (direction ==2) {
      RB.headDown();
    } else if (direction ==3) {
      RB.headLeft();
    }


    stroke(0, 0, 255);
    strokeWeight(4);
    line(headPosX, headPosY, leftPosX, leftPosY);
    line(leftPosX, leftPosY, rightPosX, rightPosY);
    line(rightPosX, rightPosY, headPosX, headPosY);
    strokeWeight(2);
    stroke(0);
  }

  void headUp() {
    headPosX = int(600/WD.getMaxX()*posiX)+600/WD.getMaxX()/2;
    headPosY =int(600/WD.getMaxY()*posiY);
    leftPosX = int(600/WD.getMaxX()*posiX);
    leftPosY = int(600/WD.getMaxY()*(posiY+1));
    rightPosX = int(600/WD.getMaxX()*(posiX+1)); 
    rightPosY = int (600/WD.getMaxY()*(posiY+1));
  }
  void headDown() {
    headPosX = int((600/WD.getMaxX()*posiX)+600/WD.getMaxX()/2);
    headPosY =int(600/WD.getMaxY()*(posiY+1));
    leftPosX = int(600/WD.getMaxX()*posiX);
    leftPosY = int(600/WD.getMaxY()*posiY);
    rightPosX = int(600/WD.getMaxX()*(posiX+1)); 
    rightPosY = int (600/WD.getMaxY()*posiY);
  }

  void headLeft() {
    headPosX = int(600/WD.getMaxX()*(posiX+1));
    headPosY =int(600/WD.getMaxY()*posiY+1);
    leftPosX = int(600/WD.getMaxX()*(posiX));
    leftPosY = int((600/WD.getMaxY()*posiY)+600/WD.getMaxX()/2);
    rightPosX = int(600/WD.getMaxX()*(posiX+1)); 
    rightPosY = int (600/WD.getMaxY()*(posiY+1));
  }

  void headRight() {
    headPosX = int(600/WD.getMaxX()*posiX);
    headPosY =int(600/WD.getMaxY()*posiY);
    leftPosX = int(600/WD.getMaxX()*(posiX+1));
    leftPosY = int((600/WD.getMaxY()*posiY)+600/WD.getMaxX()/2);
    rightPosX = int(600/WD.getMaxX()*(posiX)); 
    rightPosY = int (600/WD.getMaxY()*(posiY+1));
  }
  void turnLeft() {

    if (direction == 0 ) {
      direction = 3;
    } else {
      direction -= 1;
    }
  }

  void turnRight() {
    if (direction == 3 ) {
      direction = 0;
    } else {
      direction += 1;
    }
  }

  void move() {

    if (direction == 0) {
      if (posiY > 0) {
        if (WD.getMap(posiX, posiY-1) == true) {
          posiY -= 1;
        }
      }
    } else if (direction ==1) {
      if (posiX < WD.getMaxX()-1) {
        if (WD.getMap(posiX+1, posiY) == true) {
          posiX += 1;
        }
      }
    } else if (direction ==2) {
      if (posiX < WD.getMaxY()-1) {
        if (WD.getMap(posiX, posiY+1) == true) {
          posiY += 1;
        }
      }
    } else if (direction ==3) {
      if (posiX > 0) {
        if (WD.getMap(posiX-1, posiY) == true) {
          posiX-= 1;
        }
      }
    }
  }
  int getX() {
    return(posiX);
  }
  int getY() {
    return(posiY);
  }
}
class Target {

  int posX, posY;
  boolean met(int X, int Y) {
    if (X == posX && Y == posY) {
      return true;
      
    } else {
      
      return false;
    }
  }
  void draw(int posiX, int posiY) {
    posX= posiX;
    posY = posiY;
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

class InputProcessor {
  String keyinput;
  void control(String keyinputfx) {
    if (keyinputfx == "w") {
      RB.move();
    } else if (keyinputfx == "d") {
      RB.turnRight();
    } else if (keyinputfx == "a") {
      RB.turnLeft();
    }
  }
}
void keyPressed() {

  if (key == 'w') {
    IP.control("w");
  } else if (key == 'a') {
    IP.control("a");
  } else if (key == 'd') {
    IP.control("d");
  }
}
