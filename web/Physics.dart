import "dart:math";
import "Sprite.dart";

bool pointInRect(Point p, int x, int y, int width, int height){
  if ((p.x < x) || (p.y < y) || (p.x> (x+width)) || (p.y > (y+height))) {
    return false;
  }else{
    return true;
  }
}

bool collidingSprites(Sprite s1, Sprite s2){
  num x1 = s1.posX;
  num y1 = s1.posY;
  num h1 = s1.height;
  num w1 = s1.width;
  num x2 = s2.posX;
  num y2 = s2.posY;
  num h2 = s2.height;
  num w2 = s2.width;
  Point r1 = new Point(x1,y1);
  Point closestToR1 = closestPointToRect(new Point(x2,y2),
      new Point(x2+w2,y2),
      new Point(x2,y2+h2),
      new Point(x2+w2,y2+h2),r1);
  if (pointInRect(closestToR1,x1,y1,w1,h1)){
    return true;
  }else{
    return false;
  }
}

bool collidingRectangles(num x1, num y1, int w1, int h1, num x2, num y2, int w2, int h2){
  Point r1 = new Point(x1,y1);
  Point closestToR1 = closestPointToRect(new Point(x2,y2),
      new Point(x2+w2,y2),
      new Point(x2,y2+h2),
      new Point(x2+w2,y2+h2),r1);
  if (pointInRect(closestToR1,x1,y1,w1,h1)){
    return true;
  }else{
    return false;
  }
}

Point closestPointToRect(Point a, Point b, Point c, Point d, Point p){
  Point result;
  num distance;
  Point ab = closestPointOnLine(a,b,p);
  result = ab;
  distance = p.distanceTo(ab);
  
  Point ac = closestPointOnLine(a,c,p);
  if (p.distanceTo(ac) < distance){
    distance = p.distanceTo(ac);
    result = ac;
  }
  Point bd = closestPointOnLine(b,d,p);
  if (p.distanceTo(bd) < distance){
    distance = p.distanceTo(bd);
    result = bd;
  }
  Point cd = closestPointOnLine(c,d,p);
  if (p.distanceTo(cd) < distance){
    distance = p.distanceTo(cd);
    result = cd;
  }
  return result;
}

Point closestPointOnLine(Point a, Point b, Point p){
  Vector c = new Vector (p.x-a.x,p.y-a.y);
  Vector V = (new Vector (b.x-a.x,b.y-a.y)).normalized();
  double d = a.distanceTo(b);
  double t = V.dotProduct(c);
  
  if (t < 0) return a;
  if (t > d) return b;
  
  V.x = V.x*t;
  V.y = V.y*t;
  return new Point (a.x+V.x,a.y+V.y);
}

class Vector{
  num x, y,magnitude;
  Vector(this.x,this.y){
    magnitude = sqrt (x*x+y*y);
  }
  Vector operator +(Vector v){
    return new Vector (x+v.x,y+v.y);
  }
  Vector operator -(Vector v){
    return new Vector (x+v.x,y+v.y);
  }
  num dotProduct(Vector v){
    return x*v.x + y*v.y;
  }
  Vector normalized(){
    return new Vector (x/magnitude,y/magnitude);
  }
}