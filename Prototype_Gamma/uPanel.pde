class Panel {
  PVector pos, dim;
  String title, prompt, contents;
  String[] body;
  color titleCol, textCol;
  color bg, tb, bd;
  float maxW;
  PFont lgFont, smFont;
  PImage alias;

  Panel(PVector L, String T, String[] B, String C) {  //Location, Title, Body, Content Type
    pos = L;
    title = T;
    body = B;
    contents = C;
    bg = color(25, 25, 25);
    tb = color(10, 10, 200);
    bd = color(100, 100, 100);
    titleCol = color(255, 255, 255);
    textCol = color(255, 255, 255);
    lgFont = createFont("Arial-Black", 24);
    smFont = createFont("Arial-Black", 12);
    if (contents == "player")  alias = loadImage("cards/The_Heir.jpg");
    setDims();
  }

  void setDims() {
    maxW = 0;
    textFont(smFont);
    for (String s : body) {
      if (s!=null) if (maxW < textWidth(s)) maxW = textWidth(s);
    }
    textFont(lgFont);
    if (maxW < textWidth(title)) maxW = textWidth(title);
    textFont(smFont);
    dim = new PVector(maxW + 10, body.length * 15 + 24 + 5);
  }

  void disp() {
    /*
     background
     boarder
     titlebar
     body
     button(s)
     */
    push();
    textAlign(LEFT);
    translate(pos.x, pos.y);
    if (pos.x+dim.x>width)  translate(-dim.x, 0);     //keep the panel 
    if (pos.x<0)  translate(dim.x, 0);
    if (pos.y+dim.y>height)  translate(0, -dim.y);    //on the screen
    if (pos.y+dim.y>800 && contents == "info") translate(0, -dim.y);
    if (mousedOver() || contents!="player") {
      fill(bg);  
      stroke(bd);  
      strokeWeight(2);
      rect(0, 0, dim.x, dim.y);
      fill(tb);  
      strokeWeight(1);
      rect(0, 0, dim.x, 24);
      fill(titleCol);    
      textFont(lgFont);
      text(title, 5, 20);
      translate(0, 25);  
      textFont(smFont);
      for (int i=0; i<body.length; i++) {
        text(body[i], 5, 15 * (i+1));
      }
    } else {
      alias.resize((int)dim.x, (int)dim.y);
      image(alias, 0, 0);
    }
    pop();
  }

  boolean overButton(int x, int y, int W, int H) {
    if (mouseX >= x && mouseX <= x + W && 
      mouseY >= y && mouseY <= y + H   ) {
      return true;
    } else {
      return false;
    }
  }

  boolean mousedOver() {
    if (mouseX>pos.x && mouseX<pos.x+dim.x && mouseY>pos.y && mouseY<pos.y+dim.y) return true; 
    else {
      return false;
    }
  }
}