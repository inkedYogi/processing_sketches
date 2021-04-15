class Explorer {
  Tile current;
  int facing;                        //0:Up 1:Right 2:Down 3:Left

  ArrayList<Tile> explored;
  ArrayList<Tile> frontier;
  Level parent;

  boolean dig;

  Explorer(Level L) {
    parent = L;
    current = L.grid[0][0];
    facing = 0;
    frontier = new ArrayList<Tile>();
    explored = new ArrayList<Tile>();
    check(current);
    dig = false;
  }

  void disp() {
    float x = current.x;
    float y = current.y;
    float w = current.w;
    float h = current.h;
    fill(0, 0, 200, 100);
    if (dig)  fill(200, 0, 0, 100);
    strokeWeight(2);
    ellipse(x, y, min(w, h)/3, min(w, h)/3);
    for (int i=0; i<parent.cols; i++)  for (int j=0; j<parent.rows; j++) {
      if (!explored.contains(parent.grid[i][j])) {
        if (frontier.contains(parent.grid[i][j]))  fill(0, 100);
        else  fill(0, 200); 
        noStroke();
        rect(parent.grid[i][j].x, parent.grid[i][j].y, parent.grid[i][j].w, parent.grid[i][j].h);
      }
    }
  }

  void check(Tile T) {
    if (!explored.contains(T)) { 
      explored.add(T);
      if (frontier.contains(T))  frontier.remove(T);
      for (int i=0; i<T.nbrs.length; i++) {
        if (T.walls[i] > 0) {
          if (T.nbrs[i] != null) {
            if (!explored.contains(T.nbrs[i])) {
              if (!frontier.contains(T.nbrs[i])) {
                frontier.add(T.nbrs[i]);
              }
            }
          }
        }
      }
    }
    print("E: " + explored.size() + " ");
    println("F: " + frontier.size());
    if (frontier.size()==0)  dig = true; 
    else  dig = false;
  }

  void move(int D) {       //note walls[i] will be 0 if there is an impassible wall between the cells
    if (D == facing) {
      if (current.walls[facing] > 0)  current = current.nbrs[facing];
      switch(D) {
      case 0:
        //if (current.walls[0] > 0)  current = current.nbrs[0];
         if (dig && !explored.contains(current.nbrs[0])) {
          current = current.nbrs[0];
          parent.deleteWall(current, 2);
        }
        break;
      case 1: 
        //if (current.walls[1] > 0)  current = current.nbrs[1];
        if (dig && !explored.contains(current.nbrs[1])) {
          current = current.nbrs[1];
          parent.deleteWall(current, 3);
        }

        break;
      case 2:
        //if (current.walls[2] > 0)  current = current.nbrs[2];
        if (dig  && !explored.contains(current.nbrs[2])) { 
          current = current.nbrs[2];
          parent.deleteWall(current, 0);
        }
        break;
      case 3:
        //if (current.walls[3] > 0)  current = current.nbrs[3];
        if (dig && !explored.contains(current.nbrs[3])) {
          current = current.nbrs[3];
          parent.deleteWall(current, 1);
        }
        break;
      }
    }
    facing = D;
    check(current);
  }
}
