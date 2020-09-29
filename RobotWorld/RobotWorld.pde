void setup(){
  size(600,600);
}

void draw(){
}

class World{
  int worldWidth, worldHeight;
  //int[][] block;
  
  World(){
  }
  
  void draw(){
  }
  
  boolean canWalk(){
    return true;
  }
}

class Robot{
  float posX, posY, distance;
  int direction;
  
  Robot(){
  }
  
  void draw(){
  }
  
  void move(){
  }
  
  boolean calDirection(){
    return true;
  }
  
  boolean calDistance(){
    return true;
  }
}

class Target{
  float posX, posY;
  
  Target(){
  }
  
  void draw(){
  }
  
  float getPosX(){
    return posX;
  }
  
  float getPosY(){
    return posY;
  }
}

class Obstruction{
  int size;
  float posX, posY;
  //int[][] walls;
  
  void draw(){
  }
  
  boolean block(){
    return true;
  } 
}
