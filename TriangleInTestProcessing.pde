// interactive Triangle.contains() test
// 2019-11-23 dan@marginallyclever.com

// VARIABLES
  
Triangle2D t = new Triangle2D();
Point2D mouse = new Point2D();


// METHODS

void setup() {
  size(800,800);
  t.a = new Point2D(            random(width/4),random(height/2));
  t.c = new Point2D(width*3/4 + random(width/4),random(height/2));
  t.b = new Point2D(            random(width  ),random(height/2)+height/2);
}


void draw() {
  mouse.x=mouseX;
  mouse.y=mouseY;

  noFill();
  background(192);
  strokeWeight(2);
  rainbowColor(3.0/6.0);
  line(t.a.x,t.a.y,t.b.x,t.b.y);
  line(t.b.x,t.b.y,t.c.x,t.c.y);
  line(t.c.x,t.c.y,t.a.x,t.a.y);

  // find the center of the circle with three points p[N]
  Point2D c = t.findCircumCenter();

  // find the radius squared of the circle
  float dx = t.a.x-c.x;
  float dy = t.a.y-c.y;
  float r = sqrt(dx*dx + dy*dy);
  
  strokeWeight(2);
  rainbowColor(6.0/6.0);
  point(c.x,c.y);
  circle(c.x,c.y,r*2);
  
  // cursor in triangle?
  int i = t.isPointInCircumCircle(mouse) ? 3:0;
  // cursor in circle?
  i = t.contains(mouse)? 5:i;

  strokeWeight(5);
  rainbowColor((float)(i)/6.0);
  point(mouseX,mouseY);
  
  stroke(0);
  strokeWeight(3);
  EdgeDistancePack edp = t.findNearestEdge(mouse);
  strokeWeight(1);
  line(edp.edge.a.x,edp.edge.a.y,
       edp.edge.b.x,edp.edge.b.y);
}




// (0...1]
void rainbowColor(float zeroToOne) {
  // index as hsv to rgb
  // https://en.wikipedia.org/wiki/HSL_and_HSV#HSV_to_RGB
  // Assume Hue=v/360, saturation=1, value=1.
  float C = 1;// C=V*S
  float H = zeroToOne*6;
  float X = C * (1-abs((H % 2) - 1));
  
  float r,g,b;
  
       if(H<1) { r=C; g=X; b=0; }
  else if(H<2) { r=X; g=C; b=0; }
  else if(H<3) { r=0; g=C; b=X; }
  else if(H<4) { r=0; g=X; b=C; }
  else if(H<5) { r=X; g=0; b=C; }
  else         { r=C; g=0; b=X; }  // H<6
  
  stroke(r*255,g*255,b*255);
}
