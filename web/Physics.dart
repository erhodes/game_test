import "dart:math";

bool pointInRect(Point p, int x, int y, int width, int height){
  if ((p.x < x) || (p.y < y) || (p.x> (x+width)) || (p.y > (y+height))) {
    return false;
  }else{
    return true;
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