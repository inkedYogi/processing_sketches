class Census {
  ArrayList<Unit> units;
  ArrayList<Tree> trees;
  ArrayList<City> cities;
  ArrayList<Fort> forts;
  ArrayList<Ruin> ruins;
  ArrayList<Territory> territories, domain;

  Census() {
    units =       new ArrayList<Unit>();
    trees =       new ArrayList<Tree>();
    cities =      new ArrayList<City>();
    forts =       new ArrayList<Fort>();
    ruins =       new ArrayList<Ruin>();
    territories = new ArrayList<Territory>();
    domain =      new ArrayList<Territory>();
  }

  void disp() {
    for (City c : cities) c.disp();
    for (Fort f : forts) f.disp();
    for (Tree t : trees) t.disp();
    for (Ruin r : ruins) r.disp();
    for (Unit u : units) u.disp();
  }

  void add(Blip B) {
    switch (B.type) {
    case "City":        cities.add((City)B);      break;
    case "Fort":         forts.add((Fort)B);      break;
    case "Tree":         trees.add((Tree)B);      break;
    case "Ruin":         ruins.add((Ruin)B);      break;
    }
  }
  
  void add(Territory T) {
    territories.add((Territory)T);
  }
  
  String[] toStringArray() {
    String[] list = new String[this.size()];
    int index = 0;
    for (City c : cities) {
      list[index] = c.name;
      index++;
    }
    for (Fort f : forts) {
      list[index] = f.name;
      index++;
    }
    for (Tree t : trees) {
      list[index] = t.name;
      index++;
    }
    for (Ruin r : ruins) {
      list[index] = r.name;
      index++;
    }
    for (Unit u : units) {
      list[index] = u.name;
      index++;
    }
    return list;
  }

  int size() {
    int sum = 0;
    sum += units.size();
    sum += trees.size();
    sum += cities.size();
    sum += forts.size();
    sum += ruins.size();
    return sum;
  }
  
  void checkDomain() {
    //the domain is the largest connected cluster of hexagons belonging to a player
  }

  void mouseMoved() {
    for (Territory e : territories) e.mouseMoved();
    for (Unit u : units) u.mouseMoved();
  }

  void mouseClicked() {
    for (Territory e : territories) e.mouseClicked();
  }
}