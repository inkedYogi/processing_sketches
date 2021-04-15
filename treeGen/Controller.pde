class Controller {
  Tree tree;

  Node nodeUnder;

  Controller(Tree T) {
    tree = T;
  }

  void keyPressed() {
    //IN.keyPressed();
  }

  void keyReleased() {
    switch (key) {
    }
  }

  void mouseMoved() {
    for (Node n : tree.nodes) {
      float d = dist(mouseX-width/2, mouseY-100, n.pos.x, n.pos.y);
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

  void mousePressed() {
    //IN.mousePressed();
  }

  void mouseReleased() {
    //IN.mouseReleased();
    if (nodeUnder==null) {
    } else {
      if (mouseButton == LEFT) {
        Node g = new Node(tree.nodes.size()); 
        g.pos.add(new PVector(0, 50));
        g.pos.add(nodeUnder.pos);
        tree.grow(nodeUnder, g);
      }
      if (mouseButton == RIGHT) {
        Node g =  new Node(tree.nodes.size());
        g.pos.add(new PVector(-25, 50));
        g.pos.add(nodeUnder.pos);
        Node h =  new Node(tree.nodes.size()+1);
        h.pos.add(new PVector(25, 50));
        h.pos.add(nodeUnder.pos);
        tree.grow(nodeUnder, g, h);
      }
    }
  }
}
