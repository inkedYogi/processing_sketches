class City extends Blip {
  int level;
  String[] imports;
  float[] price, volume;
  float population, wealth, rad, dia, rDensity, rBaseline, tradeRange;
 // float farmers, miners, lumberjacks, blacksmiths, traders, sailors, explorers, wizards;
  float food, stone, lumber, tools, birthDist, knowledge, trade, tech;
  RVector resource;

  City(Player P) {
    name = "default_city_name";
    type = "City";
    pos = new PVector(mouseX, mouseY);  //superclass
    controllingPlayer = P;
    P.controlled.cities.add(this);
    population = 10;
    rad = 5;
    dia = 2 * rad;

    info = new Panel(pos, name, new String[0],"info");
    infoDisp = false;
  }

  void update() {
    runChecks();
    fillInfo();
  }

  void disp() {
    super.disp();
  }

  void sprite() {
    fill(controllingPlayer.factionColor);
    strokeWeight(1);
    ellipse(0, 0, dia, dia);
  }

  void fillInfo() {
    String[] infill = new String[11];
    infill[0]  = "popuation: " + round(population);
    infill[1]  = "wealth: " + round(wealth);
    infill[2]  = "level: " + level;
    infill[3]  = "";
    infill[4]  = "";
    infill[5]  = "";
    infill[6]  = "";
    infill[7]  = "";
    infill[8]  = "structures: ";
    infill[9]  = "";
    infill[10] = "";
    info.title = name;
    info.body = infill;
    info.setDims();
  }
  
  void naturalResources() {
    //resource map contained in maps[2];
    //collection range is equal to population squared?
    
  }

  void runChecks() {
    checkResources();
    checkPop();
    checkWealth();
    checkLevel();
  }

  void checkResources() {
    resource = new RVector(0);
    resource.Rset(controllingPlayer.currentGame, pos, rad);
  }

  void checkPop() {
    float growth = population * .1;  //10% population growth rate
    population = population + growth;
  }

  void checkWealth() {
    wealth = population * rDensity;
  }

  void checkLevel() {
    level = (int)sqrt(population);
  }
}