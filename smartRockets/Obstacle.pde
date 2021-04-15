class Obstacle {
  PVector loc;
  float rad;
  ArrayList<PVector> points;
  int n;

  Obstacle(float X, float Y, float R) {
    points = new ArrayList<PVector>();
    loc = new PVector(X, Y);
    println(loc);
    rad = R;
    circ(int(random(3,10)));
  }

  void circ(float N) {   
    PVector temp = new PVector(0, 0);
    float angVel = 2*PI/N;
    for (int i=0; i<N; i++) {
      temp.set(cos(angVel*i), sin(angVel*i) );
      temp.setMag(rad);
      println(temp);
      points.add(temp.copy());
    }
    update();
  }

  void update() {
    n = points.size();
  }

  void disp() {
    push();
    translate(loc.x, loc.y);
    stroke(255);
    //noStroke();
    strokeWeight(1);
    fill(255,100);
    rotate(3*frameCount/(rad*n));
    beginShape();
    for (int i=0; i<n; i++) {
      vertex(points.get(i).x, points.get(i).y);
    }
    vertex(points.get(0).x, points.get(0).y);
    endShape(CLOSE);
    pop();
  }
}
