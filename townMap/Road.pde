class Road {
  ArrayList<PVector> path;
  ArrayList<PVector> inter;
  ArrayList<Structure> houses;
  boolean finite;


  Road(PVector B) {
    path = new ArrayList<PVector>();
    inter = new ArrayList<PVector>();
    houses = new ArrayList<Structure>();
    path.add(B.copy());
    //inter.add(B.copy());
    finite = false;
  }

  void grow(PVector M, ArrayList<Road> R) {
    PVector pathStep = path.get(path.size()-1).copy();
    if (path.size()==1)  inter.add( new PVector(pathStep.x, pathStep.y) );
    PVector toCenter = new PVector(width/2 - pathStep.x, height/2 - pathStep.y);
    toCenter.mult(-.005);
    pathStep.add(toCenter);
    pathStep.add(M);
    boolean near = false;
    int rindex = -1;
    int index = -1;
    float d = 0;
    for (int j=0; j<R.size(); j++) {
      Road r = R.get(j);
      for (int i=0; i<r.path.size(); i++) {
        PVector p = r.path.get(i);
        d = dist(pathStep.x, pathStep.y, p.x, p.y);
        if (d < step-1) { 
          near = true;
          rindex = j;
          index = i;
        }
        //for (Road A : R) {
        //  for (Structure h : A.houses) {
        //    if (h.inside(pathStep)) { 
        //      near = true; 
        //      rindex = j;
        //      index = i;
        //    }
        //  }
        //}
      }
    }
    if (near==false) { 
      path.add(pathStep);
      PVector addition = pathStep.copy();
      addition.add(M.copy().rotate(PI/4).mult(random(1, 3)));
      if ((int)random(-300, 100) > path.size())  houses.add(new Structure(addition, M.copy()));
      addition = pathStep.copy();
      addition.add(M.copy().rotate(-PI/4).mult(random(1, 3)));
      if ((int)random(-300, 100) > path.size())  houses.add(new Structure(addition, M.copy().rotate(PI)));
    } else {
      finite = true;
      path.add(pathStep);
      inter.add( new PVector( .5*(pathStep.x+R.get(rindex).path.get(index).x), .5*(pathStep.y+R.get(rindex).path.get(index).y) ) );   
      //println(inter);
      return ;
    }
    if (pathStep.x > width || pathStep.x < 0) {
      finite = true;
      return ;
    }
    if (pathStep.y > height || pathStep.y < 0) {
      finite = true;
      return ;
    }
  }

  void cleanup() {
    for (int k=0; k<roads.size()-1; k++) {
      for (int j=0; j<roads.get(k).path.size()-1; j++) {
        for (int i=houses.size()-1; i>=0; i--) {
          if (houses.get(i).inside(roads.get(k).path.get(j)))  houses.remove(i);
        }
      }
    }
  }

  void disp() {
    strokeWeight(3);
    fill(0);
    if (finite)  stroke(0);
    else stroke(255);
    for (int i=0; i<path.size()-1; i++)  line(path.get(i).x, path.get(i).y, path.get(i+1).x, path.get(i+1).y);
    if (path.size()>1)  line(path.get(path.size()-2).x, path.get(path.size()-2).y, path.get(path.size()-1).x, path.get(path.size()-1).y);
    noStroke();
    for (int i=0; i<inter.size(); i++)  ellipse(inter.get(i).x, inter.get(i).y, 12, 12);
    for (Structure h : houses)  h.disp();
  }

  Road findLongest(ArrayList<Road> R) {
    int longest = 0;
    int index = -1;
    for (int i=0; i<R.size(); i++) {
      if (R.get(i).path.size() > longest) {
        longest = R.get(i).path.size();
        index = i;
        //println(R.get(i).path.size());
      }
    }
    //println(R.get(index).path.size());
    return R.get(index);
  }
}
