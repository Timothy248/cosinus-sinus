class Point {
  float x, y;
  
  int r, g, b;
  
  Point(float x, float y, int r, int g, int b) {
    this.x = x;
    this.y = y;
    this.r = r;
    this.b = b;
    this.g = g;
  }
  
  void update() {
    strokeWeight(4);
    stroke(r, g, b);
    point(x, y);
  }
}
