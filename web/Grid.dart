import 'dart:html';
import 'Block.dart';

class Grid{
  
  List<List> blocks =[[new Block(), new Block()],
                       [new Block(f:true), new Block(f:true)]];
  num height, width, vertical_blocks, horizontal_blocks;
  num h_ppb, v_ppb;
  
  Grid(num h, num w){
    height = h;
    width = w;
    vertical_blocks =2;
    horizontal_blocks = 2;
    h_ppb = width/horizontal_blocks;
    v_ppb= height/vertical_blocks;
  }
  
  bool occupiedPoint(num x, num y){
    //is the selected point inside of a filled block?
    //first, figure out which block is at those coordinates
    num h = (x~/h_ppb);
    num v = (y~/v_ppb);
    if ((h >= horizontal_blocks) || (v >= vertical_blocks) ){
      return true;
    }
    //print("X is $x, Y is $y");
    //print("H is $h, V is $v");
    bool test = blocks[v][h].filled;
    return test;
        
  }
  
  void render(CanvasRenderingContext2D context){
    for (int i = 0; i < vertical_blocks; i++){
      for (int j = 0; j < horizontal_blocks; j++){
        context.fillStyle=blocks[i][j].color;
        context.fillRect(j*h_ppb, i*v_ppb, h_ppb, v_ppb);
      }
    }
  }
}