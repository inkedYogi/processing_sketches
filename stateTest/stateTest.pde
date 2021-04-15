Level lev;
Explorer player;

void setup() {
  size(800, 800);
  lev = new Level(12);
  player = new Explorer(lev);
}

void draw() {
  //if (frameCount % 100 == 0)  lev.init();
  background(255/2);
  lev.disp();
  player.disp();
}

void keyReleased() {
  switch(keyCode) {
  case UP:
    player.move(0);
    break;
  case RIGHT:
    player.move(1);
    break;
  case DOWN:
    player.move(2);
    break;
  case LEFT:
    player.move(3);
    break;
  }
}
