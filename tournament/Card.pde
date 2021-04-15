class Card {
  String name;
  int id;
  PImage picture;
  boolean picLoaded;
  int W,H;

  Card(int uniqueID) {
    id = uniqueID;
    picLoaded = false;
    picture = requestImage(id+".jpg");
    W = 200;
    H = 250;
    update();
  }
  
  void update(){
    
    picLoaded = checkLoaded();
  }
  
  boolean checkLoaded(){
    if ( (picture.width !=0) && (picture.width != -1)) {
      return true; 
    }
    return false;
  }
}
