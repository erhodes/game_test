import 'dart:html';
import 'package:game_loop/game_loop_html.dart';
import 'Character.dart';
import 'Block.dart';
import 'Grid.dart';
import 'Sprite.dart';
import 'Enemy.dart';
import 'Physics.dart';

void main() {
  CanvasElement canvasElement = querySelector("#myCanvas");
  CanvasRenderingContext2D ctx = canvasElement.getContext("2d");
  List<Sprite> sprites = new List<Sprite>();
  Character char = new Character(10,200);
  sprites.add(char);
  sprites.add(new Sprite(430,200));
  sprites.add(new Enemy(200,300));
  GameLoopHtml gameLoop = new GameLoopHtml(canvasElement);
  Grid grid = new Grid(canvasElement.height, canvasElement.width);
  //GAME LOGIC LOOP
  gameLoop.onUpdate = ((gameLoop) {
    // Update game logic here.
    //is the character currently on the ground?
    if (grid.occupiedPoint(char.posX, char.posY+char.height+1) || grid.occupiedPoint(char.posX+char.width, char.posY+char.height+1)){
      char.grounded = true;
    } else{
      char.grounded = false;
    }
    //user input stuff
    if (gameLoop.keyboard.isDown(Keyboard.A)){
      char.impulse(Character.LEFT);
    }if (gameLoop.keyboard.isDown(Keyboard.W)){
      char.impulse(Character.UP);
    }if (gameLoop.keyboard.isDown(Keyboard.S)){
      char.impulse(Character.DOWN);
    }if (gameLoop.keyboard.isDown(Keyboard.D)){
      char.impulse(Character.RIGHT);
    } if (gameLoop.keyboard.isDown(Keyboard.SPACE) && char.grounded){
      char.impulse(Character.UP);
    }
    
    if (!char.grounded){
      char.fall();
    }
    sprites.forEach( (s) => s.move());
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
    //collision with other sprites logic
    //this only works if the character is sprite 0, btw
    Point pos = new Point(char.posX,char.posY);
    for (int i = 1; i < sprites.length;i++){
      Point closest = closestPointToRect(new Point(sprites[i].posX,sprites[i].posY),
      new Point(sprites[i].posX+sprites[i].width,sprites[i].posY),
      new Point(sprites[i].posX,sprites[i].posY+sprites[i].height),
      new Point(sprites[i].posX+sprites[i].width,sprites[i].posY+sprites[i].height), pos);
      //is the closest point actually inside the player?
      if (pointInRect(closest,pos.x,pos.y,char.width,char.height)){
        sprites[i].posX+=50;
      }
    }
    
  });
  //RENDER LOOP
  gameLoop.onRender = ((gameLoop){
    //draw the game into canvasElement
    //clear the screen
    ctx.clearRect(0, 0, canvasElement.width, canvasElement.height);
    //draw the background
    grid.render(ctx);
    //draw the character
    sprites.forEach( (s) => s.render(ctx));
  });
  gameLoop.start();
  var timer = gameLoop.addTimer((timer) => print('timer fired.'), 0.5);
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