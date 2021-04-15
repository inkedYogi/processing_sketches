class Unit {
  String name;
  PVector address;
  PVector pos;
  Map local;
  int currentRoom;
  Tree quest;

  Unit(String N, Map L) {
    name = N;
    local = L;
    address = new PVector(0, 0);
    pos = new PVector(0, 0);
  }

  void update() {
    pos.x = address.x*(local.dims.x+5)+local.base.x;
    pos.y = address.y*(local.dims.y+5)+local.base.y;
    currentRoom = local.rooms[(int)address.x][(int)address.y];
    checkQuest();
  }

  void disp() {
    update();
    push();
    fill(0, 255*sin(frameCount%1000*.125));
    noStroke();
    translate(pos.x, pos.y);
    rect(0, 0, local.dims.x, local.dims.y);
    pop();
  }

  void newQuest(Tree T) {    
    quest = T.copy();
  }

  void checkQuest() {
    Node found = null;
    for (Node n : quest.leafs)  if (n.id == currentRoom) {
     //quest completed
     println("room found: " + currentRoom);
     found = n;
    }
    if (found != null)  quest.popNode(found);
  }

  void keyReleased() {
    switch(key) {
    case 'w':
      if (address.y > 0)  address.y += -1.0;
      break;
    case 's':
      if (address.y < local.sq-1)  address.y += 1.0;
      break;
    case 'a':
      if (address.x > 0)  address.x += -1.0;
      break;
    case 'd':
      if (address.x < local.sq-1)  address.x += 1.0;
      break;
    }
    update();
  }
}
