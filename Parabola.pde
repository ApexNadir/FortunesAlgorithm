class ParabolaD{
  double h, k;
  double a;
  
  ParabolaD(PointD focus, double directixY){
    //println(focus.y + ", " + directixY);
    a = 1d/(2*(focus.y-directixY));
    k = (focus.y + directixY)/2;
    h = focus.x;
    //println("a: " + a);
    //println("k: " + k);
    //println("h: " + h);
  }
  
  
  /*
  ParabolaD(PointD focus, PointD vertex){
    
    
  }
  */
  
  double function(double x){
    return (a*Math.pow(x-h,2))+k;
    // y     = a(x-h)^2 +k
    // dy/dx = 
  }
  
  double gradient(double x){
    return 2*a*(x-h);
  }
  
  
  PointD[] intersect(LineD line){
    if(line.isVert){
      return new PointD[]{new PointD(line.c, function(line.c))};
    }
    
    double q_a, q_b, q_c;
    
    q_a = a;
    
    q_b = -2*a*h+line.m;
    
    q_c = a*Math.pow(h,2) + k - line.c;
    
    double q_sqrt, q_2a;
    
    q_sqrt = Math.sqrt(Math.pow(q_b,2) - 4*q_a*q_c);
    
    q_2a = 2*q_a;
    
    double root1x, root2x;
    
    root1x = (-q_b+q_sqrt)/q_2a;
    root2x = (-q_b-q_sqrt)/q_2a;
    
    PointD p1 = new PointD(root1x, function(root1x));
    PointD p2 = new PointD(root2x, function(root2x));
    return new PointD[]{p1, p2};
  }
  
  PointD[] intersect(ParabolaD parabola2){
    double q_a, q_b, q_c;
    
    q_a = a - parabola2.a;
    
    q_b = 2 * parabola2.h * parabola2.a - 2*h*a;
    
    q_c = a * Math.pow(h,2) + k - parabola2.a * Math.pow(parabola2.h,2) - parabola2.k;
    
    
    double q_sqrt, q_2a;
    
    q_sqrt = Math.sqrt(Math.pow(q_b,2) - 4*q_a*q_c);
    
    q_2a = 2*q_a;
    
    if(q_2a==0){
      //a==0, meaning its not quadratic anymore
      double x = -q_c/q_b;
      PointD p1 = new PointD(x, function(x));
      return new PointD[]{p1};
    }
    
    double root1x, root2x;
    
    root1x = (-q_b+q_sqrt)/q_2a;
    root2x = (-q_b-q_sqrt)/q_2a;
    
    PointD p1 = new PointD(root1x, function(root1x));
    PointD p2 = new PointD(root2x, function(root2x));
    return new PointD[]{p1, p2};
  }
  
  
  PointD midPointIntersect(ParabolaD parabola2){
    PointD[] points = intersect(parabola2);
    double min, max;
    if(h<parabola2.h){
      min = h;
      max = parabola2.h;
    }else{
      min = parabola2.h;
      max = h;
    }
    if(points[0].x>min && points[0].x<max){
      return points[0];
    }else{
      return points[1];
    }
    
  }
  
  void render(double resolution){
    double lastVal=function(0);
    for(double x=resolution;x<width;x+=resolution){
      double val=function(x);
      //println(x, val);
      line((float)(x-resolution), (float)lastVal, (float)x, (float)val);
      lastVal = val;
    }
  }
  
  void render(double start, double end, double resolution){
    start = Math.max(0,start);
    end = Math.min(width,end);
    double lastVal=function(start);
    double prevX=start;
    for(double x=start;x<end;x+=resolution){
      if(x>end){
        x= end;
      }
      double val=function(x);
      //println(x, val);
      line((float)(prevX), (float)lastVal, (float)x, (float)val);
      prevX = x;
      lastVal = val;
    }
  }
  
}