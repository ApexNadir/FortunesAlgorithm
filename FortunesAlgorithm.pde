ArrayList<PointD> pointSet;

Voronoi4 voronoi;


void setup(){
  size(1000,1000);
  pointSet = new ArrayList<PointD>();
  
  for(int i=0;i<500;i++){
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
  
  voronoi = new Voronoi4(pointSet, new PointD(0,0), new PointD(width,height));
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
 
  
  if(mouseY!=pmouseY || mouseX!=pmouseX){
  if(voronoi==null){return;}
    background(150);
    if(!pause){
      voronoi.runTo(mouseY);
    }
      
    voronoi.drawState();
    voronoi.drawResult();
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
    voronoi = new Voronoi4(pointSet, new PointD(0,0), new PointD(width,height));
  }
  if(key==' '){
    
    pointSet = new ArrayList<PointD>();
    
    for(int i=0;i<500;i++){
      pointSet.add(new PointD(Math.random()*width, Math.random()*height));
    }
    background(150);
    
    voronoi = new Voronoi4(pointSet, new PointD(0,0), new PointD(width,height));
    voronoi.init();
    int start = millis();
    voronoi.run();
    println("time taken : " + (millis()-start));
    //pushMatrix();
    //translate(width/4, height/4);
    //scale(0.5);
    voronoi.drawResult();
  }
}