import processing.sound.*;

PFont lgFont, smFont;
Game game;
SoundFile[] music;
int musicIndex;

void setup() {
  size(1200, 1024);
  //fullScreen();
  background(0);
  music = new SoundFile[8];
  music[0] = new SoundFile(this, "music/wasteland.wav");
  music[1] = new SoundFile(this, "music/wilderness.wav");
  music[2] = new SoundFile(this, "music/lost.wav");
  music[3] = new SoundFile(this, "music/maybe next time.wav");
  music[4] = new SoundFile(this, "music/meadow gazing.wav");
  music[5] = new SoundFile(this, "music/safe in the castle.wav");
  music[6] = new SoundFile(this, "music/thanks for playing.wav");
  music[7] = new SoundFile(this, "music/we did it.wav");

  game = new Game(1); //number of players
  lgFont = createFont("Arial-Black", 24);
  smFont = createFont("Arial-Black", 12);
  //musicIndex = (int)random(0, music.length);
  musicIndex = 4;  //starting music = meadow gazing
  music[musicIndex].amp(0.2);
  music[musicIndex].play();
  println("starting");
}

void draw() {
  if (frameCount%100==0)  println((1000 - frameCount%1000)/100);
  if (frameCount%1000==0) {
    println("swoop!");
    //music[musicIndex].stop();
    musicIndex++;
    if (musicIndex==music.length)  musicIndex=0;
    //musicIndex = (int)random(0,music.length);
    //musicIndex = (musicIndex % (music.length-1))+1;
    println(musicIndex);
    music[musicIndex].amp(0.2);
    music[musicIndex].play();
  }
  background(255);
  game.disp();
}

void push() {
  pushMatrix();
  pushStyle();
}

void pop() {
  popStyle();
  popMatrix();
}

int frequency(float p1, float p2, float p3, float p4) {
  //%chance = p1, (p2-p1), (p3-p2-p1),(p4-p3-p2-p1) 
  float temp = random(0, p1+p2+p3+p4);
  if (temp < p1) {
    return 0;
  }
  if (temp >= p1 && temp < (p1+p2)) {
    return 1;
  }
  if (temp >= (p1+p2) && temp < (p1+p2+p3)) {
    return 2;
  }
  if (temp >= (p1+p2+p3) && temp < (p1+p2+p3+p4)) {
    return 3;
  } 
  return -1;
}

boolean ellipseTest(float x, float y, float ox, float oy, float dx, float dy) {
  if ( (x-ox)*(x-ox)/(dx/2*dx/2) + (y-oy)*(y-oy)/(dy/2*dy/2) <= 1 )  return true;
  else  return false;
}

void mouseMoved() {
  game.mouseMoved();
}

void mouseClicked() {
  game.mouseClicked();
}

void keyReleased() {
  game.keyReleased();
}