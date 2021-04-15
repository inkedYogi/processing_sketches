Controller IN;
Tree tree;

void setup() {
  size(600, 600);
  tree = new Tree();
  IN = new Controller(tree);
}

void draw() {
  background(255/2);
  translate(width/2, 100);
  tree.update();
  tree.disp();
}

void keyPressed() {
  IN.keyPressed();
}

void keyReleased() {
  IN.keyReleased();
}

void mouseMoved() {
  IN.mouseMoved();
}

void mousePressed() {
  IN.mousePressed();
}

void mouseReleased() {
  IN.mouseReleased();
}
