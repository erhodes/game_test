import 'Sprite.dart';

class Enemy extends Sprite{
  
  int patrolTimer;
  
  Enemy(int x, int y):super(x,y){
    patrolTimer = 0;
    speedX=1;
  }
  
  void move(){
    patrolTimer++;
    if (patrolTimer > 50){
      speedX =-speedX;
      patrolTimer=0;
    }
    posX+=speedX;
  }
  
}