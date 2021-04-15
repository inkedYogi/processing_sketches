class Level {
  Tile[][] grid;
  int cols, rows;

  Level(int N) {
    cols = N;
    rows = N;
    grid = new Tile[cols][rows];
    init();
  }

  void init() {
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++) {
      grid[i][j] = new Tile(i*50, j*50, 50, 50);
    }
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++) {
      Tile N, E, S, W;
      if (j==0)  N=null;
      else  N = grid[i][j-1];
      if (i==cols-1)  E=null;
      else  E = grid[i+1][j];
      if (j==rows-1)  S=null;
      else S = grid[i][j+1];
      if (i==0)  W=null;
      else  W = grid[i-1][j];
      grid[i][j].hood(N, E, S, W);
    }
    grid[0][0].type = "S";
    if (grid[0][0].walls[1]==0 && grid[0][0].walls[2]==0) {
      if (random(0, 1) > .5)  deleteWall(grid[0][0], 1);
      else  deleteWall(grid[0][0], 2);
    }
    if (grid[cols-1][rows-1].walls[0]==0 && grid[cols-1][rows-1].walls[3]==0) {
      if (random(0, 1) > .5)   deleteWall(grid[cols-1][rows-1], 0);
      else  deleteWall(grid[cols-1][rows-1], 3);
    }
    grid[cols-1][rows-1].type = "E";
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++) {
      grid[i][j].agree();
    }
  }

  void disp() {
    translate(width/2, height/2);
    translate(-50*floor(cols/2), -50*floor(rows/2));
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++) {
      grid[i][j].disp();
    }
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++) {
      grid[i][j].dispWalls();
    }
    for (int i=0; i<cols; i++)  for (int j=0; j<rows; j++) {
      grid[i][j].dispState();
    }
  }

  void deleteWall(Tile T, int D) {
      T.walls[D] = 1;
      T.nbrs[D].agree();
    }
}
