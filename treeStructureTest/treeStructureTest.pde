int leavesCount = 10000;
float pointSize = 10;
float lineWeight = 4;
float max_dist = 100;
float min_dist = 10;
float b_size = 100/2;


Tree tree;

void setup(){
  //fullScreen();
  size(1000,1000);
  tree = new Tree();
  
}

void draw(){
  background(0);
  strokeWeight(lineWeight);
  if(mousePressed){
    PVector pos = new PVector(random(mouseX-b_size, mouseX+b_size), random(mouseY-b_size, mouseY+b_size));
    tree.leaves.add(new Leaf(pos));
  }
  tree.disp();
  tree.grow();
}

void keyPressed(){
  if(key=='r'){
    tree.reset();
  }
}
