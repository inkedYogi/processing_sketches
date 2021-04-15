class Population { //<>// //<>//
  ArrayList<Rocket> rockets;
  int popSize;  //members
  int lifespan; //frames
  Target target;
  //float threshold;
  ArrayList<Rocket> matingPool;
  int remaining;

  float maxFitness;
  int minFrames;
  int succesful;

  boolean mode;

  Population(int P, int T, int L) {
    popSize = P;
    lifespan = L;
    //threshold = .25;
    rockets = new ArrayList<Rocket>();
    firstGen(popSize, T);
    mode = true;
  }

  void update() {
    for (Rocket r : rockets)  if (r.alive)  r.update();
    observe(rockets);
    if (remaining == 0) {
      evaluate(rockets);
      A.currentRound++;
      A.readout();
      nextGen(popSize);
    }
  }

  void disp() {
    push();
    target.disp();
    for (Rocket r : rockets)  r.disp();
    pop();
  }

  void observe(ArrayList<Rocket> R) {
    remaining = R.size();
    for (Rocket r : R)  if (r.alive==false)  remaining--;
    //println("remaining; " + remaining);
  }

  void evaluate(ArrayList<Rocket> R) {
    succesful = 0;
    maxFitness = -1;
    minFrames = lifespan;
    for (Rocket r : R) {
      float d = dist(target.loc.x, target.loc.y, r.pos.x, r.pos.y);
      d = d - target.radius;
      if (mode) r.fitness = r.count/(d*d);
      if (!mode) r.fitness = 1/(r.count*r.count*d*d);
      if (r.reachedGoal)  r.fitness += 1;
      if (r.reachedGoal)  succesful += 1;
      if (r.fitness > maxFitness)  maxFitness = r.fitness;
      if (r.reachedGoal && r.count < minFrames)  minFrames = r.count;
    }    
    println("maxFitness: " + maxFitness);
    for (Rocket r : rockets) {
      //normallized fitness scores to between 0 and 1
      r.fitness = r.fitness/maxFitness;
    }
  }

  ArrayList<Rocket> createMatingPool(int N) {
    ArrayList<Rocket> temp = new ArrayList<Rocket>();
    for (Rocket r : rockets) {
      //if (r.fitness > threshold) {
        for (int i=0; i<ceil(r.fitness*N); i++) {
          temp.add(r);
        }
      //}
    }
    println("mating pool size: " + temp.size());
    return temp;
  }

  void firstGen(int N, int T) {
    for (int i=0; i<N; i++) {
      DNA dna = new DNA(T);
      Rocket r = new Rocket(dna) ;
      r.pos.set(launchPoint.copy());
      rockets.add(r);
    }
  }

  void nextGen(int N) {
    matingPool = createMatingPool(N);
    rockets = new ArrayList<Rocket>();
    //for (int i=0; i<N; i++) {
    while (rockets.size() < N) {
      int randA = int(random(0, 1) * matingPool.size());
      int randB = int(random(0, 1) * matingPool.size());
      DNA dna = new DNA(matingPool.get(0).dna.telo);
      print("<" + randA + "," + randB + ">  :");
      dna.crossover(matingPool.get(randA).dna, matingPool.get(randB).dna);
      dna.mutate();
      Rocket r = new Rocket(dna);
      r.alive = true;
      r.pos.set(launchPoint.copy());
      if (checkDuplicate(r, rockets)==false)  rockets.add(r);
    }
  }

  boolean checkDuplicate(Rocket R, ArrayList<Rocket> L) {
    boolean cond = false;
    for (Rocket r : L) {
      float diff = 0;
      for (int i=0; i<R.dna.genes.length; i++) {
        diff = abs(R.dna.genes[i].x-r.dna.genes[i].x) + abs(R.dna.genes[i].y-r.dna.genes[i].y);
      }
      if (diff==0) {
        println("discarding");
        cond = true;
        return cond;
      }
    }
    return cond;
  }

  void keyReleased() {
    if (key == ' ')  mode = !mode;
  }
}
