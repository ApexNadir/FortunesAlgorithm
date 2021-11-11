

class Point{
  float x,y;
  Point(){
    x=y=0;
  }
  Point(float x1,float y1){
    x=x1;
    y=y1;
  }
  Point(JSONObject j){
    if(!j.isNull("x")&&!j.isNull("y")){
      x=j.getFloat("x");
      y=j.getFloat("y");
    }else{
      x=y=0;
    }
  }
  JSONObject toJSON(){
    JSONObject pJSON = new JSONObject();
    pJSON.setFloat("x",x);
    pJSON.setFloat("y",y);
    return pJSON;
  }
  Point copyP(){
    return new Point(x,y);
  }
  boolean equals(Point p2){
    return x==p2.x&&y==p2.y;
  }
  Point addP(Point p2){
    return new Point(x+p2.x,y+p2.y);
  }
  Point subP(Point p2){
    return new Point(x-p2.x,y-p2.y);
  }
  void addToThis(Point p2){
    x+=p2.x;
    y+=p2.y;
  }
  void subFromThis(Point p2){
    x=x-p2.x;
    y=y-p2.y;
  }
  float distP(){
    return dist(0,0,x,y);
  }
  float distP(Point p2){
    return dist(p2.x,p2.y,x,y);
  }
  Point rotateP(float ang){
    return new Point(x*cos(ang)-y*sin(ang),x*sin(ang)+y*cos(ang));
  }
  float ang(){
    return atan2(y,x);
  }
  Point normalised(){
    float d=distP();
    return new Point(x/d,y/d);
  }
  Point multP(float m){
    return new Point(x*m,y*m);
  }
  void multThis(float m){
    x*=m;
    y*=m;
  }
  void drag(float dMod){
    float v = distP();
    float drag = dMod*sq(v);
    if(drag>=v){
      x=y=0;
    }else{
      float ratio = 1-drag/v;
      multThis(ratio);
    }
  }
  void threshold(float minD){
    float d = distP();
    if(d<minD){
      x=y=0;
    }
  }
  Point[] split2Components(Point direction){
    float dirAng = direction.ang();
    return split2Components(dirAng);
  }
  Point[] split2Components(float dir){
    Point[] components = new Point[2];
    Point aligned = rotateP(-dir);
    components[0]=new Point(aligned.x,0).rotateP(dir);
    components[1]=new Point(0,aligned.y).rotateP(dir);
    return components;
  }
  String toString(){
    return "(" + x + ", " +y + ")";
  }
  
}

class Line{
  float m,c;
  boolean isVert=false;
  boolean isPoint=false;
  float isPointx,isPointy;
  Line(){
    m=0;
    c=0;
  }
  Line(float nm,float nc){
    m=nm;
    c=nc;
  }
  Line(Point p1,Point p2){
    genLine(p1,p2);
  }
  Line(Point p1, float ang){
    Point p2 = p1.addP(new Point(cos(ang),sin(ang)));
    if(p1.x-p2.x==0){
      isVert=true;
      c=p1.x;
    }
    m=(p1.y-p2.y)/(p1.x-p2.x);
    c=p1.y-m*p1.x;
  }
  private void genLine(Point p1,Point p2){
    isPoint=false;
    isVert=false;
    if(p1.x==p2.x && p1.y == p2.y){
      isPoint = true;
      isPointx=p1.x;
      isPointy=p1.y;
      return;
    }
    float dy,dx;
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
  Point intersect(Line l2){
    if(isPoint||l2.isPoint){
      if(isPoint&&l2.isPoint){
        //println("WEIRD1");
        return null;
      }
      Line p, l;
      if(isPoint){
        p=this;
        l=l2;
      }else{
        p=l2;
        l=this;
      }
      if(p.isPointy==l.m*p.isPointx+l.c){
        return new Point(p.isPointx,p.isPointy);
      }else{
        //println("WEIRD2");
        return null;
      }
    }
    if(m==l2.m){
        //println("WEIRD3");
      return null;
    }
    if(isVert||l2.isVert){
      Line v,l;
      if(isVert){
        v=this;
        l=l2;
      }else{
        v=l2;
        l=this;
      }
      Point out = new Point();
      out.x=v.c; 
      out.y=l.m*out.x+l.c;
       // println("WEIRD4");
      return out;
    }
    //println("here");
    Point out = new Point();
    //println(m + "x + " + c + " = " + l2.m + "x + " + l2.c);
    out.x=(c-l2.c)/(l2.m-m);
    out.y=m*out.x+c;
    return out;
  }
  
  float yVal(float x){
    if(isVert){return 0;}
    return m*x+c;
  }
  void drawLine(){
    if(isVert){
      line(c,0,c,height);
      return;
    }
    line(0,c,width,m*width+c);
  }
}

class PointSet{
  ArrayList<Point> points;
  
  PointSet(){
    points = new ArrayList<Point>();
  }
  
  void addPoint(Point p){
    points.add(p);
  }
  
  
  void translatePoints(float x, float y){
    translatePoints(new Point(x,y));
  }
  
  void translatePoints(Point translation){
    for(Point p: points){
      p.addToThis(translation);
    }
  }
  
  void rotatePoints(float ang){
    
  }
  
}