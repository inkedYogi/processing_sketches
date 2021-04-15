class Player {
  PVector loc;
  int number;
  String name;
  Card hand;

  Player(int N) {
    number = N;
    name = "default";
    hand = new Card(0);
  }

  void showHand() {
    hand.update();
    if (hand.picLoaded==true) {
      image(hand.picture, loc.x, loc.y, hand.W, hand.H);
    } else {
      rect(loc.x, loc.y, hand.W, hand.H);
    }
  }
  
  void drawCard(Card[] deck) {
    hand = topCard; 
    topCard = deck[0];
    for (int i=1; i<deck.length-1; i++){
     deck[i] = deck[i+1];
    }
    deck[deck.length-1] = topCard;
  }
}
