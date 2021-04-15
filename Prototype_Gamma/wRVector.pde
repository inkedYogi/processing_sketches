class RVector { 
  //contains 27 of the world's resources
  PVector flora;       //x water            //y crops           //z wood                (soul)
  PVector fauna;       //x game             //y domesticated    //z exotic              (body)
  PVector metals;      //x copper           //y silver          //z gold                (mind)
  PVector trade;       //x caravan          //y ports           //z airlines            (soul)
  PVector ores;        //x stone            //y iron            //z unobtainium         (body)
  PVector gems;        //x semi-precious    //y precious        //z diamond             (mind)
  PVector magic;       //x herbal           //y potions         //z spells              (soul)
  PVector tools;       //x hand             //y power           //z precision           (body)
  PVector books;       //x scrolls          //y spellbooks      //z information sphere  (mind)

  //soul:      //body:      //mind:
  //flora      //fauna      //metals
  //trade      //ores       //gems
  //magic      //tools      //books

  RVector (int code) {
    switch(code) {
    case 0:
      flora =   new PVector(0, 0, 0);
      fauna =   new PVector(0, 0, 0);
      metals =  new PVector(0, 0, 0);
      trade =   new PVector(0, 0, 0);
      ores =    new PVector(0, 0, 0);
      gems=     new PVector(0, 0, 0);
      magic =   new PVector(0, 0, 0);
      tools =   new PVector(0, 0, 0);
      books =   new PVector(0, 0, 0);
      break;
    }
  }
  void Rset(Game G, PVector L, float R) {
    PImage rMap = G.loader.maps[2]; 
    rMap.loadPixels();
    int xStart = round(L.x - R);
    int xEnd   = round(L.x + R);
    int yStart = round(L.y - R);
    int yEnd   = round(L.y + R);      
    for (int x = xStart; x<xEnd; x++) {
      for (int y = yStart; y<yEnd; y++) {
        if (dist(x, y, L.x, L.y) < R) {
          color pix = rMap.get(x, y); 
          //print(pix);
        }
      }
    }
  }


  RVector add(RVector R) {
    RVector sum = new RVector(0);
    sum.flora  = PVector.add(this.flora,  R.flora);
    sum.fauna  = PVector.add(this.fauna,  R.fauna);
    sum.metals = PVector.add(this.metals, R.metals);
    sum.trade  = PVector.add(this.trade,  R.trade);
    sum.ores   = PVector.add(this.ores,   R.ores);
    sum.gems   = PVector.add(this.gems,   R.gems);
    sum.magic  = PVector.add(this.magic,  R.magic);
    sum.tools  = PVector.add(this.tools,  R.tools);
    sum.books  = PVector.add(this.books,  R.books);
    return sum;
  }
}