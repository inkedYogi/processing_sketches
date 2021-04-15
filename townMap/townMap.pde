import processing.sound.*;
//SoundFile[] music;
int musicIndex;
int time, gap;

PVector begin, momentum;
ArrayList<Road> roads;
float step;

void setup() {
  size(800, 800);
  begin = new PVector(width/2, height*6/8);
  momentum = PVector.random2D();
  step = 6; 
  //music = new SoundFile[1];
  //music[0] = new SoundFile(this, "Cascades.mp3");
  momentum.setMag(step);
  roads = new ArrayList<Road>();
  roads.add(new Road(begin));
  //music[0].amp(0.6);
  //music[0].play();
  time = millis();
}

void draw() {  
  background(255/2);
  int cue = floor((millis()-time)*.01);
  if (cue==200)  step = 4;
  if (cue==400)  step = 5;
  if (cue==500)  step = 6;
  if (roads.get(roads.size()-1).finite==false) {
    momentum.add(PVector.random2D().setMag(2));
    momentum.setMag(step);
    roads.get(roads.size()-1).grow(momentum, roads);
  } else {
    if (roads.get(roads.size()-1).path.size() < 250/step && roads.size()>1)  roads.remove(roads.get(roads.size()-1));
    //Road r = roads.get(0).findLongest(roads);
    Road r = roads.get((int)random(0, roads.size()-1));
    boolean valid = false;
    PVector start = new PVector(0, 0);
    while (!valid) {
      int roll = (int)random(0, r.path.size());
      if (roll>0 && roll<r.path.size()-1) {
        valid=true;
        start = r.path.get(roll);
      }
    }
    if (valid) {
      for (Road a : roads) {
        a.cleanup();
      }
      roads.add(new Road(start));
    }
  }
  for (Road a : roads) {
    a.disp();
  }
  if (cue==1000) {
    saveFrame("thumb.png");
    noLoop();
  }
}

void keyReleased() {
  println(floor((millis()-time)*.01));
}
