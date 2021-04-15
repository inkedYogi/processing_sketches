class Tree {
  ArrayList<Branch> branches;
  ArrayList<Leaf> leaves;

  Tree() {
    reset();
  }

  boolean closeEnough(Branch b) {

    for (Leaf l : leaves) {
      float d = PVector.dist(b.pos, l.pos);
      if (d < max_dist) {
        return true;
      }
    }
    return false;
  }

  void grow() {
    for (Leaf l : leaves) {
      Branch closest = null;
      PVector closestDir = null;
      float record = -1;

      for (Branch b : branches) {
        PVector dir = PVector.sub(l.pos, b.pos);
        float d = dir.mag();
        if (d < min_dist) {
          l.reached();
          closest = null;
          break;
        } else if (d > max_dist) {

        } else if (closest == null || d < record) {
          closest = b;
          closestDir = dir;
          record = d;
        }
      }
      if (closest != null) {
        closest.dir.normalize();
        closest.dir.add(closestDir);
        closest.count++;
      }
    }

    for (int i = leaves.size()-1; i >= 0; i--) {
      if (leaves.get(i).reached) {
        leaves.remove(i);
      }
    }

    for (int i = branches.size()-1; i >= 0; i--) {
      Branch b = branches.get(i);
      if (b.count > 0) {
        b.dir.div(b.count);
        b.dir.normalize();
        Branch newB = new Branch(b);
        branches.add(newB);
        b.reset();
      }
    }
  }

  void disp() {
    for (Leaf l : leaves)  l.disp();
    int i = 0;
    for (Branch b : branches) {
      if (b.parent != null) {
        stroke(255);
        strokeWeight(map(i, 0, branches.size(), lineWeight, 0));
        line(b.pos.x, b.pos.y, b.parent.pos.x, b.parent.pos.y);
      }
      i++;
    }
  }
  
  void reset(){
    branches = new ArrayList<Branch>();
    leaves = new ArrayList<Leaf>();
    Branch root = new Branch(new PVector(width/2, height), new PVector(0, -1));
    branches.add(root);
    //Branch current = new Branch(root);
  }
}
