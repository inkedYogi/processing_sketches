//1,2,4,8,16,32,64,128,256,512,1024,2048
//0,1,2,3,04,05,06,007,008,009,0010,0011

//tournament
//select how many slots
//divide into pairs
//divide into rounds

//round:
//if odd number assign bi
//for each pair do combat (win, lose, draw)
//pull each image
//assign left or right
//put up each image
//wait for input to determine winner
//add winner to upPool, add loser to downPool
//add drawers to both pools?

Player juan, deux;
Card[] combatants;
int[] resultant;
boolean[] loaded;
Card topCard;

void setup() {
  //play space
  size(500, 500);
  ellipseMode(CENTER);
  textAlign(CENTER);
  //play items
  combatants = new Card[16];
  loaded = new boolean[combatants.length];
  resultant = new int[combatants.length];
  for (int i=0; i<combatants.length; i++) {
    loaded[i] = false;
    combatants[i] = new Card(i); 
    resultant[i] = 0;
  }
  topCard = combatants[int(random(0, combatants.length))];
  //players
  juan = new Player(1);
  deux = new Player(2);
  juan.loc = new PVector (width*.05, height*.15);
  deux.loc = new PVector (width*.95-deux.hand.W, height*.15);
  juan.name = "Player One";
  deux.name = "Player Two";
  juan.drawCard(combatants);
  deux.drawCard(combatants);
  refresh();
}

void draw() {
  background(200);
  showArena();
  juan.showHand();
  deux.showHand();
}

void refresh() {
  announceRound(juan, deux);
}

void announceRound(Player One, Player Two) {
  print(juan.name + "'s " + juan.hand.name + "(" + juan.hand.id + ")");
  print("   VS   ");
  print(deux.name + "'s " + deux.hand.name + "(" + deux.hand.id + ")");
  println();
}

void showArena() {
  fill(200, 10, 10);
  ellipse(width*.5, height*.40, 30, 30);
  fill(0);
  text("VS", width*.5, height*.408);
}

boolean checkLoadStates() {
  for (int j = 0; j < loaded.length; j++) {
    if (loaded[j] == false) {
      return false;
    }
  }
  return true;
}

boolean checkLoadState(int im) {
  if (loaded[im] == false) {
    return false;
  }
  return true;
}

void keyPressed() {
  switch(keyCode) {
  case LEFT:
    println("left");
    //juan wins, deux loses
    resultant[juan.hand.id] = 1;
    resultant[deux.hand.id] = -1;
    break;
  case RIGHT:
    println("right");
    //deux wins, juan loses
    resultant[deux.hand.id] = 1;
    resultant[juan.hand.id] = -1;
    break;
  }
}
