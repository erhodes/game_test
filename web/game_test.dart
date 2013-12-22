import 'dart:html';
import 'package:game_loop/game_loop_common.dart';
import 'package:game_loop/game_loop_html.dart';

void main() {
  CanvasElement canvasElement = querySelector("#myCanvas");
  CanvasRenderingContext2D ctx = canvasElement.getContext("2d");
  ctx.fillStyle="#FF0000";
  ctx.fillRect(0,0,150,150);
  GameLoopHtml gameLoop = new GameLoopHtml(canvasElement);
  
}

void reverseText(MouseEvent event) {
  var text = querySelector("#sample_text_id").text;
  var buffer = new StringBuffer();
  for (int i = text.length - 1; i >= 0; i--) {
    buffer.write(text[i]);
  }
  querySelector("#sample_text_id").text = buffer.toString();
}
