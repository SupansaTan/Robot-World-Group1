World WD = new World();
String[] Map;

void setup() {
  size(600, 600);
}

void draw() {
WD.getMaxX();
WD.getMaxY();
  WD.draw();
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

  void getMaxX() {
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    maxX = mapread.length;
  }

  void getMaxY() {
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    String[] block = split(mapread[Y], '-');
    maxY = block.length;
  }
  boolean getMap(int X, int Y) {
    Map = loadStrings("Map.txt");
    String[] mapread = split(Map[0], ',');
    String[] block = split(mapread[Y], '-');

    return(boolean(int(block[X])));
  }
}

class Robot {
  float posX, posY, distance;
  int direction;

  Robot() {
  }

  void draw() {
  }

  void move() {
  }
}

class Target {
  float posX, posY;

  Target() {
  }

  void draw() {
  }

  float getPosX() {
    return posX;
  }

  float getPosY() {
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
