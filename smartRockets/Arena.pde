class Arena { 
  float wide, high;
  int xoff = 10;
  int yoff = 10;

  Population P;  //current generation being simulated
  ArrayList<Obstacle> obstacles;

  int currentRound;

  Arena(int W, int H, Population Q) {
    wide = W;
    high = H;
    P = Q;
    currentRound = 1;
    obstacles = new ArrayList<Obstacle>();
    readout();
  }

  void update() {
    detectCollisions(); 
    dieOfOldAge();
    P.update();
  }

  void disp() {
    push();
    rectMode(CENTER);
    noStroke();
    fill(0);
    translate(xoff, yoff);
    translate(wide/2, high/2);
    rect(0, 0, wide, high);
    for (Obstacle o : obstacles) o.disp();
    P.disp();
    pop();
    //readout();
  }
  
  void createObs(int O) {
    for (int i=0; i<O; i++) {
      float randAng = random(0,2*PI);
      float randRad = random(50,200);
      Obstacle t = new Obstacle(randRad*cos(randAng), randRad*sin(randAng), random(20,50));
      t.loc.add(P.target.loc);
      obstacles.add(t);
    }
  }

  void detectCollisions() {
    for (Rocket r : P.rockets) {
      r.alive = false;
      if ( r.pos.x > -wide/2 && r.pos.x < wide/2 )
        if ( r.pos.y > -high/2 && r.pos.y < high/2 )  
          r.alive = true;
      if (dist(r.pos.x, r.pos.y, P.target.loc.x, P.target.loc.y) < P.target.radius) {
        r.alive = false;
        r.reachedGoal = true;
      }
      for (Obstacle b : obstacles) {
        if (dist(r.pos.x, r.pos.y, b.loc.x, b.loc.y) < b.rad) {
          r.alive = false;
        }
      }
    }
  }

  void dieOfOldAge() {    
    for (Rocket r : P.rockets) {
      if (r.count > P.lifespan) r.alive = false;
    }
  }

  void readout() {
    push();
    translate(wide+2*xoff, yoff);
    rectMode(CORNERS);
    stroke(255);
    fill(255/4);
    rect(0, 0, (width-wide)-3*xoff, height-2*yoff);
    translate((width-wide)/2, yoff+24);
    fill(255);
    textAlign(CENTER);
    text("Current Generation: " + currentRound, 0, 0);
    translate(0, 24*2.0);
    text("Last Generation:", 0, 0);
    translate(0, 24*1.0);
    text("Population Size: " + P.popSize, 0, 0);
    translate(0, 24*1.0);
    text("Max Fitness: " + P.maxFitness, 0, 0);
    translate(0, 24*1.0);
    text("Reached Goal: " + P.succesful, 0, 0);
    translate(0, 24*1.0);
    text("Best Time: " + P.minFrames + " frames", 0, 0);
    //best time
    //longest time
    //prev maxfitness
    //prev reached goal

    pop();
  }
}
