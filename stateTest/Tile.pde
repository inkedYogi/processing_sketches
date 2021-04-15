class Tile {
  float x, y, w, h;
  String type;
  
  Tile[] nbrs;  //N, E, S, W
  int[] walls;  

  Tile(float X, float Y, float  W, float  H) {
    x = X; 
    y = Y;
    w = W;
    h = H;
    type = "";
    nbrs = new Tile[4];
    walls = new int[4];
    for (int i=0; i<walls.length; i++) {
      walls[i] = 0;
      //if (random(0,1) > .5)  walls[i] = 1;
    }
  }

  void disp() {
    rectMode(CENTER);
    fill(255);
    noStroke();
    rect(x, y, w, h);
  }
  
  void dispWalls() {
    stroke(0);
    strokeWeight(3);
    if (walls[0]==0)  line(x-w/2, y-h/2, x+w/2, y-h/2);
    if (walls[1]==0)  line(x+w/2, y-h/2, x+w/2, y+h/2);
    if (walls[2]==0)  line(x+w/2, y+h/2, x-w/2, y+h/2);
    if (walls[3]==0)  line(x-w/2, y+h/2, x-w/2, y-h/2);
  }
  
  void dispState() {
    textAlign(CENTER);
    fill(0);
    textSize(16);
    text(type,x-1,y+6);
  }
  
  void agree() {
    if (nbrs[0] != null)  walls[0] = nbrs[0].walls[2];
    else walls[0] = 0;
    if (nbrs[1] != null)  walls[1] = nbrs[1].walls[3];
    else walls[1] = 0;
    if (nbrs[2] != null)  walls[2] = nbrs[2].walls[0];
    else walls[2] = 0;
    if (nbrs[3] != null)  walls[3] = nbrs[3].walls[1];
    else walls[3] = 0;
  }
  
  void hood(Tile N, Tile E, Tile S, Tile W){
    nbrs[0] = N;
    nbrs[1] = E;
    nbrs[2] = S;
    nbrs[3] = W;
  }
}
