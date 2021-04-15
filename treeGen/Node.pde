class Node {
  int id;
  PVector pos, vel, acc, dim;
  float mass;
  float maxAcc, maxVel;
  boolean mousedOver;
  color nodeCol, antiNodeCol, textCol, antiTextCol;

  int generation;
  int offspring;

  Node(int ID) {
    id = ID;
    pos = new PVector(0, 0);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
    dim = new PVector(20, 20);
    mousedOver = false;

    nodeCol = color(255, 255, 255);
    antiNodeCol = color(0, 0, 0);
    textCol = color(0, 0, 0);
    antiTextCol = color(255, 255, 255);
    generation = 0;
    offspring = 0;
    maxAcc = .1;
    maxVel = 1;
    mass = 10;
  }

  boolean eq(Node T) {
    if (T.id == this.id)
      return true;
    return false;
  }

  void addForce(PVector F) {
    acc.add(F.mult(1/mass));
  }

  void update() {
    acc.limit(maxAcc);
    vel.add(acc);
    vel.limit(maxVel);
    pos.add(vel);
    acc.mult(0);
  }

  void disp() {
    push();
    translate(pos.x, pos.y);
    strokeWeight(2);
    stroke(antiNodeCol);
    fill(nodeCol);
    if (mousedOver) {
      stroke(nodeCol);
      fill(antiNodeCol);
    }
    rectMode(CENTER);
    rect(0, 0, dim.x, dim.y);
    //circle(0, 0, 20);
    fill(textCol);    
    if (mousedOver)  fill(antiTextCol);
    textAlign(CENTER);
    text(offspring, 0, 5);
    pop();
  }
}
