class DNA {
  PVector[] genes;
  int telo;

  DNA(int T) {
    telo = T;
    genes = new PVector[telo];
    for (int i=0; i<telo; i++)  genes[i] = PVector.random2D().mult(.25);
  }
  
  void crossover(DNA A, DNA B) {
    int crossPoint = round(telo * random(0,1));
    print(crossPoint+" ");
    for (int i=0; i<telo; i++) {
       if (i < crossPoint)  genes[i] = A.genes[i].copy();
       if (i >= crossPoint)  genes[i] = B.genes[i].copy();
    }
  }
  
  void mutate() {
   if (random(0,1) < .005) {
    genes[floor(telo * random(0,1))] = PVector.random2D(); 
   }
  }
}
