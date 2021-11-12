double areaOfCircle(double radius){
  return PI*Math.pow(radius,2);
}

double sphereVolume(double radius){
  return (4*PI/3)*Math.pow(radius,3);
}

double sphereRadiusFromVolume(double volume){
  return Math.cbrt(volume/(4*PI/3));
}

double distD(double x1, double y1, double x2, double y2){
  return Math.sqrt(Math.pow(x2-x1,2) + Math.pow(y2-y1, 2));
}

class PointD{
  double x,y;
  PointD(){
    x=y=0;
  }
  PointD(double ang){
    PointD vector = (new PointD(1,0)).rotateP(ang);
    x = vector.x;
    y = vector.y;
  }
  PointD(double x1,double y1){
    x=x1;
    y=y1;
  }
  PointD(JSONObject j){
    if(!j.isNull("x")&&!j.isNull("y")){
      x=j.getDouble("x");
      y=j.getFloat("y");
    }else{
      x=y=0;
    }
  }
  JSONObject toJSON(){
    JSONObject pJSON = new JSONObject();
    pJSON.setDouble("x",x);
    pJSON.setDouble("y",y);
    return pJSON;
  }
  PointD copyP(){
    return new PointD(x,y);
  }
  boolean equals(PointD p2){
    return x==p2.x&&y==p2.y;
  }
  PointD addP(PointD p2){
    return new PointD(x+p2.x,y+p2.y);
  }
  PointD subP(PointD p2){
    return new PointD(x-p2.x,y-p2.y);
  }
  void addToThis(PointD p2){
    x+=p2.x;
    y+=p2.y;
  }
  void subFromThis(PointD p2){
    x=x-p2.x;
    y=y-p2.y;
  }
  double distP(){
    return distD(0,0,x,y);
  }
  double distP(PointD p2){
    return distD(p2.x,p2.y,x,y);
  }
  PointD rotateP(double ang){
    return new PointD(x*Math.cos(ang)-y*Math.sin(ang),x*Math.sin(ang)+y*Math.cos(ang));
  }
  double ang(){
    return Math.atan2(y,x);
  }
  PointD normalised(){
    double d=distP();
    return new PointD(x/d,y/d);
  }
  PointD multP(double m){
    return new PointD(x*m,y*m);
  }
  PointD multThis(double m){
    x*=m;
    y*=m;
    return this;
  }
  void drag(double dMod){
    double v = distP();
    double drag = dMod*Math.pow(v,2);
    if(drag>=v){
      x=y=0;
    }else{
      double ratio = 1-drag/v;
      multThis(ratio);
    }
  }
  void threshold(double minD){
    double d = distP();
    if(d<minD){
      x=y=0;
    }
  }
  PointD[] split2Components(PointD direction){
    double dirAng = direction.ang();
    return split2Components(dirAng);
  }
  PointD[] split2Components(double dir){
    PointD[] components = new PointD[2];
    PointD aligned = rotateP(-dir);
    components[0]=new PointD(aligned.x,0).rotateP(dir);
    components[1]=new PointD(0,aligned.y).rotateP(dir);
    return components;
  }
  String toString(){
    return "(" + x + ", " +y + ")";
  }
  
  Point asFloat(){
    return new Point((float)x, (float)y);
  }
  
}

LineD lineDFromGradient(PointD p, double gradient){
  LineD newLine = new LineD();
  newLine.m = gradient;
  newLine.c = p.y-p.x*gradient;
  return newLine;
}

class LineD{
  double m,c;
  boolean isVert=false;
  boolean isPoint=false;
  double isPointx,isPointy;
  LineD(){
    m=0;
    c=0;
  }
  LineD(double nm,double nc){
    m=nm;
    c=nc;
  }
  LineD(PointD p1,PointD p2){
    genLine(p1,p2);
  }
  
  LineD(PointD p1, double ang){
    PointD p2 = p1.addP(new PointD(Math.cos(ang),Math.sin(ang)));
    if(p1.x-p2.x==0){
      isVert=true;
      c=p1.x;
    }
    m=(p1.y-p2.y)/(p1.x-p2.x);
    c=p1.y-m*p1.x;
  }
  
  private void genLine(PointD p1,PointD p2){
    isPoint=false;
    isVert=false;
    if(p1.x==p2.x && p1.y == p2.y){
      isPoint = true;
      isPointx=p1.x;
      isPointy=p1.y;
      return;
    }
    double dy,dx;
    dy=(p2.y-p1.y);
    dx=(p2.x-p1.x);
    if(dx==0){
      isVert=true;
      c=p1.x;
      return;
    }
    m=dy/dx;
    c=p1.y-p1.x*m;
  }
  PointD intersect(LineD l2){
    if(isPoint||l2.isPoint){
      if(isPoint&&l2.isPoint){
        //println("WEIRD1");
        return null;
      }
      LineD p, l;
      if(isPoint){
        p=this;
        l=l2;
      }else{
        p=l2;
        l=this;
      }
      if(p.isPointy==l.m*p.isPointx+l.c){
        return new PointD(p.isPointx,p.isPointy);
      }else{
        //println("WEIRD2");
        return null;
      }
    }
    if(isVert||l2.isVert){
      LineD v,l;
      if(isVert){
        v=this;
        l=l2;
      }else{
        v=l2;
        l=this;
      }
      PointD out = new PointD();
      out.x=v.c; 
      out.y=l.m*out.x+l.c;
       // println("WEIRD4");
      return out;
    }
    if(m==l2.m){
        //println("WEIRD3");
      return null;
    }
    //println("here");
    PointD out = new PointD();
    //println(m + "x + " + c + " = " + l2.m + "x + " + l2.c);
    out.x=(c-l2.c)/(l2.m-m);
    out.y=m*out.x+c;
    return out;
  }
  
  double yVal(double x){
    if(isVert){return 0;}
    return m*x+c;
  }
  void drawLine(){
    if(isVert){
      line((float)c,0,(float)c,height);
      return;
    }
    line(0,(float)c,width,(float)(m*width+c));
  }
  
  double getAng(){
    if(isVert){return 0;}
    return Math.atan(m);
  }
  
  
  LineD normalAt(double x){
    PointD p = new PointD(x, yVal(x));
    PointD p2 = p.addP(new PointD(1, -1/m));
    return new LineD(p,p2);
  }
  
}

class DirectionalLineD{
  PointD origin;
  LineD line;
  double direction;
  
  DirectionalLineD(PointD p1, PointD p2){
    origin = p1.copyP();
    line = new LineD(p1, p2);
    direction = p2.subP(p1).ang();
  }
  
  DirectionalLineD(PointD p1, double direction_){
    origin = p1.copyP();
    direction = direction_;
    PointD p2 = p1.addP(new PointD(direction));
    line = new LineD(p1, p2);
  }
  
  DirectionalLineD(PointD p1, double direction_, boolean debug){
    origin = p1.copyP();
    direction = direction_;
    PointD p2 = p1.addP(new PointD(direction));
    println("p1: " + p1 + "  , p2: " + p2);
    line = new LineD(p1, p2);
  }
  
  void render(){
    PointD p2 = new PointD(direction);
    p2.multThis(width*height).addToThis(origin);
    line((float)origin.x, (float)origin.y, (float)p2.x, (float)p2.y);
  }
  
  PointD intersect(DirectionalLineD line2){
    PointD intersect = line.intersect(line2.line);
    if(intersect!=null){
      double directionOffset = Math.abs(getDirectionOffset(intersect));
      if(directionOffset<0.01){
        double line2DirectionOffset = Math.abs(line2.getDirectionOffset(intersect));
        if(line2DirectionOffset<0.01){
          return intersect;
        }
      }
    }
    return null;
  }
  
  PointD debugIntersect(DirectionalLineD line2){
    PointD intersect = line.intersect(line2.line);
    println("DEBUG RAY: line intersect: " + intersect);
    if(intersect!=null){
      println("DEBUG RAY: NOT NULL LINE CHECK PASSED");
      double directionOffset = Math.abs(getDirectionOffset(intersect));
      
      println("DEBUG RAY: DIRECTION OFFSET LINE 1: " + directionOffset);
      if(directionOffset<0.01){
      println("DEBUG RAY: DIRECTION OFFSET LINE 1 PASSED");
        double line2DirectionOffset = Math.abs(line2.getDirectionOffset(intersect));
      println("DEBUG RAY: DIRECTION OFFSET LINE 2: " + line2DirectionOffset);
        if(line2DirectionOffset<0.01){
      println("DEBUG RAY: DIRECTION OFFSET LINE 2 PASSED");
          return intersect;
        }
      }
    }
    return null;
  }
  
  double getDirectionOffset(PointD point){
    return getSmallestAngBetween(point.subP(origin).ang(), direction);
  }
  
}

class PointSetD{
  ArrayList<PointD> points;
  
  PointSetD(){
    points = new ArrayList<PointD>();
  }
  
  void addPoint(PointD p){
    points.add(p);
  }
  
  
  void translatePoints(float x, float y){
    translatePoints(new PointD(x,y));
  }
  
  void translatePoints(PointD translation){
    for(PointD p: points){
      p.addToThis(translation);
    }
  }
  
  void rotatePoints(float ang){
    
  }
  
}


class CircleD{
  PointD center;
  double radius;
  
  
  CircleD(PointD p1, PointD p2, PointD p3){
    LineD l1 = new LineD(p1, p2);
    //stroke(255,0,0);
    //l1.drawLine();
    LineD bisector = l1.normalAt((p1.x+p2.x)/2);
    //bisector.drawLine();
    
    
    //stroke(0,0,255);
    LineD l2 = new LineD(p1, p3);
    //l2.drawLine();
    LineD bisector2 = l2.normalAt((p1.x+p3.x)/2);
    //bisector2.drawLine();
    
    center = bisector.intersect(bisector2);
    radius = center.distP(p1);
    
  }
  
  
  void render(){
    Point fCenter = center.asFloat();
    float fDiameter = (float)radius*2;
    ellipse(fCenter.x, fCenter.y, fDiameter, fDiameter);
  }
}