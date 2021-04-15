class Target {
  PVector loc;
  float radius;

  Target(float X, float Y, float R) {
    loc = new PVector(X, Y);
    radius = R;
  }
  
  void disp() {
   push();
   noStroke();
   fill(255);
   translate(loc.x, loc.y);
   ellipse(0,0,radius*2,radius*2);
   pop();
  }
}
