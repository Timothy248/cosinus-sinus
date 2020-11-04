int x, y, r;
float px, py;

float a, b, c;
int fr, fg, fb;

ArrayList<Point> points = new ArrayList<Point>();

boolean MOUSE = true;
boolean SIN = true;

int counter;
float speed;

// button things
int bx, by, bsx, bsy;
boolean overMouseButton = false;
boolean overModeButton = false;



// alpha in radians
float alpha;

void setup() {
  size(1200, 800);
  x = 200;
  y = 400;
  r = 90;
  
  // button x/y, button size x/y axis
  bx = 100;
  by = 200;
  bsx = 100;
  bsy = 50;
  
  // between 0 and 6
  speed = 3;
  
  alpha = 0;
  counter = 0;
  
  speed = map(speed, 0, 6, 0, (float) (Math.PI / (Math.PI * 200) * 12));
}


void draw() {
  background(51);
  update(mouseX, mouseY);
  updateColor();
  
  // button to change from mouse to auto
  fill(255);
  if(overMouseButton) fill(70);
  rect(bx, by, bsx, bsy);
  fill(255);
  textSize(32);
  textAlign(LEFT, TOP);
  fill(0);
  if(MOUSE) text("Auto", bx + 13, by + 5);
  else text("Maus", bx + 10, by + 5);
  
  // sin / cos button
  fill(255);
  if(overModeButton) fill(70);
  rect(bx + 110, by, bsx - 10, bsy);
  fill(255);
  textSize(32);
  textAlign(LEFT, TOP);
  fill(0);
  if(SIN) text("Cos", bx + 123, by + 5);
  else text("Sin", bx + 131, by + 5);
  
  fill(255);
  if(SIN) text("Sinus", x-r - 13, x-r);
  else text("Cosinus", x-r - 10, x-r);
  
  strokeWeight(5);
  point(x, y);
  circle(x, y, r*2);
  
  strokeWeight(3);
  if(MOUSE) {
    a = mouseX - x;
    b = mouseY - y;
    c = sqrt((a*a) + (b*b));
  
    if(mouseY <= y) alpha = acos(a/c);
    else alpha = 2 * PI - acos(a/c);
    if(Float.isNaN(alpha)) alpha = 0;
  } else {
    alpha += speed;
    if(alpha >= 2 * PI) alpha = 0;
    
    counter++;
    if(counter > PI * 200) {
      counter = 0;
      points.clear();
    }
  }
  
  //middle line
  if(!MOUSE) {
    stroke(30);
    line(x + (r*2), y, x + (r*2) + PI * 200, y);
  } else {
    stroke(30);
    line(x + ((PI * 200) / 5 * 2) + (r*2), y, x + (r*2) + ((PI * 200) / 5 * 3) , y);
  }
  
  // cos line
  stroke(255, 0, 0);
  line(x, y, x + map(cos(alpha), -1, 1, -r, r), y);
  
  // sin line
  stroke(0, 255, 0);
  line(x + map(cos(alpha), -1, 1, -r, r), y, x + map(cos(alpha), -1, 1, -r, r), y - map(sin(alpha), -1, 1, -r, r));
  
  // third line
  stroke(0);
  line(x, y, x + map(cos(alpha), -1, 1, -r, r), y - map(sin(alpha), -1, 1, -r, r));
  
  // wavy line / dot
  if(!MOUSE) {
     stroke(fr, fg, fb);
     float value;
     if(SIN) value = map(sin(alpha), -1, 1, -r, r);
     else value = map(cos(alpha), -1, 1, -r, r);
     points.add(new Point(map(counter, 1, PI * 200, x+(r*2)+1, x+(r*2)+PI * 200), y + value * -0.5, fr, fg, fb));
     for(Point point : points) {
       point.update();
     }
  } else {
     stroke(fr, fg, fb);
     float value;
     strokeWeight(12);
     if(SIN) value = map(sin(alpha), -1, 1, -r, r);
     else value = map(cos(alpha), -1, 1, -r, r);
     point(x + ((PI * 200) / 2) + (r*2), y + value);
  }
  
  stroke(30);
  strokeWeight(6);
  
  if(!MOUSE) {
    // left line
    line(x + (r*2), y + (r/2) + 20, x + (r*2), y - (r/2) - 20);
  
    // right line
    line(x + (r*2) + (PI * 200), y + (r/2) + 20, x + (r*2) + (PI * 200), y - (r/2) - 20);
  }
}

void update(int x, int y) {
  overMouseButton = overRect(x, y, bx, by, bsx, bsy);
  overModeButton = overRect(x, y, bx + 110, by, bsx, bsy);
}

void mousePressed() {
  if(overMouseButton) MOUSE = !MOUSE;
  else if(overModeButton) {
    SIN = !SIN;
    points.clear();
    alpha = 0;
    counter = 0;
  }
  
  if(!MOUSE && overMouseButton) {
    points.clear();
    alpha = 0;
    counter = 0;
  }
}

void updateColor() {
 if(!SIN) {
   fr = 255;
   fg = 0;
   fb = 0;
 } else {
   fr = 0;
   fg = 255;
   fb = 0;
 }
}

boolean overRect(int x, int y, int rx, int ry, int rsx, int rsy) {
  boolean overRect = false;
  if(x > rx && x < rx + rsx && y > ry && y < ry + rsy) overRect = true;
  return overRect;
}
