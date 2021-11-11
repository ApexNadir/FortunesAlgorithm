import java.util.*;

class Voronoi4{
  ArrayList<Arc> beachLine;
  ArrayList<PointD> points;
  PointD topLeft, bottomRight;
  double sweepLine;
  
  int nextPoint=0;
  
  ArrayList<PointD> vertices;
  HashMap<PointD, ArrayList<PointD>> verticesMap;
  
  
  Voronoi4(ArrayList<PointD> points_, PointD topLeft_, PointD bottomRight_){
    points = new ArrayList<PointD>();
    for(PointD point: points_){
      points.add(point);
    }
    sortPointsVertically();
    topLeft = topLeft_;
    bottomRight = bottomRight_;
  }
  
  void init(){
    beachLine = new ArrayList<Arc>();
    sweepLine=0;
    nextPoint = 0;
    vertices= new ArrayList<PointD>();
    verticesMap = new HashMap<PointD, ArrayList<PointD>>();
  }
  void addVertexToPoint(PointD point, PointD vertex){
    if(!verticesMap.containsKey(point)){
      verticesMap.put(point, new ArrayList<PointD>());
    }
    ArrayList<PointD> array = verticesMap.get(point);
    array.add(vertex);
  }
  
  double getNextEventY(){
    PointD point = getNextPoint();
    CircleEvent circleEvent = getNextCircleEvent();
    
    if(point==null && circleEvent ==null){
      //DONE
      return Double.MAX_VALUE;
    }else if(point == null && circleEvent!=null){
      return circleEvent.closeY;
    }else if(point != null && circleEvent==null){
      return point.y;
    }else{
      if(point.y<circleEvent.getCloseY()){
        return point.y;
      }else{
        return circleEvent.closeY;
      }
    }
  }
  
  boolean step(){
    PointD point = getNextPoint();
    CircleEvent circleEvent = getNextCircleEvent();
    if(point==null && circleEvent ==null){
      //DONE
      return true;
    }else if(point == null && circleEvent!=null){
      executeCircleEvent(circleEvent);
    }else if(point != null && circleEvent==null){
      executeNewPointEvent(point);
    }else{
      if(point.y<circleEvent.getCloseY()){
        executeNewPointEvent(point);
      }else{
        executeCircleEvent(circleEvent);
      }
    }
    return false;
    
    
  }
  
  void run(){
    init();
    
    while(!step()){
      
    }
    
    orderVertices();
  }
  
  void runTo(double max){
    println();
    println("voronoi start");
    init();
    while(true){
      double nextEvent = getNextEventY();
      if(nextEvent>max){
        break;
      }
      
      boolean finished = step();
      if(finished){
        break;
      }
      
    }
    updateSweepLine(max);
  }
  
  void drawResult(){
    orderVertices();
    for(PointD p: points){
      stroke(255,0,255);
      ellipse((float)p.x, (float)p.y, 5, 5);
      
      ArrayList<PointD> verticesForPoint = verticesMap.get(p);
      stroke(0,0,255);
      if(verticesForPoint!=null){
        /*
        for(PointD vert: verticesForPoint){
          line((float)p.x, (float)p.y, (float)vert.x, (float)vert.y);
        }*/
        int i=0;
        for(i=0;i<verticesForPoint.size()-1;i++){
          PointD vert = verticesForPoint.get(i);
          PointD vert2 = verticesForPoint.get(i+1);
          line((float)vert.x, (float)vert.y, (float)vert2.x, (float)vert2.y);
        }
          PointD vert = verticesForPoint.get(0);
          PointD vert2 = verticesForPoint.get(i);
          line((float)vert.x, (float)vert.y, (float)vert2.x, (float)vert2.y);
      }
    }
    
  }
  
  void drawState(){
    orderVertices();
    for(PointD p: points){
      stroke(255,0,255);
      ellipse((float)p.x, (float)p.y, 5, 5);
      
      stroke(0,0,255);
      ArrayList<PointD> verticesForPoint = verticesMap.get(p);
      if(verticesForPoint!=null){
        /*
        for(PointD vert: verticesForPoint){
          line((float)p.x, (float)p.y, (float)vert.x, (float)vert.y);
        }*/
        int i=0;
        for(i=0;i<verticesForPoint.size()-1;i++){
          PointD vert = verticesForPoint.get(i);
          PointD vert2 = verticesForPoint.get(i+1);
          line((float)vert.x, (float)vert.y, (float)vert2.x, (float)vert2.y);
        }
          PointD vert = verticesForPoint.get(0);
          PointD vert2 = verticesForPoint.get(i);
          line((float)vert.x, (float)vert.y, (float)vert2.x, (float)vert2.y);
      }
    }
    line(0, (float)sweepLine, width, (float)sweepLine);
    
    for(PointD vertex: vertices){
      stroke(255,0,0);
      fill(255,0,0);
      ellipse((float)vertex.x, (float)vertex.y, 5, 5);
    }
    fill(255);
    
    for(Arc arc: beachLine){
      stroke(255,255,0);
      if(arc.baseArc.parabola!=null){
        println(arc.baseArc.parabola + " , " + arc.baseArc.parabola.a + " , " + arc.baseArc.parabola.h +  " , " + arc.baseArc.parabola.k);
        arc.baseArc.parabola.render(arc.leftBoundaryX(), arc.rightBoundaryX(), 5);
      println(arc.leftBoundaryX() + " | " + arc.left + " <-  arc: " + arc + " : " + arc.baseArc + " focus: " + arc.baseArc.focus + " -> " + arc.right + " | " + arc.rightBoundaryX());
        //println(arc.parabola.function(arc.focus.x));
      }else{
        println(arc.left + " <-  arc: " + arc + " : " + arc.baseArc + " focus: " + arc.baseArc.focus + " -> " + arc.right);
      }
    }
  }
  
  void executeCircleEvent(CircleEvent event){
    updateSweepLine(event.getCloseY());
    closeArc(event);
  }
  
  void executeNewPointEvent(PointD point){
    nextPoint++;
    updateSweepLine(point.y);
    addArc(point);
  }
  
  
  PointD getNextPoint(){
    if(nextPoint>=points.size()){
      return null;
    }
    return points.get(nextPoint);
  }
  
  CircleEvent getNextCircleEvent(){
    CircleEvent firstEvent = null;
    
    for(int i=0;i<beachLine.size();i++){
      Arc arc = beachLine.get(i);
      CircleEvent circleEvent = arc.getFutureClose();
      if(circleEvent!=null){
        if(firstEvent ==null || circleEvent.getCloseY()<firstEvent.getCloseY()){
          firstEvent = circleEvent;
        }
      }
    }
    return firstEvent;
  }
  
  void updateSweepLine(double newSweepLine){
    sweepLine = newSweepLine;
    for(Arc arc: beachLine){
      arc.baseArc.updateParabola(newSweepLine);
    }
  }
  
  void addArc(PointD point){
    Arc arc = new Arc(point, sweepLine);
    if(beachLine.size()==0){
      beachLine.add(arc);
    }else{
      ArcLink link = arcsAboveX(point.x);
      if(link.above==null){
        arc.left = link.left;
        arc.right = link.right;
        if(arc.left!=null){
          arc.left.right = arc;
          
          ArcLine leftLine = new ArcLine(new PointD((arc.left.baseArc.focus.x + arc.baseArc.focus.x)/2, -Double.MAX_VALUE), arc.left, arc);
          arc.left.rightLine = leftLine;
        }
        if(arc.right!=null){
          arc.right.left = arc;
          
          ArcLine rightLine = new ArcLine(new PointD((arc.baseArc.focus.x + arc.right.baseArc.focus.x)/2, -Double.MAX_VALUE), arc, arc.right);
          arc.rightLine = rightLine;
        }
        beachLine.add(link.index, arc);
      }else{
        
        Arc rightAboveArc = new Arc(link.above);
        rightAboveArc.right = link.above.right;
        rightAboveArc.left = arc;
        rightAboveArc.rightLine = link.above.rightLine;
        
        if(rightAboveArc.right!=null){
          rightAboveArc.right.left = rightAboveArc;
        }
        
        arc.left = link.above;
        arc.right = rightAboveArc;
        
        link.above.right = arc;
        
        beachLine.add(link.index+1, rightAboveArc);
        beachLine.add(link.index+1, arc);
        
        double contactPointY = link.above.baseArc.parabola.function(arc.baseArc.focus.x);
        PointD contactPoint = new PointD(arc.baseArc.focus.x, contactPointY);
        
        ArcLine arcLineLeft = new ArcLine(contactPoint, link.above, arc);
        link.above.rightLine = arcLineLeft;
        
        ArcLine arcLineRight = new ArcLine(contactPoint, arc, rightAboveArc);
        arc.rightLine = arcLineRight;
        
      }
    }
    
  }
  
  void closeArc(CircleEvent event){
    beachLine.remove(event.closingArc);
    if(event.closingArc.left!=null){
      event.closingArc.left.right = event.closingArc.right;
    }
    if(event.closingArc.right!=null){
      event.closingArc.right.left = event.closingArc.left;
    }
    PointD vertex = event.closePoint;
    
    vertices.add(vertex);
    //EUREKA
    
    addVertexToPoint(event.closingArc.left.baseArc.focus, vertex);
    addVertexToPoint(event.closingArc.baseArc.focus, vertex);
    addVertexToPoint(event.closingArc.right.baseArc.focus, vertex);
    
    
    ArcLine arcLine = new ArcLine(vertex, event.closingArc.left, event.closingArc.right);
    event.closingArc.left.rightLine = arcLine;
  }
  
  ArcLink arcsAboveX(double x){
    if(beachLine.size()==0){
      return new ArcLink(null,null,null);
    }
    
    ArcLink link = new ArcLink();
    
    int left, right, cur;
    
    left =0;
    right = beachLine.size()-1;
    
    while(true){
      cur = (left+right)/2;
      
      Arc arc = beachLine.get(cur);
      
      if(arc.leftBoundaryX()>x){
        right = cur-1;
        if(right<left){
          link.left = arc.left;
          link.right = arc;
          link.index = cur;
          return link;
        }
        continue;
      }
      if(arc.rightBoundaryX()<x){
        left = cur+1;
        if(right<left){
          link.left = arc;
          link.right = arc.right;
          link.index = cur+1;
          return link;
        }
        continue;
      }
      
      
      link.index = cur;
      link.above = arc;
      return link;
      
    }
    
    
    
  }
  
  
  
  
  void sortPointsVertically(){
    Collections.sort(points, new Comparator<PointD>() {
      public int compare(PointD p1, PointD p2) {
          if(p1.y<p2.y){
            return -1;
          }else{
            return 1;
          }
        }
    });
  }
  
  PointD comparePoint;
  
  void orderVertices(){
    for(PointD p: points){
      comparePoint = p;
      ArrayList<PointD> vertices = verticesMap.get(p);
      if(vertices!=null){
        Collections.sort(vertices, new Comparator<PointD>() {
          public int compare(PointD v1, PointD v2) {
              double angleV1, angleV2;
              angleV1 = v1.subP(comparePoint).ang();
              angleV2 = v2.subP(comparePoint).ang();
            
              if(angleV1<angleV2){
                return -1;
              }else{
                return 1;
              }
            }
        });
      }
    }
  }
  
}

class ArcLink{
  int index;
  
  Arc left, above, right;
  ArcLink(){
    index=-1;
  }
  ArcLink(Arc left_, Arc above_, Arc right_){
    index=-1;
    left = left_;
    above = above_;
    right = right_;
  }
}

class CircleEvent{
  Arc closingArc;
  PointD closePoint;
  double closeY;
  
  CircleEvent(Arc closingArc_, PointD closePoint_){
    closingArc = closingArc_;
    closePoint = closePoint_;
    closeY = closePoint.y + closePoint.distP(closingArc.baseArc.focus);
  }
  
  double getCloseY(){
    return closeY;
  }
}

class Arc{
  BaseArc baseArc;
  ArcLine rightLine;
  
  Arc left, right;
  
  Arc(PointD focus, double sweepLine){
    baseArc = new BaseArc(focus, sweepLine);
  }
  
  Arc(Arc originArc){
    baseArc = originArc.baseArc;
  }
  
  CircleEvent getFutureClose(){
    if(left==null || right==null){
      return null;
    }
    PointD intersect = left.rightLine.ray.intersect(rightLine.ray);
    
    if(intersect==null){
      return null;
    }
    return new CircleEvent(this, intersect);
  }
  
  PointD intersectRight(){
    PointD[] intersects = baseArc.parabola.intersect(right.baseArc.parabola);
    if(intersects.length==1){
      return intersects[0];
    }
    boolean amILower = baseArc.focus.y >= right.baseArc.focus.y;
    
    if(amILower){
      if(intersects[0].x>baseArc.focus.x){
        return intersects[0];
      }else{
        return intersects[1];
      }
    }else{
      if(intersects[0].x<right.baseArc.focus.x){
        return intersects[0];
      }else{
        return intersects[1];
      }
    }
  }
  
  double leftBoundaryX(){
    if(baseArc.straightLine){
      return baseArc.focus.x;
    }
    if(left==null){
      return Double.MIN_VALUE;
    }
    if(left.baseArc.straightLine){
      return left.baseArc.focus.x;
    }
    return left.intersectRight().x;
  }
  
  double rightBoundaryX(){
    if(baseArc.straightLine){
      return baseArc.focus.x;
    }
    if(right==null){
      return Double.MAX_VALUE;
    }
    if(right.baseArc.straightLine){
      return right.baseArc.focus.x;
    }
    return intersectRight().x;
  }
  
}

class BaseArc{
  PointD focus;
  
  ParabolaD parabola;
  double lastSweepLine;
  boolean straightLine;
  
  
  
  BaseArc(PointD focus_, double sweepLine){
    focus = focus_;
    straightLine = true;
    lastSweepLine = sweepLine;
  }
  
  void updateParabola(double newSweepLine){
    if(lastSweepLine!=newSweepLine){
      straightLine = false;
      parabola = new ParabolaD(focus, newSweepLine);
      lastSweepLine = newSweepLine;
    }
  }
}

class ArcLine{
  DirectionalLineD ray;
  ArcLine(PointD contactPoint, Arc leftArc, Arc rightArc){
    double ang = rightArc.baseArc.focus.subP(leftArc.baseArc.focus).ang() + PI/2;
    if(leftArc.baseArc.focus.y == rightArc.baseArc.focus.y){
      PointD verticalBelowPoint = new PointD(contactPoint.x, Double.MAX_VALUE);
      ray = new DirectionalLineD(contactPoint, verticalBelowPoint);
    }else{
      ray = new DirectionalLineD(contactPoint, ang);
    }
  }
}