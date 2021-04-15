Arena A;
Population P;
PVector launchPoint;

void setup() {
  size(1200, 820);
  launchPoint = new PVector(0,0);
  P = new Population(100, 250, 500);
  A = new Arena(800, 800, P);
  P.target = new Target(A.wide*random(0,1)-A.wide/2,A.high*random(0,1)-A.high/2, 10);
  A.createObs(5);
}

void draw() {
  A.update();
  A.disp();
}

void keyReleased() {
 P.keyReleased(); 
}
