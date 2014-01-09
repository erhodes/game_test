import 'dart:html';
import 'Sprite.dart';

class Character extends Sprite{
  static const LEFT = 1;
  static const RIGHT = 2;
  static const UP = 3;
  static const DOWN = 4;
  static const IMAGE_WIDTH = 65;
  
  bool grounded;
  String color;
  ImageElement image;
  
  Character(int x, int y):super(x,y){
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