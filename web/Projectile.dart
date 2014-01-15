import 'Sprite.dart';

class Projectile extends Sprite{
  
  Projectile(int x,int y, int speed):super(x,y){
    speedX = speed;
    width=20;
    height=10;
  }
  
  void move(){
    posX+=speedX;
  }
}