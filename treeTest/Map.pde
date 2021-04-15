class Map {
  int[][] rooms;
  int sq ;

  PVector base;
  PVector dims;

  Map(int N) {
    sq = N;
    rooms = new int[sq][sq]; 
    base = new PVector(width/2, 100);
    dims = new PVector(25, 25);
    for (int i=0; i<sq; i++) {
      for (int j=0; j<sq; j++) {
        rooms[i][j] = -1;
      }
    }
  }

  void disp() {
    push();
    translate(base.x, base.y);
    for (int i=0; i<sq; i++) {
      for (int j=0; j<sq; j++) {
        push();
        translate(i*(dims.x+5), j*(dims.y+5));
        strokeWeight(2);
        stroke(0);
        fill(255);
        rectMode(CENTER);
        rect(0, 0, dims.x, dims.y);
        fill(0);    
        textAlign(CENTER);
        if (rooms[i][j] >= 0)  text(rooms[i][j], 0, 5);
        //text(generation, 0, 5);
        pop();
      }
    }
    pop();
  }

  void populate(Tree T) {
    int index = 0;
    while (index < T.nodes.size()) {
      int x = (int)random(0, sq);
      int y = (int)random(0, sq);
      if (rooms[x][y] != -1) {
      } else {
        rooms[x][y] = T.nodes.get(index).id;
        index++;
      }
    }
  }
}
