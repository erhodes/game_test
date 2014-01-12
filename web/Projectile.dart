import 'Sprite.dart';

class Projectile extends Sprite{
  
  Projectile(int x,int y):super(x,y){
    speedX = 30;
    width=20;
    height=10;
  }
  
  void move(){
    posX+=speedX;
  }
}