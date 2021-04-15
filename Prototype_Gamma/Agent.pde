class Agent {
  //the decision maker
  int faction;
  String uniqueID;
  Player player;

  Agent() {
  }

  void update() {}
  
  void decide() {
    chooseAction();
    chooseCard();
  }
  
  void chooseCard() {
  chooseTerritory();
  //or 
  chooseUnit();
  }
  
  void chooseTerritory() {}
  
  void chooseUnit() {}
  
  void chooseAction() {}
  
  void flipACoin() {}
  
  void rollADie() {}
  
  void selectAfterConsideration() {}
  
  //void observeResults(function) {}
}