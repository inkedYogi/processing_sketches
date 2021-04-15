float speed;
float turning;
float strength;
float armor;

PVector pos;
PVector panel;

Slider slider;


void setup() {
  size(600, 600);
  pos = new PVector(width/2, height/2);
  //translate(width/2, height/2);
  background(0);
  ship(10.0, 90.0, 120.0, 150.0);

  panel = new PVector(width/2-100, height*8/9);
  slider = new Slider(panel, 10, 20, 15);
}

void draw() {
  background(0);
  ship(slider.value, 90.0, 120.0, 150.0);
  slider.disp();
}




void ship(float speed, float turning, float strength, float armor) {
  pushMatrix();
  pushStyle();

  stroke(175, 175, 175);
  strokeWeight(4);
  //port leading tether
  line(0, pos.y+strength/2, width, pos.y+strength/2);
  line(pos.x-turning, pos.y + strength/2, pos.x, pos.y-strength/2);
  //starboard leading tether
  line(pos.x+turning, pos.y + strength/2, pos.x, pos.y-strength/2);
  //port trailing tether
  line(pos.x-turning, pos.y + strength/2+6*speed/2-5, pos.x, 316.0);
  //starboard trailing tether  
  line(pos.x+turning, pos.y + strength/2+6*speed/2-5, pos.x, 316.0);

  fill(165, 165, 165);
  noStroke();
  //body;
  ellipse(pos.x, pos.y, turning, strength);
  fill(195, 195, 195);
  //saucer
  ellipse(pos.x, pos.y - strength, 2*strength, armor);

  fill(215, 215, 215);
  //starboard nacell
  ellipse(pos.x-turning, pos.y + strength/2, speed, 6*speed);  
  //port nacell
  ellipse(pos.x+turning, pos.y + strength/2, speed, 6*speed);

  fill(235, 235, 235);
  //center nacell
  //ellipse(pos.x, pos.y+(strength/2), speed/2, 7*speed);






  popStyle();
  popMatrix();
}

void mousePressed() {
   slider.mousePressed(); 
}

void mouseDragged(){
    slider.mouseDragged();
  }
  
  void mouseReleased() {
    slider.mouseReleased();
  }