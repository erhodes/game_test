import 'dart:html';

class Block{
  bool filled = false;
  String color;
  
  Block(String type){
    switch (type){
      case "0": filled = false;color="#00FFFF";break;
      case "1": filled = true; color = "#00FF00";break;
    }
    
  }
}