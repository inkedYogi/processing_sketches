class Unit {
  String name;
  //float imgWid, imgHei;
  String[] abilities, helpText;
  int baseAttack, baseDefense, attackMod, defenseMod;
  PVector anchor, dims;
  Player controllingPlayer;
  boolean mousedOver;
  Card cardBase;

  Unit(String f, int p, int t, String[] a, String[] h) {    //name, attack, defense, ability list, helptext list
    name = f;
    baseAttack = p;
    baseDefense = t;
    attackMod = 0;
    defenseMod = 0;
    dims = new PVector(15, 15);
    mousedOver = false;
  }

  void disp() {
    push();
    noStroke();
    strokeWeight(1);
    if (mousedOver) stroke(0);
    fill(controllingPlayer.unitColor);
    ellipse(anchor.x, anchor.y, dims.x, dims.y);
    pop();
  }

  void mouseMoved() {
    if (dist(mouseX, mouseY, anchor.x, anchor.y) < dims.x) {
      mousedOver = true;
    } else {
      mousedOver = false; 
    }
  }

  void mouseClicked() {
    //do something depending on the context
  }

  Unit copy() {
    return new Unit(name, baseAttack, baseDefense, abilities, helpText);
  }
}