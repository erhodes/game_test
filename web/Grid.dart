import 'dart:html';
import 'Block.dart';
import 'dart:core';

class Grid{
  
 // List<List> blocks =[[new Block(), new Block()],
 //                      [new Block(f:true), new Block(f:true)]];
  List<List> blocks;
  num height, width, vertical_blocks, horizontal_blocks;
  num h_ppb, v_ppb;
  
  Grid(num h, num w){
    height = h;
    width = w;
    loadFromString("3,3,0,0,0,0,1,0,1,1,1");
    //vertical_blocks =2;
    //horizontal_blocks = 2;
    h_ppb = width/horizontal_blocks;
    v_ppb= height/vertical_blocks;
  }
  
  void loadFromString(String s){
    blocks = new List<List>();
    List temp = s.split(",");
    vertical_blocks = int.parse(temp[0]);
    horizontal_blocks = int.parse(temp[1]);
    for (int i = 0; i < vertical_blocks; i++){
      List<Block> row = new List<Block>();
      for (int j = 0; j < horizontal_blocks; j++){
        if (temp[2+i*horizontal_blocks + j] == '0')
          row.add(new Block());
        else
          row.add(new Block(f:true));
      }
      blocks.add(row);
    }
  }
  
  bool occupiedPoint(num x, num y){
    //is the selected point inside of a filled block?
    //first, figure out which block is at those coordinates
    num h = (x~/h_ppb);
    num v = (y~/v_ppb);
    //check for screen boundaries
    if ((h >= horizontal_blocks) || (v >= vertical_blocks) ){
      return true;
    }
    else if ((x < 0) || (y < 0)){
      return true;
    }
  //  print("X is $x, Y is $y");
  //  print("H is $h, V is $v");
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