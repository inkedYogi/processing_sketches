class Player {
  Census controlled;
  Game currentGame;
  color factionColor, unitColor;
  ArrayList<Panel> infoPanels;
  ArrayList<Card> cardPool;
  Hand hand;
  Panel handPanel;
  int manapool;
  String[] playerInfo;
  boolean pan, han;
  int playerNum, victoryPoints;

  Player(int PN, Game G) {
    playerNum = PN;
    currentGame = G;
    controlled = new Census();
    infoPanels = new ArrayList<Panel>();
    playerInfo = new String[13];
    fillInfo();
    infoPanels.add(new Panel(new PVector(0, 0), "PLAYER " + playerNum, playerInfo, "player") );
    Panel p = infoPanels.get(0);
    p.dim.x *= 1.25;
    p.pos.set(width-p.dim.x, height-p.dim.y);
    pan = true;
    han = true;
    manapool = 0;
    victoryPoints = 0;
    factionColor = color(50, 50);
    unitColor = color(244, 244, 60);
    hand = new Hand(this);
    handPanel = new Panel(new PVector(0, height-225), "HAND ", new String[0], "cards");
    handPanel.tb = color(200, 10, 10);
    handPanel.pos.add(new PVector(5, 0));
    handPanel.dim.set(infoPanels.get(0).pos.x-5-handPanel.pos.x, height-handPanel.pos.y);
    cardPool = new ArrayList<Card>();
  }

  void update() {
    fillInfo();
  }

  void disp() {
    if (pan) {
      for (Panel p : infoPanels) {
        p.disp();
      }
    }
    if (han) {
      push();
      handPanel.disp(); 
      for (Card c : hand.cards) {
        c.artX = (int)(handPanel.pos.x + hand.cards.indexOf(c) * (c.imgWid + c.bub + 5));
        c.artY = (int)(handPanel.pos.y + 25);
        c.disp();
      }
      pop();
    }
    drawManaSprite(width*.775, height*.9);
  }

  void fillInfo() {
    playerInfo[0] = "victory points: " + victoryPoints;
    playerInfo[1] = "trees: " + controlled.trees.size();
    playerInfo[2] = "cities: " + controlled.cities.size();
    playerInfo[3] = "forts: " + controlled.forts.size();
    playerInfo[4] = "ruins: " + controlled.ruins.size();
    playerInfo[5] = "units: " + controlled.units.size();
    playerInfo[6] = "territories: " + controlled.territories.size();
    playerInfo[7] = "domain: " + controlled.domain.size();
    playerInfo[8] = "";  //empty line
    playerInfo[9] = "age: " + currentGame.currentAge;
    playerInfo[10] = "generation: " + currentGame.currentGen;
    playerInfo[11] = "phase: " + currentGame.currentPhase;    
    playerInfo[12] = "";  //empty line
  }

  void drawManaSprite(float x, float y) {
    push();
    strokeWeight(4);
    stroke(0, 100);
    fill(color(10, 164, 245));
    ellipse(x, y, 100, 150);
    fill(0);
    textAlign(CENTER);
    textSize(64);
    text(manapool, x, y+20);
    pop();
  }

  void checkConditions() {
    if (currentGame.handler.selectedTerrain != null) {
      if (hand.currentSelection != null) {
        if (manapool > hand.currentSelection.cost) {
          {
            manapool -= hand.currentSelection.cost; 
            hand.play(hand.currentSelection, currentGame.handler.selectedTerrain);
          }
        } else { 
          println("not enough mana");
        }
      } else {
        println("no card selected");
      }
    } else {
      println("terrain not selected");
    }
  }

  void mouseClicked() {
    hand.mouseClicked();
    for (int p=infoPanels.size()-1; p>=0; p--) {
      //if (infoPanels.get(p).mousedOver()) infoPanels.remove(infoPanels.get(p));
    }
    if (ellipseTest(mouseX, mouseY, width*.775, height*.9, 100, 150)) {
      println("Mana clicked");
      checkConditions();
    }
  }

  void keyReleased() {
    switch(key) {
    case 'c':  
      break;                                                                     
    case 't':  
      break;                                  
    case 'r':  
      break;                                
    case 'b':  
      break;
    case 'h':                                   //toggle hand in view
      han = !han;                
      break; 
    case 'd':
      hand.discard(0);
      break;
    case 'f':  
      hand.drawCard();
      break; 
    case 'x':  
      infoPanels = new ArrayList<Panel>(); 
      infoPanels.add(new Panel(new PVector(width, 1), "PLAYER " + playerNum, playerInfo, "info"));
      Panel p = infoPanels.get(0);
      p.pos.set(width-p.dim.x, height-p.dim.y);
    }
    switch(keyCode) {
    case ENTER: //10
      pan = !pan;
      println("panels " + pan);
      break;
    }
    if (pan) fillInfo();
  }

  void mouseMoved() {
    hand.mouseMoved();
  }
}