import 'dart:html';

class Block{
  bool filled = false;
  String color;
  
  Block({bool f: false}){
    filled = f;
    if (filled){
      color = "#00FF00";
    }
    else{
      color = "#FFFFFF";
    }
  }
}