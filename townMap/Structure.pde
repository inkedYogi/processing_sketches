class Structure {
  PVector rect;
  PVector ori;
  PVector loc;

  Structure(PVector L, PVector O) {
    loc = new PVector(L.x, L.y);
    rect = new PVector((int)random(6, 12), (int)random(8, 20));
    ori = O;
  }

  void disp() {
    pushMatrix();
    noStroke();
    fill(0);
    translate(loc.x, loc.y);
    rotate(ori.heading());
    rect(0, 0, rect.x, rect.y);
    //ellipse(0,0,5,5);
    //stroke(0);
    //line(0,0,10,0);
    popMatrix();
  }

  boolean inside(PVector T) {
    boolean result = false; 
    PVector t = loc.copy().sub(T);
    pushMatrix();
    translate(loc.x, loc.y);
    rotate(ori.heading());
    if (t.x-1 > 0 && t.x+1 < rect.x)
      if (t.y-1 > 0 && t.y+1 < rect.y)  result = true;
    popMatrix();
    return result;
  }
}
