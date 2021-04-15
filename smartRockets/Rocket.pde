class Rocket {
  PVector pos, vel, acc;
  boolean alive;
  DNA dna;
  float fitness;
  boolean reachedGoal;
  int count;

  Rocket(DNA D) {
    dna = D;
    pos = new PVector(0, 0);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    alive = true;
    fitness = 0;
    reachedGoal = false;
    count = 0;
  }

  void update() {
    if (count < dna.telo)  readDNA(count);
    vel.add(acc);
    pos.add(vel);
    acc.mult(0);
    count++;
  }

  void disp() {
    push();
    translate(pos.x, pos.y);
    rotate(vel.heading());
    noStroke();
    if (alive) fill(255);
    else fill(255/2);
    triangle(0, 0, -10, 3, -10, -3);
    pop();
  }

  void applyForce(PVector F) {
    acc.add(F.copy());
  }

  void readDNA(int f) {
    applyForce(dna.genes[f]);
  }
}
