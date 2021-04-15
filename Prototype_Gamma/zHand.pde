class Hand {
  Player player;
  ArrayList<Card> cards;
  Card currentSelection, moused;
  Card lastSelected;

  Hand(Player P) {
    player = P;
    cards = new ArrayList<Card>();
  }

  void drawCard() {
    ArrayList<Card> pool = player.cardPool;
    Card temp = pool.get((int)random(pool.size())).copy();
    if (cards.size()==5)  discard(0);
    cards.add(temp);
  }

  void discard(int n) {
    if (cards.size() > 0) {
      Card target = cards.get(n);
      cards.remove(target);
    }
  }

  void play(Card C, Territory T){
    //bring the card, C, into play at the territory, T
    cards.remove(C);
    Unit u = new Unit(C.name, C.atk, C.def, C.abilities, C.helpText);
    u.controllingPlayer = player;
    u.anchor = T.com;
    T.within.units.add(u);
    T.selected = false;
    player.currentGame.handler.selectedTerrain = null;
  }



  //Card makeSelection() {
  //draw the select target prompt
  //listen for input from the user
  //when a specific input occurs (a valid target) return that card as the selection
  //return Card selection;
  //}

  void mouseMoved() {
    for (Card c : cards) {
      if (mouseX > c.artX && mouseX < c.artX + c.imgWid) {
        if (mouseY > c.artY && mouseY < c.artY + c.imgHei) {
          c.mousedOver = true;
        } else {
          c.mousedOver = false;
        }
      } else {
        c.mousedOver = false;
      }
    }
  }

  void mouseClicked() {
    for (Card c : cards) {
      if (c.mousedOver) {
        lastSelected = currentSelection;
        if (lastSelected != null)   lastSelected.selected = false;
        currentSelection = c;
        currentSelection.selected = true;
      }
    }
  }
}