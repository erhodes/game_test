import 'dart:html';
import 'package:game_loop/game_loop_html.dart';
import 'Character.dart';
import 'Block.dart';
import 'Grid.dart';

void main() {
  CanvasElement canvasElement = querySelector("#myCanvas");
  CanvasRenderingContext2D ctx = canvasElement.getContext("2d");
  Character char = new Character();
  ctx.fillStyle="#FF0000";
  GameLoopHtml gameLoop = new GameLoopHtml(canvasElement);
  Grid grid = new Grid(canvasElement.height, canvasElement.width);
  
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
    
    

    char.move();
    if (grid.occupiedPoint(char.posX+char.width, char.posY+char.height) || //bottom right corner
        grid.occupiedPoint(char.posX, char.posY)  ||//top left corner
        grid.occupiedPoint(char.posX, char.posY+char.height) || //bottom left corner
        grid.occupiedPoint(char.posX+char.width, char.posY) //top right corner
        ) {
      char.revertToLastPosition();
    }
  });
  gameLoop.onRender = ((gameLoop){
    //draw the game into canvasElement
    //clear the screen
    ctx.clearRect(0, 0, canvasElement.width, canvasElement.height);
    //draw the background
    grid.render(ctx);
    //draw the character
    char.render(ctx);
  });
  gameLoop.start();
  var timer = gameLoop.addTimer((timer) => print('timer fired.'), 0.5);
}