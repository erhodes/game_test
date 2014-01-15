import 'dart:html';

class Sprite{
  ImageElement image;
  int posX, posY,speedX,speedY,accelX,accelY,width,height,lastPosX,lastPosY;
  Point pos;
  bool facingRight;
  
  Sprite(this.posX, this.posY){
    accelX = 0;
    accelY = 0;
    speedX = 0;
    speedY = 0;
    width = 50;
    height = 80;
    facingRight = true;
  }
  
  void move(){
    lastPosX = posX;
    lastPosY = posY;
    posX+=speedX;
    posY+=speedY;
    if (speedX < 0){
      facingRight = false;
    }
    else if (speedX > 0) {
      facingRight = true;
    }
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
  
  void render(CanvasRenderingContext2D context){
    context.fillStyle = "#000000";
    context.fillRect(posX, posY, width, height);
  }
  
  
  
}