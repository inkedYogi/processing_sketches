/**
 Here is what the CSV looks like:
 name,   map x, map y, founding generation, type,   alignment, parent city, founding race, magic prescence, government, description
 String, int,   int,   int,                 String, String,    String,      String,        String,          String,     String 
 String 1
 int 3
 String 7
 All 11
 */
 ArrayList<Cite> cites;
//Cite[] cites;         // An Array of Cite objects
Table table;          // A Table object
void setup() {
  size(1600, 900);
  loadData();
}
void draw() {
  background(255);
  for (Cite b : cites) {      // Display all cites
    b.display();
    b.rollover(mouseX, mouseY);
  }
}
void loadData() {
  // Load CSV file into a Table object
  table = loadTable("data.csv", "header");   // "header" option indicates the file has a header row
  // The size of the array of Cite objects is determined by the total number of rows in the CSV
  cites = new ArrayList<Cite>();
  //cites = new Cite[table.getRowCount()]; 
  int rowCount = 0;                    // You can access iterate over all the rows in a table
  for (TableRow row : table.rows()) {
    String n = row.getString("Name");
    float x = row.getFloat("map x");
    float y = row.getFloat("map y");
    int gen = row.getInt("Founding Generation");
    String t = row.getString("Type");
    String a = row.getString("Alignment");
    String p = row.getString("Parent City");
    String r = row.getString("Founding Race");
    String m = row.getString("Magic Prescence");
    String g = row.getString("Government");
    String d = row.getString("Description");
    
    // Make a Cite object out of the data read
    //cites[rowCount] = new Cite(x, y, 10, n);
    cites.add(new Cite(x, y, 10, n));
    rowCount++;
  }
}

void mousePressed() {
  // Create a new row
  TableRow row = table.addRow();
  // Set the values of that row
  row.setFloat("x", mouseX);
  row.setFloat("y", mouseY);
  row.setFloat("diameter", random(40, 80));
  row.setString("name", "Blah");

  // If the table has more than 10 rows
  if (table.getRowCount() > 10) {
    // Delete the oldest row
    table.removeRow(0);
  }

  // Writing the CSV back to the same file
  saveTable(table, "data/data.csv");
  // And reloading it
  loadData();
}