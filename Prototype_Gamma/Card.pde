class Card {
  Game game;
  String name, metatype;
  int cost, artX, artY, imgWid, imgHei;
  PFont largeFont, smallFont;
  PImage art;
  int atk, def, abs;
  float bub;
  PImage[] icons;
  color[] abilColors;
  String[] abilities, helpText, properties;
  float helpTextMaxWidth;
  float scale;
  color costColor, attackColor, defenseColor;
  color familiarColor, minionColor, companionColor;  //speacial property colors
  boolean mousedOver, selected;

  Card(String f, Game g) {
    game = g;
    name = f;
    scale = 45;
    imgWid = (int)(320*scale/100);
    imgHei = (int)(425*scale/100);
    bub = imgWid/10;
    largeFont = createFont("cambria", imgWid/8);  
    smallFont = createFont("cambria", imgWid/16); 
    costColor      = color(50, 95, 190, 225);
    familiarColor  = color(150, 0, 150, 200);
    minionColor    = color(150, 0, 0, 200);
    companionColor = color(0, 150, 0, 200);
    attackColor    = color(175, 0, 0, 200);
    defenseColor   = color(0, 175, 0, 200);
    loadArt("cards", f);
    buildCard(f);
    mousedOver = false;
    selected = false;
  }

  void disp() {
    push();
    {  //setup
      ellipseMode(CENTER);
      textFont(largeFont);
      translate(artX, artY);
    }

    {  //boarder / background
      noFill();
      if (mousedOver)  stroke(255);
      if (selected)    stroke(color(245, 245, 60));
      strokeWeight(3);
      if (mousedOver || selected)  rect(-5, -5, imgWid+10, imgHei+10);
    }

    {  //card art
      image(art, 0, 0);
    }

    {  //bubble setup
      stroke(0);
      strokeWeight(scale/25);
      textAlign(CENTER);
    }

    {  //cost bubble
      fill(costColor);
      ellipse(imgWid-10, 10, 2*bub, 2*bub);
      fill(0);
      text(cost, imgWid-10, 10+bub/3);
    }

    {  //special properties
      textFont(smallFont);
      for (String p : properties) {
        if (p=="canFamiliar") {
          fill(familiarColor);
          ellipse(imgWid/8, 0, bub, bub);
          fill(0);
          text("F", imgWid/8, bub/6);
        }
        if (p=="canMinion") {
          fill(minionColor);
          ellipse(imgWid/4, 0, bub, bub);
          fill(0); 
          text("M", imgWid/4, bub/6);
        }
        if (p=="canCompanion") {
          fill(companionColor);
          ellipse(imgWid*3/8, 0, bub, bub);
          fill(0);
          text("C", imgWid*3/8, bub/6);
        }
      }
    }
    textFont(largeFont);

    {  //attack bubble
      fill(attackColor);
      ellipse(bub, imgHei-bub, 2*bub, 2*bub);
      fill(0);
      text(atk, bub, imgHei+bub/3-bub);
    }

    {  //defense bubble
      fill(defenseColor);
      ellipse(imgWid-bub, imgHei-bub, 2*bub, 2*bub);
      fill(0);
      text(def, imgWid-bub, imgHei+bub/3-bub);
    }

    {  //abilities 
      int L = abilities.length;
      for (int a=L-1; a>=0; a--) {
        strokeWeight(1);
        float ablX = (imgWid/2)-(25)-(a*27.5)+(L*27.5/2);
        if (L==1) ablX = (imgWid/2 - 25/2);
        float ablY = imgHei*.715;
        //println(name, abilities[b], b);
        if (abilities.length > 0 && game.loader.abilData.findRow(abilities[a], "Name").getInt("Has Icon")==1) {          
          noFill();
          image(icons[a], ablX, ablY);
        } else {
          fill(abilColors[a]);
        }
        rect(ablX, ablY, 25, 25);
        if (mousedOver) {
          if (mouseX > ablX && mouseX < ablX + 25)
            if (mouseY > ablY && mouseY < ablY + 25)  setShowHelp(a, true);
        }
      }
    }
    pop();
  }

  void buildCard(String n) {
    TableRow c = game.loader.cardData.findRow(n, "Name");
    cost = c.getInt("$");
    atk = c.getInt("+Atk");
    def = c.getInt("+Def");
    abilities = splitTokens(c.getString("Ability"), ";");
    abilColors = new color[abilities.length];
    helpText = new String[abilities.length];
    helpTextMaxWidth = 0;
    icons = new PImage[abilities.length];
    properties = splitTokens(c.getString("Properties"), ";");
    int index = 0;
    for (String a : abilities) {
      TableRow h = game.loader.abilData.findRow(a, "Name");
      println(a);
      helpText[index] = h.getString("Text");
      if (textWidth(helpText[index]) > helpTextMaxWidth)  helpTextMaxWidth = textWidth(helpText[index]);
      int t = h.getInt("Color");
      if (h.getInt("Has Icon")==1) {
        PImage ico = game.loader.maps[4];
        int x = h.getInt("Pic X");
        int y = h.getInt("Pic Y");
        icons[index] = ico.get(x, y, 50, 50);
        icons[index].resize(25, 25);
      }
      abilColors[index] = fillAbilColors(t);
      index++;
    }
  }

  void setShowHelp(int i, boolean m) {
  }

  void showHelp(int i, float x, float y) {
    push();
    if (i==1) {
      strokeWeight(1);
      stroke(255);
      fill(0);
      rect(x-5, y+5, helpTextMaxWidth+10, helpText.length * imgWid/16);
    }
    fill(255);
    textFont(smFont);
    for (String l : helpText) {
      text(l, x, y);
    }
    pop();
  }

  void loadArt(String foldername, String filename) {
    art = loadImage(foldername + "/" + filename + ".jpg");
    art.resize(imgWid, imgHei);
  }

  void loadText() {
  }

  color fillAbilColors(int typ) {
    switch(typ) {
    case 1:
      //modifier colors
      return color(200, 25, 25);
    case 2:
      //passive
      return color(200, 25, 200);
    case 3:
      //active 
      return color(25, 200, 25);
    case 4:
      //passive/active
      return color(200, 200, 25);
    }
    return color(255);
  }

  Card copy() {
    return new Card(name, game);
  }
}