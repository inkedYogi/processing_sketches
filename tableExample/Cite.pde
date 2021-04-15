// A Cite class

class Cite {
  float x,y;
  float diameter;
  String name;
  
  boolean mousedOver = false;
  
  // Create  the Cite
  Cite(float x_, float y_, float diameter_, String n) {
    x = x_;
    y = y_;
    diameter = diameter_;
    name = n;
  }
  
  
  void rollover(float px, float py) {    // Checking if mouse is mousedOver the Cite
    float d = dist(px,py,x,y);
    if (d < diameter/2)  mousedOver = true; else mousedOver = false;
  }
  
  // Display the Cite
  void display() {
    stroke(0);
    strokeWeight(2);
    noFill();
    ellipse(x,y,diameter,diameter);
    if (mousedOver) {
      fill(0);
      textAlign(CENTER);
      text(name,x,y+diameter/2+20);
    }
  }
}