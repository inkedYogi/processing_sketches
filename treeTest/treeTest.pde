Tree tree;
Map map;
Node nodeUnder;
boolean ready;
int total;
float sep;
Unit player;

void setup() {
  size(800, 500);
    rectMode(CENTER);
    textAlign(CENTER);
  tree = new Tree();
  total = 24;
  tree.maxGen = 9;
  sep = 50;
  map = new Map(ceil(sqrt(2*total)));
  player = new Unit("Player", map);
  player.newQuest(tree);
  ready = false;
}

void draw() {
  if (frameCount % 1 == 0) {
    if (tree.nodes.size() < total) { 
      growTree();
    } else {
      if (!ready) {
        println("stopped");  
        tree.tree2Mat();
        map.populate(tree);
        player.newQuest(tree);
        ready = true;
      }
      //map.disp();
      //tree.disp();
      //noLoop();
    }
    if (!ready)  tree.disp();
    else  player.quest.disp();
    map.disp();
    player.disp();
  }
}

void growTree() {
  int index = (int)random(0, tree.nodes.size());
  if (random(0, 1) < .75) {
    Node g = new Node(); 
    g.pos.add(new PVector(0, sep));
    g.pos.add(tree.nodes.get(index).pos);
    tree.addSingle(tree.nodes.get(index), g);
  } else {
    Node g =  new Node();
    g.pos.add(new PVector(-sep, sep));
    g.pos.add(tree.nodes.get(index).pos);
    Node h =  new Node();
    h.pos.add(new PVector(sep, sep));
    h.pos.add(tree.nodes.get(index).pos);
    tree.addDouble(tree.nodes.get(index), g, h);
  }
  println("leaf nodes: " + tree.leafs.size());
}

void keyReleased() {
  player.keyReleased();
}

void mouseMoved() {
  for (Node n : tree.nodes) {
    float d = dist(mouseX, mouseY, n.pos.x, n.pos.y);
    if (d < n.dim.x) { 
      n.mousedOver = true;
      nodeUnder = n;
      break;
    } else {
      n.mousedOver = false;
      nodeUnder = null;
    }
  }
}

void mouseReleased() {
  if (nodeUnder==null) {
  } else {
    if (mouseButton == LEFT) {
      Node g = new Node(); 
      g.pos.add(new PVector(0, 50));
      g.pos.add(nodeUnder.pos);
      tree.addSingle(nodeUnder, g);
    }
    if (mouseButton == RIGHT) {
      Node g =  new Node();
      g.pos.add(new PVector(-25, 50));
      g.pos.add(nodeUnder.pos);
      Node h =  new Node();
      h.pos.add(new PVector(25, 50));
      h.pos.add(nodeUnder.pos);
      tree.addDouble(nodeUnder, g, h);
    }
  }
}
