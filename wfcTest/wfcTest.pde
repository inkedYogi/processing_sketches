import processing.svg.*;

class Module {  //defines a potentially usable Slot
  int[] borders = new int[4];
  String id;
  PShape shape;
  float randomChance;
  //borders start on right, go counter clockwise.
  // 1
  //2+0
  // 3
  
  Module (int[] b, String _id) {
    borders = b;
    id = _id;
    randomChance = 0.0;
  }
  
  Module (int[] b, String _id, float r) {
    borders = b;
    id = _id;
    randomChance = r;
  }
}

final Module[] Moduleset = new Module[] {
//new Module(new int[] {0,0,0,0}, "0", 0.0),
new Module(new int[] {0,0,0,0}, "0a", 0.0),
//new Module(new int[] {0,0,0,1}, "1", 0.0),
new Module(new int[] {0,0,0,1}, "1a", 0.1),
//new Module(new int[] {3,0,0,1}, "2"),
//new Module(new int[] {0,0,2,1}, "3"),
//new Module(new int[] {3,0,2,1}, "4"),
//new Module(new int[] {3,0,2,1}, "4a"),
//new Module(new int[] {3,0,2,1}, "4b"),
//new Module(new int[] {0,1,0,0}, "5"),
new Module(new int[] {0,1,0,0}, "5a", 0.1),
//new Module(new int[] {2,1,0,0}, "6"),
//new Module(new int[] {0,1,3,0}, "7"),
new Module(new int[] {0,1,0,1}, "8", 0.5),
new Module(new int[] {2,1,0,1}, "9", 0.5),
new Module(new int[] {2,1,0,1}, "9a", 0.6),
new Module(new int[] {2,1,0,1}, "9c", 0.2),
//new Module(new int[] {3,1,0,1}, "10"),
new Module(new int[] {3,1,0,1}, "10a", 0.5),
new Module(new int[] {3,1,0,1}, "10b", 0.6),
new Module(new int[] {3,1,0,1}, "10c", 0.2),
//new Module(new int[] {0,1,2,1}, "11"),
new Module(new int[] {0,1,2,1}, "11a", 0.5),
new Module(new int[] {0,1,2,1}, "11b", 0.6),
new Module(new int[] {0,1,2,1}, "11c", 0.2),
new Module(new int[] {0,1,3,1}, "12", 0.5),
new Module(new int[] {0,1,3,1}, "12a", 0.6),
new Module(new int[] {0,1,3,1}, "12c", 0.2),
new Module(new int[] {2,1,2,1}, "13", 0.5),
new Module(new int[] {2,1,2,1}, "13a", 0.2),
//new Module(new int[] {3,1,2,1}, "14"),
new Module(new int[] {3,1,3,1}, "15", 0.5),
new Module(new int[] {3,1,3,1}, "15a", 0.2)
};

class Slot {  //defines an individual square on the final piece.
  Module module;
  int x;
  int y;
  
  boolean updateNext = false;   //set by other slots to indicate this slot should update next tick
  boolean updateNow = false;    //set internally AFTER the update cycle if updateNext is true.
  boolean[][] borders = new boolean[][] { {true, false, true, true}, {true, true, false, false}, {true, false, true, true}, {true, true, false, false} };
  
  ArrayList<Module> possibleModules = new ArrayList<Module>();
  
  Slot (int _x, int _y) {
    x = _x;
    y = _y;
    
    for (int i = 0; i < Moduleset.length; i++) {
      possibleModules.add(Moduleset[i]);  
    }
  }
  
  void ForceModule (Module module) {
    possibleModules.clear();
    possibleModules.add(module);
    updateNext = true;    
  }
  
  void UpdateBorder (int side, boolean[] values) {
    borders[side] = values;
    updateNext = true;
  }
  
  //All slots have two update cycles, Update() and Update2().
  //All slots have Update() run one by one, and THEN Update2(). This allows us to queue updates between cycles without getting ahead of ourselves.
  //If slots were to tell each other to do things without this, we would not be able to run this simulation as a step-by-step process.
  //Instead, it would function as anarchy. It would probably still work, but the visualization wouldn't look nice.
  
  void Update () {
    if (updateNow) {
      updateNow = false;
      
      //solve border disputes.
      //i.e., if our border is 0,1,2 and our neighbor's border is 0,1,3, we should change to 0,1.
      if (x != gridWidth-1)  borders[0] = BorderMultiply(borders[0], grid[x+1][y].borders[2]);
      else if (wrap)         borders[0] = BorderMultiply(borders[0], grid[0][y].borders[2]);
      if (y != 0)            borders[1] = BorderMultiply(borders[1], grid[x][y-1].borders[3]);
      else if (wrap)         borders[1] = BorderMultiply(borders[1], grid[x][gridHeight-1].borders[3]);
      if (x != 0)            borders[2] = BorderMultiply(borders[2], grid[x-1][y].borders[0]);
      else if (wrap)         borders[2] = BorderMultiply(borders[2], grid[gridWidth-1][y].borders[0]);
      if (y != gridHeight-1) borders[3] = BorderMultiply(borders[3], grid[x][y+1].borders[1]);
      else if (wrap)         borders[3] = BorderMultiply(borders[3], grid[x][0].borders[1]);
      
      //update the list of possible modules to reflect our border conditions.
      ArrayList<Module> newPossibleModules = new ArrayList<Module>();
      
      //sort through all modules
      for (int m = 0; m < possibleModules.size(); m++) {
        Module module = possibleModules.get(m);
        boolean possible = true;
        
        for (int side = 0; side < borders.length; side++) {
          if (!borders[side][module.borders[side]]) possible = false;  //if any side is NOT good, the whole module is not good. reject it.
        }
        if (possible) newPossibleModules.add(module);  //build a list of only the good modules.
      }
      
      //if the list of possible modules changed, now we must update our borders to reflect what can actually be achieved by the available modules.
      //if (possibleModules.size() != newPossibleModules.size()) {
        possibleModules = newPossibleModules;
        
        boolean[][] newBorders = new boolean[][] { {false, false, false, false}, {false, false, false, false}, {false, false, false, false}, {false, false, false, false} };
        
        for (int m = 0; m < possibleModules.size(); m++) {
          Module module = possibleModules.get(m);
          
          for (int side = 0; side < module.borders.length; side++) {
            newBorders[side][module.borders[side]] = true;
          }
        }
        
        if (!BorderMatch(borders[0], newBorders[0])) {
          if (wrap && x == gridWidth-1)  grid[0][y].updateNext = true;
          else if (x != gridWidth-1)     grid[x+1][y].updateNext = true;
        }
        if (!BorderMatch(borders[1], newBorders[1])) {
          if (wrap && y == 0)            grid[x][gridHeight-1].updateNext = true;
          else if (y != 0)               grid[x][y-1].updateNext = true;
        }
        if (!BorderMatch(borders[2], newBorders[2])) {
          if (wrap && x == 0)            grid[gridWidth-1][y].updateNext = true;
          else if (x != 0)               grid[x-1][y].updateNext = true;
        }
        if (!BorderMatch(borders[3], newBorders[3])) {
          if (wrap && y == gridHeight-1) grid[x][0].updateNext = true;
          else if (y != gridHeight-1)    grid[x][y+1].updateNext = true;
        }
        
        borders = newBorders;
      //}
    }
  }
  
  void Update2() {
    int centerX = (x*gridSize) + (gridSize/2);
    int centerY = (y*gridSize) + (gridSize/2);
    
    if (possibleModules.size() > 1) {  //DRAW TEXT
      if (drawDebug == 1) {
        noFill();
        stroke(0);
        
        rect(centerX - (gridSize * 0.5), centerY - (gridSize * 0.5), gridSize, gridSize);
        if (updateNext) fill(200);
        rect(centerX - (gridSize * 0.3), centerY - (gridSize * 0.3), gridSize * 0.6, gridSize * 0.6);
        
        noStroke();
        fill(0);
        textAlign(CENTER, CENTER);
        textSize(gridSize/10);
        
        String s = "";  //temp string standin
        for (int i = 0; i < borders[0].length; i++) if (borders[0][i]) s = s + i + " ";
        text(s, centerX + gridSize * 0.35, centerY - gridSize * 0.3, gridSize * 0.1, gridSize * 0.6);
        s = "";
        for (int i = 0; i < borders[1].length; i++) if (borders[1][i]) s = s + i + " ";
        text(s, centerX - gridSize * 0.3, centerY - gridSize * 0.5, gridSize * 0.6, gridSize * 0.2);
        s = "";
        for (int i = 0; i < borders[2].length; i++) if (borders[2][i]) s = s + i + " ";
        text(s, centerX - gridSize * 0.45, centerY - gridSize * 0.3, gridSize * 0.1, gridSize * 0.6);
        s = "";
        for (int i = 0; i < borders[3].length; i++) if (borders[3][i]) s = s + i + " ";
        text(s, centerX - gridSize * 0.3, centerY + gridSize * 0.3, gridSize * 0.6, gridSize * 0.2);
        
        s = "";
        for (int i = 0; i < possibleModules.size(); i++) {
          s = s + possibleModules.get(i).id + " ";
        }
        text(s, centerX - (gridSize * 0.3), centerY - (gridSize * 0.3), gridSize * 0.6, gridSize * 0.6);
        
      } else if (drawDebug == 2) {  //DRAW TILES
        int d = 5;  //how many times to divide the boundary shape by
        float _s = gridSize * 0.9/d;
        
        stroke(200);
        noFill();
        rect(centerX - (gridSize * 0.5), centerY - (gridSize * 0.5), gridSize, gridSize);
        
        for (int i = 0; i < possibleModules.size(); i++) {
          int _x = i%d;
          int _y = floor(i/d);
          
          float tlx = (centerX - gridSize * 0.45) + (_x * _s);
          float tly = (centerY - gridSize * 0.45) + (_y * _s);
          
          stroke(200);
          noFill();
          
          boolean anyUpdates = false;
          boolean forceModule = false;
          
          if (mouseX > tlx && mouseY > tly && mouseX < tlx + _s && mouseY < tly + _s) {
            fill(200);
            
            if (clicked) {
              for (int x = 0; x < gridWidth; x++) {
                for (int y = 0; y < gridHeight; y++) {
                  if (grid[x][y].updateNext || grid[x][y].updateNow) anyUpdates = true;
                }
              }
              
              if (!anyUpdates) forceModule = true;
            }
          }
          
          rect(tlx, tly, _s, _s);
          shape(possibleModules.get(i).shape, tlx, tly, _s, _s);
          
          if (forceModule) this.ForceModule(possibleModules.get(i));
        }
      }
    } else {
      stroke(200);
      noFill();
      if (drawOutline) rect(centerX - (gridSize * 0.5), centerY - (gridSize * 0.5), gridSize, gridSize);
      shape(possibleModules.get(0).shape, centerX - gridSize/2, centerY - gridSize/2, gridSize, gridSize);
    }
    
    if (updateNext) {
      updateNext = false;
      updateNow = true;
    }
  }
}

boolean BorderMatch (boolean[] a, boolean[] b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}

boolean[] BorderMultiply (boolean[] a, boolean[] b) {
  boolean[] output = new boolean[a.length];
  
  for (int i = 0; i < output.length; i++) {
    output[i] = a[i] && b[i];
  }
  
  return output;
}

final int gridWidth = 5;
final int gridHeight = 5;
final int gridSize = 160;
Slot[][] grid;

boolean showOptions = false;
int drawDebug = 2;  //0: blank, 1: text, 2: tiles
boolean drawOutline = false;
boolean wrap = false;

boolean clicked = false;
boolean export = false;

void setup () {
  size (800, 800);
  //fullScreen();
  //frameRate(2);
  
  for (int i = 0; i < Moduleset.length; i++) {
    Moduleset[i].shape = loadShape("modules/" + Moduleset[i].id + ".svg");
  }
  
  generateStart();
}

void draw () {
  background(255);
  
  if (export) beginRecord(SVG, "test.svg");
  
  for (int x = 0; x < gridWidth; x++) {
    for (int y = 0; y < gridHeight; y++) {
       grid[x][y].Update();
    }
  }
  
  for (int x = 0; x < gridWidth; x++) {
    for (int y = 0; y < gridHeight; y++) {
       grid[x][y].Update2();
    }
  }
  
  if (export) {
    export = false;
    endRecord();
  }
  
  if (showOptions) {
    noStroke();
    fill(0);
    rect(0,0,250,200);
    textAlign(LEFT, TOP);
    textSize(20);
    fill(255);
    text("Q: Show Options\nA: Random Tile\nR: Reset\nE: Borders [" + drawOutline + "]\nW: Wrap [" + wrap + "]\n0/1/2: Debug Mode [" + drawDebug + "]", 10, 10);
  }
  
  if (clicked) clicked = false;
}

void generateStart() {
  grid = new Slot[gridWidth][gridHeight];
  
  for (int x = 0; x < gridWidth; x++) {
    for (int y = 0; y < gridHeight; y++) {
      Slot s = new Slot(x,y);
      if (!wrap) {
        if (x == gridWidth - 1)  s.UpdateBorder(0, new boolean[] {true, false, false, false});
        if (y == 0)              s.UpdateBorder(1, new boolean[] {true, false, false, false});
        if (x == 0)              s.UpdateBorder(2, new boolean[] {true, false, false, false});
        if (y == gridHeight - 1) s.UpdateBorder(3, new boolean[] {true, false, false, false});
      }
      grid[x][y] = s;
    }
  }
}

void keyPressed () {
  if (key == 'a') {
    boolean anyUpdates = false;
    ArrayList<Slot> remainingSlots = new ArrayList<Slot>();
    
    for (int x = 0; x < gridWidth; x++) {
      for (int y = 0; y < gridHeight; y++) {
        if (grid[x][y].updateNext || grid[x][y].updateNow) anyUpdates = true;
        if (grid[x][y].possibleModules.size() > 1) remainingSlots.add(grid[x][y]);
      }
    }
    
    if (!anyUpdates && remainingSlots.size() > 0) {
      int r = floor(random(remainingSlots.size()));
      Slot slot = remainingSlots.get(r);
      
      float max = 0;
      for (int i = 0; i < slot.possibleModules.size(); i++) {
        max += slot.possibleModules.get(i).randomChance;
      }
      
      float m = random(max);
      for (int i = 0; i < slot.possibleModules.size(); i++) {
        max -= slot.possibleModules.get(i).randomChance;
        
        if (max < m) {
          slot.ForceModule(slot.possibleModules.get(i));
          break;
        }
      }
      //slot.ForceModule(slot.possibleModules.get(m));
    }
  }
  
  if (key == 'r') { generateStart(); }
  
  if (key == 'w') { wrap =! wrap; }
  
  if (key == 'e') { drawOutline =! drawOutline; }
  
  if (key == 'q') { showOptions =! showOptions; }
  
  if (key == '0') { drawDebug = 0; }
  if (key == '1') { drawDebug = 1; }
  if (key == '2') { drawDebug = 2; }
  
  if (key == 't') { export = true; }
}

void mouseClicked() {
  clicked = true;
}
