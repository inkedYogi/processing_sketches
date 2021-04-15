class Node {
  int id;
  PVector pos, dim;
  color nodeCol, antiNodeCol, textCol, antiTextCol;
  boolean mousedOver;
  int generation;
  
  Node() {
    pos = new PVector(0, 0);
    dim = new PVector(20, 20);
    nodeCol = color(255, 255, 255);
    antiNodeCol = color(0, 0, 0);
    textCol = color(0, 0, 0);
    antiTextCol = color(255, 255, 255);
    mousedOver = false;
    generation = 0;
  }

  boolean eq(Node T) {
    if (T.id == this.id)
      return true;
    return false;
  }
  
  void disp() {
    push();
    translate(pos.x, pos.y);
    strokeWeight(2);
    stroke(antiNodeCol);
    fill(nodeCol);
    rect(0, 0, dim.x, dim.y);
    //circle(0,0,10);
    fill(textCol);    
    text(id, 0, 5);
    //text(generation, 0, 5);
    pop();
  }
}
