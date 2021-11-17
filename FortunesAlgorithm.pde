ArrayList<PointD> pointSet;

Voronoi4 voronoi;
ShapeD boundary;

void setup(){
  zoom = 1;
  translate = new Point(0,0);
  size(1000,1000);
  
  boundary = new ShapeD();
  boundary.addVertex(0,0);
  boundary.addVertex(width,0);
  boundary.addVertex(width,height);
  boundary.addVertex(0,height);
  
  if(true){return;}
  pointSet = new ArrayList<PointD>();
  
  for(int i=0;i<50;i++){
    pointSet.add(new PointD(Math.random()*width, Math.random()*height));
  }
  /*
  for(int i=0;i<2;i++){
    pointSet.add(new PointD(width*Math.random(), 100));
  }
  pointSet.add(new PointD(width*Math.random(), 100+500*Math.random()));
  
  voronoi = new Voronoi4(pointSet, new PointD(0,0), new PointD(width,height));
  */
  background(150);
  
  
  voronoi = new Voronoi4(pointSet, boundary);
  if(true){
  return;}

  voronoi.init();
  int start = millis();
  voronoi.run();
  println("time taken : " + (millis()-start));
  //pushMatrix();
  //translate(width/4, height/4);
  //scale(0.5);
  voronoi.drawResult();
  
  //popMatrix();
}



double y=0;
void draw(){
  
  /*
  scale(0.5);
  translate(width/2, height/2);
  stroke(0);
  background(150);
  boundary.render();
  stroke(255,0,0);
  boundary.renderEdges();
  stroke(0);
  DirectionalLineD mLine = new DirectionalLineD(new PointD(width/4, height/2), new PointD(mouseX, mouseY));
  mLine.render();
  
  ArrayList<PointD> intersects = boundary.intersect(mLine);
  for(PointD p: intersects){
    ellipse((float)p.x,(float)p.y,20,20);
  }
  
  EdgeD edge = new EdgeD(new PointD(100,100), new PointD(200,100));
  edge.render();
  PointD inter2 = edge.intersect(mLine);
  if(inter2!=null){
    
    ellipse((float)inter2.x,(float)inter2.y,20,20);
  }
  
  */
  
  
  /*
  what2: 27
  441.2933389537189 , 436.3115273545775
  arc closing: null
  ray intersect: null
  ray values: left origin:(436.19778600761947, 474.22883627765407) direction: -0.5646477403121102 right origin: (420.31221474260064, 439.95234887081045) direction: 1.1368434764948527
  line intersect: (436.1967292173133, 474.22950569419334)
  line values: left m: -0.6334431111341262 c: 750.5353189161383  right m: 2.157897673104863 c: -467.038401299799
  DEBUG RAY INTERSECT START 
  DEBUG RAY: line intersect: (436.1967292173133, 474.22950569419334)
  DEBUG RAY: NOT NULL LINE CHECK PASSED
  DEBUG RAY: DIRECTION OFFSET LINE 1: 3.141592653648252
  */
  /*
  background(150);
  DirectionalLineD dLine1, dLine2, dLine3;
  dLine1 = new DirectionalLineD(new PointD(0,0),0);
  dLine1.direction = -0.5646477403121102d;
  dLine1.origin = new PointD(436.19778600761947d, 474.22883627765407d);
  dLine1.line = new LineD();
  dLine1.line.m = -0.6334431111341262d;
  dLine1.line.c =750.5353189161383d;
  
  dLine2 = new DirectionalLineD(new PointD(713.7900346335994d,266.07147299501514d), new PointD(712.7910601829259d,266.1167504386449d));
  
  dLine3= new DirectionalLineD(new PointD(713.7899418835999d,0d),new PointD(713.7899418835999d,266.07147719880925d));
  
  println(dLine2.intersect(dLine3));
  
  if(true){
    return;
  }
  
  DirectionalLineD mLine = new DirectionalLineD(new PointD(width/4, height/2), new PointD(mouseX, mouseY));
  
  dLine1.line.drawLine();
  mLine.line.drawLine();
  PointD intersect = dLine1.intersect(mLine);
  if(intersect!=null){
    ellipse((float)intersect.x, (float)intersect.y,10,10);
  }
  if(true){
    return;
  }
  */
  //background(150);
  
  /*
  PointD p3 = new PointD(mouseX, mouseY);
  CircleD c = new CircleD(pointSet.get(0), pointSet.get(1), p3);
  noFill();
  
  stroke(255,255,0);
  strokeWeight(3);
  for(PointD p: pointSet){
    ellipse((float)p.x, (float)p.y,100,100);
  }
  
  c.render();
  stroke(255);
  line(0,(float)y,width,(float)y);
  y++;
  */
  
  /*
  ParabolaD parabola = new ParabolaD(new PointD(mouseX,mouseY), 0);
  parabola.render(5);
  */
  
  //drawParabola(new PointD(mouseX, mouseY), height);
  
  /*
  background(150);
  stroke(0);
  LineD line = new LineD(2,10);
  line.drawLine();
  stroke(255,0,0);
  float rotate = ((float)frameCount)/100;
  println("rotate: " + rotate);
  LineD line2 = new LineD(new PointD(mouseX, mouseY), line.getAng());
  line2.drawLine();
  
  stroke(0,0,255);
  
  LineD line3 = new LineD(new PointD(mouseX, mouseY), line.getAng()+PI/2);
  line3.drawLine();
  */
  
  /*
  if(frameCount%60==0){
  }
  */
  
  
  /*
  background(150);
  ParabolaD p1, p2;
  
  fill(255);
  p1 = new ParabolaD(new PointD(width/2,0), height);
  p2 = new ParabolaD(new PointD(mouseX, mouseY), height);
  p1.render(5);
  p2.render(5);
  PointD[] intersects = p1.intersect(p2);
  PointD[] topIntersects = p2.intersect(new LineD());
  for(PointD p: topIntersects){
    ellipse((float)p.x, (float)p.y, 10,10);
  }
  for(PointD p: intersects){
    println(p.x + ", " + p.y);
    ellipse((float)p.x, (float)p.y, 10,10);
  }
  
  */
  
  
  
  /*
    background(150);
  LineD left, right;
  double ang = ((double)frameCount)/100;
  left = new LineD(new PointD(width/2, height/2), 0);
  right = new LineD(new PointD(width/2, height/2), new PointD(mouseX, mouseY));
  left.drawLine();
  right.drawLine();
  println("left ang: " + left.getAng() + "  right ang: " + right.getAng() + "  ang: "  + getSmallestAngBetweenLine(right.getAng(), left.getAng()));
  
  */
  
  /*
  background(100);
  DirectionalLineD line1, line2;
  line1 = new DirectionalLineD(new PointD(width/2, 0), new PointD(width/2, 100));
  line2 = new DirectionalLineD(new PointD(width/4, height/2), new PointD(mouseX, mouseY));
  line1.line.drawLine();
  line2.line.drawLine();
  PointD intersect = line1.intersect(line2);
  if(intersect!=null){
    ellipse((float)intersect.x, (float)intersect.y, 10,10);
  }else{
    println("NO INTERSECT");
  }*/
  
  /*
  PointD p1,p2;
  LineD line;
  p1 = new PointD(random(0,width), random(0,height));
  p2 = new PointD(random(0,width), random(0,height));
  line = new LineD(p1,p2);
  PointD relative = p2.subP(p1);
  
  //println(line.getAng() + " , " + relative.ang() + " , " + "difference: " + (line.getAng()-relative.ang()));
  double angDif = Math.abs(getSmallestAngBetweenLine(line.getAng(), relative.ang()));
  if(angDif>0.01){
    println("AHH" + angDif);
  }
  */
 
 
  if(voronoi==null){return;}
  if(mouseY!=pmouseY || mouseX!=pmouseX || changed){
    changed = false;
    pushMatrix();
    translate(width/2,height/2);
    scale(zoom);
    translate(-width/2,-height/2);
    translate(translate.x, translate.y);
    background(150);
    if(!pause){
      voronoi.runTo(mouseY);
    }
      
    voronoi.drawState();
    voronoi.drawResult();
    popMatrix();
  }
  
  
}

double getSmallestAngBetween(double ang1, double ang2){
  double dAng = ang1-ang2;
  while(dAng<0){
    dAng+=2*PI;
  }
  dAng = dAng%(2*PI);
  if(dAng>PI){
    return 2*PI-dAng;
  }else{
    return dAng;
  }
}

double getSmallestAngBetweenLine(double ang1, double ang2){
  
  double dAng = ang1-ang2;
  //dAng = trueMod(dAng + PI,2*PI)-PI;
  if(Math.abs(dAng)>PI/2){
    if(dAng<0){
      dAng = PI+dAng;
    }else{
      dAng = -PI+dAng;
    }
  }
  return dAng;
}

double trueMod(double val, double mod){
  while(val<0){
    val+=mod;
  }
  val = val%mod;
  return val;
}


/*
PointD rangeToPoints(double x1, double x2){
  
}*/

void drawParabola(PointD p, double sweepLine){
  PointD vertex = new PointD(p.x, (p.y+sweepLine)/2);
  point((float)vertex.x, (float)vertex.y);
  double parabolaY;
  double lastParabolaY = vertex.y;
  double xOffset=0;
  
  double max= Math.max(p.x, width-p.x);
  
  while(lastParabolaY > 0 && xOffset < max){
    xOffset+=10;
    parabolaY = parabola(p.y, vertex.y, p.x, p.x+xOffset);
    line((float)(p.x + xOffset-10), (float)lastParabolaY, (float)(p.x + xOffset), (float)parabolaY);
    
    line((float)(p.x - (xOffset-10)), (float)lastParabolaY, (float)(p.x - xOffset), (float)parabolaY);
    
    lastParabolaY = parabolaY;
  }
}

double parabola(double focusY, double vertexY, double h, double x){
  
  println("focusY: " + focusY);
  println("vertexY: " + vertexY);
  double a = (focusY-vertexY)*4;
  //a = 1;
  println("a: " + a);
  println("h: " + h);
  return a*Math.pow(x - h,2)+vertexY;
}


boolean stopAutoFlag = false;
boolean pause;
boolean drawState = true;
void keyPressed(){
  if(key=='r'){
    
    background(150);
    //stroke(255,255,0);
    //strokeWeight(3);
    
    voronoi.init();
    //voronoi.drawState();
  }
  if(key=='s'){
    
    background(150);
    //stroke(255,255,0);
    //strokeWeight(3);
    
    voronoi.step();
    voronoi.drawState();
  }
  if(key=='d'){
    drawState = !drawState;
  }
  if(key=='p'){
    pause = !pause;
  }
  if(key=='q'){
    
    for(int i=0;i<pointSet.size();i++){
      pointSet.get(i).addToThis(new PointD(random(-1,1), random(-1,1)));
    }
    background(150);
    
    voronoi = new Voronoi4(pointSet, boundary);
    voronoi.init();
    int start = millis();
    voronoi.run();
    println("time taken : " + (millis()-start));
    //pushMatrix();
    //translate(width/4, height/4);
    //scale(0.5);
    voronoi.drawResult();
  }
  if(key==' '){
    
    pointSet = new ArrayList<PointD>();
    
    for(int i=0;i<10;i++){
      pointSet.add(new PointD(Math.random()*width, Math.random()*height));
    }
    background(150);
    
    voronoi = new Voronoi4(pointSet, boundary);
    voronoi.init();
    int start = millis();
    voronoi.run();
    println("time taken : " + (millis()-start));
    //pushMatrix();
    //translate(width/4, height/4);
    //scale(0.5);
    voronoi.drawResult();
  }
  
  if(key=='x'){
    
    pointSet = new ArrayList<PointD>();
    
    for(int i=0;i<10000;i++){
      pointSet.add(new PointD(Math.random()*width, Math.random()*height));
    }
    background(150);
    
    voronoi = new Voronoi4(pointSet, boundary);
    voronoi.init();
    int start = millis();
    voronoi.run();
    println("time taken : " + (millis()-start));
    //pushMatrix();
    //translate(width/4, height/4);
    //scale(0.5);
    voronoi.drawResult();
  }
  if(key=='a'){
    stopAutoFlag=false;
      int c = 0;
    while(!stopAutoFlag){
      pointSet = new ArrayList<PointD>();
      c++;
      if(c%10==0){
        println(c);
      }
      
      for(int i=0;i<1000;i++){
        pointSet.add(new PointD(Math.random()*width, Math.random()*height));
      }
      /*
      for(int i=0;i<1000;i++){
        pointSet.add(new PointD(Math.random()*width, (height/1.5) + Math.random()*1));
      }
      */
      
      background(150);
      voronoi = new Voronoi4(pointSet, boundary);
      voronoi.init();
      
      int start = millis();
      voronoi.runTo((float)height*3f/4);
      println("time taken : " + (millis()-start));
    voronoi.drawState();
      //pushMatrix();
      //translate(width/4, height/4);
      //scale(0.5);
    }
  }
  if(key=='t'){
    
      pointSet = new ArrayList<PointD>();
    
      for(int i=0;i<2;i++){
        //pointSet.add(new PointD(width*Math.random(), 100));
      }
        pointSet.add(new PointD(500, 100));
        pointSet.add(new PointD(600, 100));
      pointSet.add(new PointD(-0.000000000001d+(pointSet.get(0).x + pointSet.get(1).x)/2, 100+500));
      
  
      background(150);
      
      voronoi = new Voronoi4(pointSet, boundary);
      voronoi.init();
      int start = millis();
      voronoi.runTo((float)height*3f/4);
      println("time taken : " + (millis()-start));
      //pushMatrix();
      //translate(width/4, height/4);
      //scale(0.5);
      voronoi.drawState();
    /*
    what2: 51
    773.7741331680929 , 761.1312784252415
    arc closing: null
    ray intersect: null
    ray values: left origin:(763.4942648004917, 475.5597128869771) direction: 0.5574200615388871 right origin: (798.5508502180538, 469.81113529817867) direction: 2.979066650708104
    line intersect: (763.4939241058887, 475.55950051114405)
    line values: left m: 0.623361307189962 c: -0.37307005109636293  right m: -0.16397231162177223 c: 600.7513641559646
    */

    /*
    what2: 27
    441.2933389537189 , 436.3115273545775
    arc closing: null
    ray intersect: null
    ray values: left origin:(436.19778600761947, 474.22883627765407) direction: -0.5646477403121102 right origin: (420.31221474260064, 439.95234887081045) direction: 1.1368434764948527
    line intersect: (436.1967292173133, 474.22950569419334)
    line values: left m: -0.6334431111341262 c: 750.5353189161383  right m: 2.157897673104863 c: -467.038401299799
    DEBUG RAY INTERSECT START 
    DEBUG RAY: line intersect: (436.1967292173133, 474.22950569419334)
    DEBUG RAY: NOT NULL LINE CHECK PASSED
    DEBUG RAY: DIRECTION OFFSET LINE 1: 3.141592653648252
    */
    
    
  }
  if(key=='u'){
    zoom*=1.1;
  }
  if(key=='o'){
    zoom/=1.1;
  }
  if(key=='i'){
    translate.y+=10/zoom;
  }
  if(key=='k'){
    translate.y-=10/zoom;
  }
  if(key=='j'){
    translate.x+=10/zoom;
  }
  if(key=='l'){
    translate.x-=10/zoom;
  }
  changed = true;
}

float zoom;
Point translate;
boolean changed = false;