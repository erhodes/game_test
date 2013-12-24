import 'dart:html';

class Character{
  static const LEFT = 1;
  static const RIGHT = 2;
  static const UP = 3;
  static const DOWN = 4;
  
  int posX, posY, width, height, accelX, accelY, speed;
  String color;
  Character(){
    color = "#FF0000";
    posX = 10;
    posY = 50;
    accelX = 0;
    accelY = 0;
    speed = 3;
    width = 50;
    height = 50;
  }
  
  void impulse(int dir){
    switch (dir){
      case LEFT: accelX-=speed; break;
      case RIGHT: accelX+=speed;break;
      case UP: accelY-=speed;break;
      case DOWN: accelY +=speed;break;
    }
  }
  
  void move(){
    posX+=accelX;
    posY+=accelY;
    //decel(accelX);
    if (accelX > 0){
      accelX--;
    } else if (accelX < 0){
      accelX++;
    }
    if (accelY > 0){
      accelY--;
    } else if (accelY < 0){
      accelY++;
    }
  }
  
  void render(CanvasRenderingContext2D context){
    context.fillStyle = color;
    context.fillRect(posX, posY, width, height);
  }
}