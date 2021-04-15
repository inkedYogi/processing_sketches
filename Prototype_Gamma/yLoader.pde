class Loader {
  Game currentGame;
  PImage maps[];
  PVector canvasDims;
  String[] script, files;
  ArrayList<Blip> locations;
  Table dataTable, cardData, abilData, itemData;
  String filename, foldername;

  Loader(boolean longBoot, Game G) {
    currentGame = G;
    canvasDims = new PVector(1200, 800);
    loadLayers();
    loadCards();
    loadData();
  }

  void loadLayers() {
    print("loading maps ");
    String[] files = {"uasa.jpg", "stone age.jpg", "All.png", "boarders.png", "icons.jpg", "stone age_boarders.jpg"};
    maps = new PImage[files.length+1];
    foldername = "maps";
    for (int m=files.length-1; m>0; m--) {
      filename = files[m];
      maps[m] = requestImage(foldername + "/" + filename);       print(".");
    }
    maps[0] = loadImage(foldername + "/" + files[0]);            print(".");   println(""); 
    maps[0].resize((int)canvasDims.x, (int)canvasDims.y);
  }

  void loadCards() {
    cardData = loadTable("cards.csv", "header");                 print("cards!");
    abilData = loadTable("ability.csv", "header");               print("abilities!");
    //itemData = loadTable("items.csv", "header");                 print("items!");    
    println("");
  }

  void loadData() {
    locations = new ArrayList<Blip>();
    dataTable = loadTable("data.csv", "header");                print("location!");
    for (TableRow row : dataTable.rows()) {
      String n = row.getString("Name");
      float x = row.getFloat("map x");
      float y = row.getFloat("map y");
      String t = row.getString("Type");
      //println(t, n);
      switch(t) {
      case "City":
        City town = new City(currentGame.players[0]);
        town.pos.set(x, y);
        town.name = n;
        town.type = t;
        town.fillInfo();
        currentGame.markers.add(town);
        locations.add(town);
        break;
      case "Fort":
        Fort post = new Fort(currentGame.players[0]);
        post.pos.set(x, y);
        post.name = n;
        post.type = t;
        post.fillInfo();
        currentGame.markers.add(post);
        locations.add(post);
        break;
      case "Tree": 
        Tree wood = new Tree(currentGame.players[0]);
        wood.pos.set(x, y);
        wood.name = n;
        wood.type = t;
        wood.fillInfo();
        currentGame.markers.add(wood);
        locations.add(wood);
        break;
      case "Ruin":
        Ruin dust = new Ruin(currentGame.players[0]);
        dust.pos.set(x, y);
        dust.name = n;
        dust.type = t;
        dust.fillInfo();
        currentGame.markers.add(dust);
        locations.add(dust);
        break;
      }
    }
  }

  void keyReleased() {
    switch(key) {
    case '1':  maps[0] = maps[1];    break;
    case '2':  maps[0] = maps[2];    break;
    case '3':  maps[0] = maps[3];    break; 
    case '4':  maps[0] = maps[4];    break; 
    case '5':  maps[0] = maps[5];    break; 
    case '0':  currentGame.gameStart();    break;
    }
    if (maps[0]!=null) maps[0].resize((int)canvasDims.x, (int)canvasDims.y);
  }
}