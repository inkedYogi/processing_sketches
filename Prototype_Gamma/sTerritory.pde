class Territory {
  PVector com ;                       //center of mass
  PVector address;
  float[] x, y;
  float size;
  //int[] type;
  ArrayList<Territory> neighbors;
  ArrayList<Card> graveyard;
  Census within;
  boolean mousedOver, selected;
  PShape hex;
  String status, type;                      //{wild, occupied, controlled}
  Handler handler;
  Panel terrainInfo;

  Territory(float ex, float why, float sighs, Handler H) {    //Territory(x,y,r,handler);
    address = new PVector(0, 0);
    neighbors = new ArrayList<Territory>();
    within = new Census();
    status = "undefined";
    com = new PVector(ex, why);
    size = sighs;
    type = "territory";
    x = new float[7];
    y = new float[7];
    for (int i=1; i<x.length; i++) {
      x[i] = com.x + size * cos(PI/3 * i);
      y[i] = com.y + size * sin(PI/3 * i);
    }    
    resetBoarders(x, y);
    graveyard = new ArrayList<Card>();
    mousedOver = false;
    selected = false;
    handler = H;
  }

  void disp() {
    push();
    textAlign(CENTER);
    shape(hex, 0, 0);
    //text((int)address.x + "," + (int)address.y, com.x, com.y+5);
    if (mousedOver) {
      push();
      strokeWeight(3);
      stroke(0);
      for (int i=1; i<6; i++) {
        line(x[i], y[i], x[i+1], y[i+1]);
      }
      line(x[6], y[6], x[1], y[1]);
      pop();
    }
    if (selected) {
      push();
      strokeWeight(4);
      stroke(255,200);
      for (int i=1; i<6; i++) {
        line(x[i], y[i], x[i+1], y[i+1]);
      }
      line(x[6], y[6], x[1], y[1]);
      terrainInfo.disp();
      pop();
    }
    within.disp();
    pop();
  }

  void resetBoarders(float[] x, float[] y) {
    hex = createShape();
    hex.beginShape();
    hex.stroke(0, 50);
    hex.noFill();
    for (int i=1; i<x.length; i++) {
      hex.vertex(x[i], y[i]);
    }
    hex.vertex(x[1], y[1]);
    hex.endShape();
    setTypes();
  }
  
  void fillInfo() {
    //  Panel(PVector L, String T, String[] B, String C) {  //Location, Title, Body, Content Type
    PVector L = com.copy();
    //L.sub(new PVector(width/2, height/2));
    String T = (int)address.x + "," + (int)address.y;
    String[] B = within.toStringArray();
    String C = "info";
   terrainInfo = new Panel(L, T, B, C); 
   terrainInfo.pos.add(new PVector(-terrainInfo.dim.x/2,size));
  }

  void setTypes() {
    //set the edge types based on map data
  }

  void mouseMoved() {
    //println(com.x + ", " + mouseX);
    if (dist(com.x, com.y, mouseX, mouseY) < (size * sqrt(3)/2)) {
      this.mousedOver = true;
      //print("me: " + address.x + "," + address.y);
    } else {
      this.mousedOver = false;
    }
    within.mouseMoved();
  }

  void mouseClicked() {
    if (mousedOver) {
      println((int)address.x + ", " + (int)address.y);
      selected = true;
      fillInfo();
      if (handler.makeSelection) {
        if (handler.selectedTerrain != null)  handler.selectedTerrain.selected = false;
        handler.selectedTerrain = this;
      }
    } else {
      selected = false; 
    }
  }
}