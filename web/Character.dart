import 'dart:html';

class Character{
  static const LEFT = 1;
  static const RIGHT = 2;
  static const UP = 3;
  static const DOWN = 4;
  static const IMAGE_WIDTH = 65;
  
  int posX, posY, width, height, accelX, accelY, speedX, speedY, lastPosX, lastPosY;
  bool grounded;
  String color;
  ImageElement image;
  
  Character(){
    color = "#FF0000";
    posX = 10;
    posY = 200;
    accelX = 0;
    accelY = 0;
    speedX = 0;
    speedY = 0;
    width = 50;
    height = 80;
    grounded = true;
    image = new ImageElement(src: "char.png",width:50,height:50);
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
   // context.fillRect(posX, posY, width, height);
    //context.drawImageScaled(image, posX, posY,height,width);
    Rectangle temp = new Rectangle(posX, posY,width,height);
    Rectangle sourceRect = new Rectangle(0,0,1,1);
    if (grounded)
      sourceRect = new Rectangle(0,0,IMAGE_WIDTH,150);
    else
      sourceRect = new Rectangle(IMAGE_WIDTH,0,IMAGE_WIDTH,150);
    context.drawImageToRect(image, temp, sourceRect:sourceRect);
  }
}