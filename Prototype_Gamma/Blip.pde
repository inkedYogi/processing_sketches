class Blip {
  String name;
  PVector pos;
  Player controllingPlayer;
  String type;
  String alignment;
  String parentCity;
  String foundingRace;
  String magicP;
  String gov;
  String desc;
  boolean mousedOver;
  Panel info;
  boolean infoDisp;


  Blip() {
  }

  Blip (Player P) {
    controllingPlayer = P;
  }

  Blip (Player P, float x, float y) {
    controllingPlayer = P; 
    pos = new PVector(x, y);
  }

  void disp() {
    push();
    translate(pos.x, pos.y);
    sprite();
    pop();
  }

  void sprite() {
    noStroke();
    if (controllingPlayer==null) fill(0);
    else fill(controllingPlayer.factionColor);
    ellipse(0, 0, 15, 15);
  }

  void setFaction(int f) { 
    controllingPlayer = controllingPlayer.currentGame.players[f];
  }

  void mouseMoved() {
    if (dist(mouseX, mouseY, pos.x, pos.y) < 10)  mousedOver = true;
    else  mousedOver = false;
  }

  void mouseClicked() {
    if (mousedOver) {
      controllingPlayer.infoPanels.add(info);
    }
  }
}