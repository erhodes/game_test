import 'dart:html';
import 'package:game_loop/game_loop_html.dart';
import 'Game.dart';

void main() {
  CanvasElement canvasElement = querySelector("#myCanvas");
  GameLoopHtml gameLoop = new GameLoopHtml(canvasElement);
  Game game = new Game(canvasElement, gameLoop.keyboard,gameLoop.mouse);
  //GAME LOGIC LOOP
  gameLoop.onUpdate = ((gameLoop) {
    game.update();
  });
  //RENDER LOOP
  gameLoop.onRender = ((gameLoop){
    //draw the game into canvasElement
    game.render();
    
  });
  gameLoop.start();
  //var timer = gameLoop.addTimer((timer) => print('timer fired.'), 0.5);
}