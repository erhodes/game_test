import 'dart:html';

class Character{
  static const LEFT = 1;
  static const RIGHT = 2;
  static const UP = 3;
  static const DOWN = 4;
  
  int posX, posY, width, height, accelX, accelY, speedX, speedY, lastPosX, lastPosY;
  bool grounded;
  String color;
  Character(){
    color = "#FF0000";
    posX = 10;
    posY = 200;
    accelX = 0;
    accelY = 0;
    speedX = 0;
    speedY = 0;
    width = 50;
    height = 50;
  }
  
  void impulse(int dir){
    switch (dir){
      case LEFT: speedX=-2; break;
      case RIGHT: speedX=2;break;
      case UP: speedY=-8;break;
      case DOWN: speedY =2;break;
    }
  }
  
  void fall(){
    if (speedY < 8){
      speedY++;
    }
  }
  
  void move(){
    lastPosX = posX;
    lastPosY = posY;
    posX+=speedX;
    posY+=speedY;
    //decel(accelX);
    if (speedX > 0){
      speedX--;
    } else if (speedX < 0){
      speedX++;
    }
    if (speedY > 0){
      speedY--;
    } else if (speedY < 0){
      speedY++;
    }
  }
  
  void stop(){
    speedX = 0;
    speedY = 0;
  }
  
  void revertToLastPosition(){
    posX = lastPosX;
    posY = lastPosY;
  }
  
  void render(CanvasRenderingContext2D context){
    context.fillStyle = color;
    context.fillRect(posX, posY, width, height);
   
  }
}