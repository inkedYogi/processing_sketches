class Game {
  //serves as the game master
  Loader loader;
  Handler handler;
  Player[] players;
  int currentAge, currentGen, currentPhase;
  String ageName, genName, phaseName;
  Panel timePanel;
  Census markers;
  boolean hover, console;


  Game(int Ps) {
    markers = new Census();
    players = new Player[Ps]; 
    for (int i=0; i<players.length; i++) {
      players[i] = new Player(i, this);
    }
    loader = new Loader(true, this);
    handler = new Handler(this);
    timePanel = new Panel(new PVector(width/2-50,25),"Time", new String[2], "time");
    timePanel.body[0] = "      Age";
    timePanel.body[1] = "      Gen";
    timePanel.setDims();
    hover = false;
    console = false;
  }

  void disp() {
    image(loader.maps[0], 0, 0);
    handler.disp();
    timePanel.disp();
    if (console) handler.dispConsole();
  }

  void gameReset() {
    //markers = new Census();
    currentAge = 1; 
    ageReset();
  }

  void ageReset() {
    currentGen = 0; 
    currentPhase = 0;
    ageTriggers(currentAge);
  }

  void gameStart() {
    gameReset();
    for (int i=0; i<players.length; i++) {
      getDefaults(players[i].cardPool, i);
      for (int j=0; j<5; j++)  players[i].hand.drawCard();
      players[0].manapool = 5;
    }
  }

  void runPhases() {
    println("running age " + currentAge + " generation " + currentGen);
    timePanel.body[0] = "       " + currentAge;
    timePanel.body[1] = "       " + currentGen;
    resourcePhase(); 
    maintainPhase(); 
    actionPhase(); 
    combatPhase(); 
    cleanupPhase(); 
    currentGen++;
  }

  void resourcePhase() {
    currentPhase = 1; 
    println("running resourcePhase");
    //each player gets each controlled city's R vector
  }

  void maintainPhase() {
    currentPhase = 2; 
    println("running maintainPhase");
    //each player pays each controlled city's calculated costs
    //remove any unpaid, evil units now
  }

  void actionPhase() {
    currentPhase = 3; 
    println("running actionPhase");
    //each player chooses to move, hire, or activate a number of units equal to their domain
    handler.makeSelection = true;
  }

  void combatPhase() {
    //any enemy units occupying the same territory trigger a combat resolution
    currentPhase = 4;
  }

  void cleanupPhase() {
    //calculate each player's domain
    //ensure all players have exactly (5) cards
    //remove unpaid, good units from the board (evil was already removed)
    currentPhase = 5;
    println("running cleanupPhase");
  }

  void advanceAge() {
    currentAge++; 
    ageReset();
  }

  void ageTriggers(int age) {
    switch(age) {
    case 1:  //stone age
      println("It's the Stone Age!");
      appendSet(players[0].cardPool, stoneAge);
      break;
    case 2:  //bronze age
      println("It's the Bronze Age!");
      appendSet(players[0].cardPool, bronzeAge);
      break;
    case 3:  //dark age
      println("It's the Dark Age!");
      appendSet(players[0].cardPool, darkAge);
      break;
    case 4:  //enlightenment age
      println("It's the Enlightenment Age!");
      appendSet(players[0].cardPool, enlightenmentAge);
      break;
    case 5:  //industrial age
      println("It's the Industrial Age!");
      appendSet(players[0].cardPool, industrialAge);
      break;
    case 6:  //electric age
      println("It's the Electric Age!");
      appendSet(players[0].cardPool, electricAge);
      break;
    case 7:  //silicon age
      println("It's the Silicon Age!");
      appendSet(players[0].cardPool, siliconAge);
      break;
    case 8:  //nuclear age
      println("It's the Nuclear Age!");
      appendSet(players[0].cardPool, nuclearAge);
      break;
    case 9:  //global desert age
      println("It's the Global Desert Age!");
      appendSet(players[0].cardPool, globalDesertAge);
      break;
    case 10: //arcology age
      println("It's the Arcology Age!");
      appendSet(players[0].cardPool, arcologyAge);
      break;
    case 11: //fusion age
      println("It's the Fusion Age!");
      appendSet(players[0].cardPool, fusionAge);
      break;
    }
  }

  void getDefaults(ArrayList<Card> pool, int PLN) {
    appendSet(pool, wildGame);
  }

  //sets  
  String[] wildGame         = { "rat", "bat", "deer", "toad", "hare", "rabbit", "bunny" };
  String[] hauntedForest    = { "ooze", "skeleton", "snake", "spider", "zinger", "blight", "treant" };
  String[] darkForest       = { "deathClaw", "wolf", "floatingEye", "goblinShaman", "fungant" };
  String[] plainHunters     = { "cat", "snowLeopard", "lion", "grizzly", "cyclops" };
  String[] colorDragons     = { "greenDragon", "blueDragon", "redDragon" };
  String[] stoneAge         = { "hermit", "grimReaper", "shaman" };
  String[] farmAnimals      = { "chicken", "sheep", "cow", "horse", "brute", "unicorn" };
  String[] dungeonDepths    = { "goblin", "gelatine", "dwarf", "slime", "troll" };
  String[] wastelandMyths   = { "ghost", "centaur", "bogbeast", "cockatrice", "gorgon", "sphinx", "hellsteed" };
  String[] horrorStories    = { "zombie", "imp", "bloatedZombie", "lantern", "chimera", "demon", "mephisto" };
  String[] theElementals    = { "iceElemental", "earthElemental", "forestElemental", "fireElemental", "lavaElemental" }; 
  String[] feetingImages    = { "tormentor", "djinn", "devil", "efreet", "ifrit" };
  String[] bronzeAge        = { "priest", "merchant", "graveRobber", "soldier", "soceress", "desertDweller", "necromancer", "druid", "witchDoctor" };
  String[] quietDawn        = { "gloom", "dummy", "nymph", "bombling", "gluton" };
  String[] threatMorning    = { "grimWarrior", "goblinArcher", "gnoll", "ogre", "mimick", "succubus" };
  String[] dangerEvening    = { "wraith", "sentinel", "bat2", "goblinLancer", "centaur2", "tauro", "samurai", "kerberos" };
  String[] terrorNight      = { "iceGiant", "grizzly2", "goblinWarrior", "jelly", "fireGiant", "purpleWorm", "seraphine", "twoHeadedOgre" };
  String[] darkAge          = { "warrior", "monk", "monk2", "ranger", "corsair", "executor", "knight", "savage", "thief", "marksman", "warlock", "assassin", "darkKnight", "paladin"};
  String[] newDawn          = { "prism", "mermaid", "devil2"};
  String[] newDay           = { "phantom", "automaton", "mathematician" };
  String[] newDusk          = { "golem", "phoenix", "vampire", "mindFlayer" };
  String[] newDark          = { "lich" };
  String[] enlightenmentAge = { "wizard", "wizard2", "acolyte", "runebound", "wildMage" };
  String[] highSeas         = { "zinger2", "seaCaptain", "privateer" };
  String[] industrialAge    = { "mechanic", "swashbuckler" };
  String[] highVoltage      = { "drone", "golem2", "airCaptain", "thunderLizard" };
  String[] electricAge      = { "graveRobber2" };
  String[] highFrequency    = { "federalAgent" };
  String[] siliconAge       = {};
  String[] nuclearAge       = {};
  String[] warTime          = { "mercenary", "airCaptain2", "mech", "pilot" };
  String[] globalDesertAge  = { "scavenger", "survivor" };
  String[] peaceTime        = { "bb8" };
  String[] arcologyAge      = { "technomancer" };
  String[] fusionAge        = {};

  void appendSet(ArrayList<Card> pool, String[] set) {
    for (int i=0; i<set.length; i++) {
      pool.add(new Card(set[i], this));
    }
  }

  void mouseMoved() {
    hover = false;
    markers.mouseMoved();
    for (Player p : players)  p.mouseMoved();
    for (Territory e : markers.territories)  if (e.mousedOver)  hover=true;
    if (hover)  cursor(HAND);  
    else  cursor(ARROW);
  }

  void mouseClicked() {
    players[0].mouseClicked();
    markers.mouseClicked();
  }

  void keyReleased() {
    println("key pressed: " + key);
    loader.keyReleased(); 
    players[0].keyReleased(); 
    //handler.keySwitch(); 
    switch(key) {
    case '+' : 
      runPhases(); 
      break; 
    case '*' : 
      advanceAge(); 
      runPhases(); 
      break;
    case '`':
      console = !console;
      break;
    }
    for (Player p : players) {
      p.fillInfo();
    }
  }
}