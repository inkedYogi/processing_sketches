class Tree extends Blip { 
  int level;
  int magesStudying;
  ArrayList<Unit> studying;

  Tree() {
  }

  Tree(Player P) {
    pos = new PVector(random(width*6/8)+width/8, random(height*6/8)+height/8);    //superclass
    name = "default_tree_name";
    type = "Tree";
    controllingPlayer = P;
    P.controlled.trees.add(this);
    level = 1;
    info = new Panel(pos, name, new String[0],"info");
  }

  void disp() {
    super.disp();
  }

  void sprite() {
    stroke(0);
    if (controllingPlayer==null) fill(0);
    else fill(controllingPlayer.factionColor);
    triangle(-7, -12, 0, 0, 7, -12);
  }

  void fillInfo() {
    String[] infill = new String[2];
    infill[0] = "mages studying: " + magesStudying;
    infill[1] = "magic level: " + level;
    info.title = name;
    info.body = infill;
    info.setDims();
  }
  
}