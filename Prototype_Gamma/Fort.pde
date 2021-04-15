class Fort extends Blip {
  int unitsGarrisoned;
  ArrayList<Unit> garrisoned;
  float strength;
  
  Fort(Player P) {
    pos = new PVector(random(width*6/8)+width/8, random(height*6/8)+height/8);    //superclass
    name = "default_fort_name";
    type = "Fort";
    controllingPlayer = P;
    P.controlled.forts.add(this);
    unitsGarrisoned = 0;
    strength = 0;
    garrisoned = new ArrayList<Unit>();
    info = new Panel(pos, name, new String[0],"info");
  }
  
  void disp() {
    super.disp();
    push();
    translate(pos.x, pos.y);
    sprite();
    //readouts();
    pop();
  }
  
  void sprite() {
     stroke(0);
     if (controllingPlayer==null) fill(0);
     else fill(controllingPlayer.factionColor);
     rect(0,0,12,12);
  }
  
  void fillInfo() {
     String[] infill = new String[2];
     infill[0] = "units garrisoned: " + unitsGarrisoned;
     infill[1] = "strength: " + round(strength);
     info.title = name;
     info.body = infill;
     info.setDims();
  }
  
}