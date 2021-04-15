class Ruin extends Blip {
  int explorersVisited;
  ArrayList<Unit> visited;
  int relicsFound;

  Ruin() {
  }

  Ruin(Player P) {
    pos = new PVector(random(width*6/8)+width/8, random(height*6/8)+height/8);    //superclass
    name = "default_ruin_name";
    type = "Ruin";
    controllingPlayer = P;
    P.controlled.ruins.add(this);
    info = new Panel(pos, name, new String[0],"info");
  }

  void sprite() {
    stroke(0);
    if (controllingPlayer==null) fill(0);
    else fill(controllingPlayer.factionColor);
    triangle(-7, 0, 0, -12, 7, 0);
  }

  void fillInfo() {
    String[] infill = new String[2];
    infill[0] = "explorers visited: " + explorersVisited;
    infill[1] = "relicsFound: " + relicsFound;
    info.title = name;
    info.body = infill;
    info.setDims();
  }
  
}