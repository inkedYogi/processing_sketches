import processing.sound.*;
SoundFile[] music;
int musicIndex;

Sphere surf, clouds, field, moon;
String[] m = {"0.png", "1.png", "2.png", "3.png", "4.png", "5.png"};
String[] n = {"c1.png", "c2.png", "c3.png"};
String[] q = {"st.png"};
String[] p = {"moon.png", "newMoon.png"};
int time;
float targetY, ang;

void setup() {
  //size(1000, 1000, P3D);
  fullScreen(P3D);
  music = new SoundFile[2];
  music[0] = new SoundFile(this, "Nomadic Sunset.mp3");
  musicIndex = 0;
  noCursor();
  background(0);
  noStroke();  
  surf = new Sphere(m, 128, 128);
  clouds = new Sphere(n, 128, 128);
  field = new Sphere(q, 64, 64);
  moon = new Sphere(p, 128, 128);
  surf.legend = 5;
  ang = 0;
  targetY = 2*PI+PI/6;
  
  pushMatrix();
  translate(-1000, -1000, 1000);
  for (int i=0; i<surf.maps.length; i++)  surf.tSphere(200, surf.maps[i]);
  popMatrix();

  time = millis();
  println("load time: " + round(time*.001) + " sec");
  music[0].amp(0.6);
  music[0].play();
}

void draw() {
  background(0);
  float t = frameCount;
  int cue = floor((millis()-time)*.01);
  camera(-120, -100, 450, 0, 0, 0, 0, 1, 0);
  if (cue == 275) surf.legend = 4;    //to GD
  if (cue == 465) surf.legend = 3;    //to Hz
  if (cue == 684) surf.legend = 2;    //to Bz
  if (cue == 913) surf.legend = 1;    //to SA
  if (cue == 1148) { 
    surf.legend = 0;   //to AA
    moon.legend = 1;
  }
  if (cue == 1763) {
    surf.legend = 5;   //to XX
    moon.legend = 0;
  }
  //song ends at cue = 1910

  pushMatrix();
  if (cue < 100)  ang += .008;
  field.tSphere(3000, field.maps[0]);
  rotateX(PI/8);
  rotateY(PI/12);  
  directionalLight(min(frameCount, 255), min(frameCount, 255), min(frameCount, 255), -cos(-ang), 0, -sin(-ang));
  if (t*.0006 < targetY)  rotateY(t*.0006);
  else rotateY(targetY);
  translate(0, 0, 0);  
  surf.tSphere(200, surf.maps[surf.legend]);
  rotateY(t*.00005);
  clouds.tSphere(201, clouds.maps[0]);
  rotateY(t*.0001);
  clouds.tSphere(202, clouds.maps[1]);
  rotateY(t*.0001);
  clouds.tSphere(203, clouds.maps[2]);
  rotateY(t*.0000925);
  translate(365, 0, 0);
  moon.tSphere(20, moon.maps[moon.legend]);
  popMatrix();
  if (cue == 1915) {
    music[0].stop();
    println("there were " + frameCount + " frames.");
    println("duration: " + round(cue*.1) + " sec");
    saveFrame("thumb.png");
    exit();
  }
}

void mouseReleased() {
  if (mouseButton==RIGHT) {
    surf.legend++;
    if (surf.legend==surf.maps.length)  surf.legend=0;
  }
  if (mouseButton==LEFT) {
    surf.legend--;
    if (surf.legend==-1)  surf.legend=surf.maps.length-1;
  }
}

void keyReleased() {
}
