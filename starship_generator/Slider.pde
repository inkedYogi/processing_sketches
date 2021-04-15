class Slider {
  PVector pos;
  float value, min, max;
  float scale, sliderWidth, sliderHeight;
  boolean mousedOver, adjust;
  float dx, dy;

  Slider(PVector p, float mini, float maxi, float start) {
    scale = 200;
    sliderWidth = 10;
    sliderHeight = 30;

    pos = p;
    min = mini;
    max = maxi;
    value = start;
    adjust = false;
  }

  void disp() {
    dx = sliderWidth/2;
    dy = sliderHeight/2;
    if ((mouseX > pos.x-dx+map(value, min, max, 0, scale) && mouseX < pos.x+dx+map(value, min, max, 0, scale)) && (mouseY > pos.y-dy && mouseY < pos.y+dy)) {
      mousedOver = true;
    } else {
      mousedOver = false;
    }

    if (mousedOver && !adjust) {
      cursor(CROSS);
    } else {
      //
    }

    pushStyle();
    rectMode(CENTER);
    strokeWeight(2);
    stroke(255);
    line(pos.x, pos.y, pos.x+this.scale, pos.y);
    fill(map(value, 0, max, 0, 255));
    strokeWeight(1);
    rect(pos.x + map(value, min, max, 0, scale), pos.y, sliderWidth, sliderHeight);
    popStyle();
  }

  void mousePressed() {
    if (mousedOver) {
      dx = sliderWidth/2;
      dy = sliderHeight/2;
      adjust = true;
      //value = map(mouseX, pos.x-dx, pos.x+scale-dx,min,max);
      cursor(HAND);
      disp();
    }
  }

  void mouseDragged() {
    if (adjust) {
      value = constrain(map(mouseX, pos.x-dx, pos.x+scale-dx, min, max), min,max);
    }
  }

  void mouseReleased() {
    if (adjust) {
      adjust = false;
      cursor(ARROW);
    }
  }
  
}