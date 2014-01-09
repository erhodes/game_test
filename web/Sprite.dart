import 'dart:html';

class Sprite{
  ImageElement image;
  int posX, posY,speedX,speedY,accelX,accelY,width,height,lastPosX,lastPosY;
  
  Sprite(this.posX, this.posY){
    accelX = 0;
    accelY = 0;
    speedX = 0;
    speedY = 0;
    width = 50;
    height = 80;
  }
  
  void move(){
    lastPosX = posX;
    lastPosY = posY;
    posX+=speedX;
    posY+=speedY;
    //this is where collisions should be checked i suppose
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