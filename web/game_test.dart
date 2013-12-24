import 'dart:html';
import 'package:game_loop/game_loop_html.dart';
import 'Character.dart';

void main() {
  CanvasElement canvasElement = querySelector("#myCanvas");
  CanvasRenderingContext2D ctx = canvasElement.getContext("2d");
  Character char = new Character();
  ctx.fillStyle="#FF0000";
  GameLoopHtml gameLoop = new GameLoopHtml(canvasElement);
  
  int x = 0;
  int y = 0;
  
  gameLoop.onUpdate = ((gameLoop) {
    // Update game logic here.
    //print('${gameLoop.frame}: ${gameLoop.gameTime} [dt = ${gameLoop.dt}].');
    if (gameLoop.keyboard.isDown(Keyboard.A)){
      char.impulse(Character.LEFT);
    }if (gameLoop.keyboard.isDown(Keyboard.W)){
      char.impulse(Character.UP);
    }if (gameLoop.keyboard.isDown(Keyboard.S)){
      char.impulse(Character.DOWN);
    }if (gameLoop.keyboard.isDown(Keyboard.D)){
      char.impulse(Character.RIGHT);
    }
    char.move();
  });
  gameLoop.onRender = ((gameLoop){
    //draw the game into canvasElement
    //clear the screen
    ctx.clearRect(0, 0, canvasElement.width, canvasElement.height);
    //draw the character
    char.render(ctx);
  });
  gameLoop.start();
  var timer = gameLoop.addTimer((timer) => print('timer fired.'), 0.5);
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
