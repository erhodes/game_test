import 'dart:html';
import 'package:game_loop/game_loop_html.dart';
import 'Character.dart';
import 'Sprite.dart';
import 'Enemy.dart';
import 'Grid.dart';
import 'Physics.dart';
import 'Projectile.dart';

class Game{
  CanvasRenderingContext2D context;
  CanvasElement canvas;
  Keyboard keyboard;
  Mouse mouse;
  Character char;
  List<Sprite> enemies;
  List<Projectile> projectiles;
  Grid grid;
  
  Game(this.canvas, this.keyboard, this.mouse){
    context = canvas.getContext("2d");
    char = new Character(10,200);
    grid = new Grid(canvas.height, canvas.width);
    projectiles = new List<Projectile>();
    enemies = new List<Sprite>();
    enemies.add(new Sprite(430,200));
    enemies.add(new Enemy(200,300));
  }
  
  void update(){
// Update game logic here.
    //is the character currently on the ground?
    if (grid.occupiedPoint(char.posX, char.posY+char.height+1) || grid.occupiedPoint(char.posX+char.width, char.posY+char.height+1)){
      char.grounded = true;
    } else{
      char.grounded = false;
    }
    //user input stuff
    if (keyboard.isDown(Keyboard.A)){
      char.impulse(Character.LEFT);
    }if (keyboard.isDown(Keyboard.W)){
      char.impulse(Character.UP);
    }if (keyboard.isDown(Keyboard.S)){
      char.impulse(Character.DOWN);
    }if (keyboard.isDown(Keyboard.D)){
      char.impulse(Character.RIGHT);
    } if (keyboard.isDown(Keyboard.SPACE) && char.grounded){
      char.impulse(Character.UP);
    }
    if (keyboard.pressed(Keyboard.F)){
      projectiles.add(new Projectile(char.posX+char.width,char.posY+10));
    }
    
    if (!char.grounded){
      char.fall();
    }
    char.move();
    enemies.forEach( (s) => s.move());
    projectiles.forEach( (s) => s.move());
    //collision with the background logic
    if (collision(grid,char.posX,char.posY,char.width,char.height) ) {
      //this is a collision between the player and impassible terrain. attempt to fix it by reverting to a good location
      //test if we can revert only on the X axis
      if (!collision(grid,char.lastPosX,char.posY,char.width,char.height)){
        char.posX=char.lastPosX;
      }
      //test if we can revert only on the Y axis
      else if (collision(grid,char.posX,char.lastPosY,char.width,char.height)){
        char.posY=char.lastPosY;
      }
      else{
        char.revertToLastPosition();
      }
    }
    //is the player colliding with any other sprites?
    for (int i = 0; i < enemies.length;i++){
      if (collidingSprites(char,enemies[i])){
        enemies[i].posX+=50;
      }
    }
    //are projectiles colliding with any enemies?
    for (int i =0; i < projectiles.length;i++){
      //actual collision stuff
      for (int j = 0; j < enemies.length;j++){
        if (collidingSprites(projectiles[i],enemies[j])){
          enemies.removeAt(j);
          j--;
        }
      }
      //is the projectile out of bounds?
      if ((projectiles[i].posX > canvas.width) || (projectiles[i].posX < 0)){
        projectiles.removeAt(i);
        i--;
      }
    }
  }
  
  void render(){
    //draw the background
    grid.render(context);
    //draw the character
    char.render(context);
    enemies.forEach( (s) => s.render(context));
    projectiles.forEach( (s) => s.render(context));
  }
  
}

bool collision(Grid grid, int posX, int posY, int width, int height){
  if (grid.occupiedPoint(posX+width, posY+height) || //bottom right corner
      grid.occupiedPoint(posX, posY)  ||//top left corner
      grid.occupiedPoint(posX, posY+height) || //bottom left corner
      grid.occupiedPoint(posX+width, posY) //top right corner
  )
  {
    return true;
  }else{
    return false;
  }
}