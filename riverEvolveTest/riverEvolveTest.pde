ArrayList<HPP> HPPoints = new ArrayList<HPP>();
int xline = 3;
int xdist = 5;
int yline = 3;
int ydist = 5;
ArrayList<dataset> Lines = new ArrayList<dataset>();
ArrayList<col> cols = new ArrayList<col>();

void setup(){
  dfoLine();
  fullScreen();
  frameRate(500);
  setHPP();
  colorMode(HSB,360,100,100);
  for(int i = 0; i < 100; i++){
    col newcol = new col();
    newcol.h = random(190, 210);
    newcol.s = random(0, 255);
    newcol.b = 255;
    cols.add(newcol);
  }
}

void dfoLine() {//startposition
  for(int i = 0; i < width; i+=50){
    pos newpos = new pos();
    newpos.x = i;
    newpos.y = height / 2;
    Lines.add(multiadd(newpos));
  }
}

dataset multiadd(pos tpos){//1position > multiposition
  dataset dset = new dataset();
  ArrayList<pos> dss = new ArrayList<pos>();
  int i = 0;
  for(int X = 0; X < xline; X++){
    for(int Y = 0; Y < yline; Y++){
      pos apos = new pos();
      apos.x = X * xdist + tpos.x;
      apos.y = Y * ydist + tpos.y;
      //print(apos.y);
      dss.add(apos);
      i++;
    }
  }
  dset.ds = dss;
  return dset;
}

void draw(){
  if(mousePressed){
    dataset dset = Lines.get(Lines.size() - 1);
    pos Nowmpos = dset.ds.get(0);
    if(dist(Nowmpos.x, Nowmpos.y, mouseX, mouseY) > 50){
      pos mpos = new pos();
      mpos.x = mouseX;
      mpos.y = mouseY;
      Lines.add(multiadd(mpos));
    }
  }
    background(0);
    pos oldmpos = new pos();
    strokeWeight(2);
    for(HPP HPPoint: HPPoints){
      ellipse(HPPoint.x, HPPoint.y, 1, 1);
    }
    for(dataset mposs: Lines){
      int i = 0;
      for(pos mpos: mposs.ds){
        stroke(255);
        //ellipse(mpos.x, mpos.y, 5, 5);//noshow---------------------------------------------------------------------------------------------------
        if(oldmpos.x != 0){
          //line(oldmpos.x, oldmpos.y, mpos.x, mpos.y);
        }
        pos nmpos = mpos;
        nmpos.x += nmpos.speedx;
        nmpos.y += nmpos.speedy;
        mposs.ds.set(i, nmpos);
        oldmpos = mpos;
        float xs = 0, ys = 0;
        ellipse(mpos.x, 0, 10, 10);
        ellipse(0, mpos.y, 1, 1);
        for(HPP HPPoint: HPPoints){
          float distance = dist(HPPoint.x, HPPoint.y, mpos.x, mpos.y) + 50;
          float angle = atan2(mpos.x - HPPoint.x, mpos.y - HPPoint.y);
          xs += sin(angle) * HPPoint.presre / (distance * HPPoint.decay + 1); 
          ys += cos(angle) * HPPoint.presre / (distance * HPPoint.decay + 1); 
          fill(255);
        }
        line(oldmpos.x, oldmpos.y, mpos.x, mpos.y);
        mpos.speedx = xs;
        mpos.speedy = ys;
        mposs.ds.set(i, mpos);
      i++;
      }
    }
  bezierLine(Lines);
  
}

void mousePressed(){
  Lines = new ArrayList<dataset>();
  pos mpos = new pos();
  mpos.x = mouseX;
  mpos.y = mouseY;
  Lines.add(multiadd(mpos));
}

void setHPP(){//PresreSet---------------------------------------------
  for(int i = 0; i < 100; i++) {
    HPP HPPoint = new HPP();
    HPPoint.x = random(0, width);
    HPPoint.y = random(0, height);
    HPPoint.presre = random(0, 300);
    HPPoint.decay = random(10, 50);
    HPPoints.add(HPPoint);
  }
}

pos mid_point(pos pos0, pos pos1){
  pos npos = new pos();
  npos.x = pos0.x * 0.5f + pos1.x * 0.5f;
  npos.y = pos0.y * 0.5f + pos1.y * 0.5f;
  return npos;
}

void threeP_bezier(pos pos0, pos pos1, pos pos2) { //bezierposition
  noFill();
  bezier(mid_point(pos0, pos1).x, mid_point(pos0, pos1).y, pos1.x, pos1.y, pos1.x, pos1.y, mid_point(pos1, pos2).x, mid_point(pos1, pos2).y);
}

void bezierLine(ArrayList<dataset> Lines){
  int totalline = xline * yline;
  ArrayList<dataset> converteddata = new ArrayList<dataset>();
  for(int y = 0; y < totalline; y++){
    dataset Line = new dataset();
    for(int x = 0; x < Lines.size(); x++){
      pos gpos = new pos();
      dataset getLine = Lines.get(x);
      gpos.x = getLine.ds.get(y).x;
      gpos.y = getLine.ds.get(y).y;
      Line.ds.add(gpos);
    }
    converteddata.add(Line);
  }
  for(int i = 0; i < totalline; i++){
    dataset getline = converteddata.get(i);
    ArrayList<pos> mposs = getline.ds;
    pos pos0 = new pos();
    pos pos1 = new pos();
    pos epos = new pos();
    pos eposbefore = new pos();
    if(mposs.size() == 0){
      //none
    }
    else if(mposs.size() == 1){
      pos0 = mposs.get(0);
      ellipse(pos0.x, pos0.y, 4, 4);
    }
    else if(mposs.size() == 2){
      pos1 = mposs.get(1);
      pos0 = mposs.get(0);
      eposbefore = mposs.get(mposs.size()-1);
      line(pos0.x, pos0.y, pos1.x, pos1.y);
    }
    else if(mposs.size() == 3){
      pos1 = mposs.get(1);
      pos0 = mposs.get(0);
      eposbefore = mposs.get(mposs.size()-1);
      epos = mposs.get(mposs.size()-2);
      //line(pos0.x, pos0.y, mid_point(pos0, pos1).x, mid_point(pos0, pos1).y);
      threeP_bezier(pos0, pos1, epos);
      //line(mid_point(pos1, epos).x, mid_point(pos1, epos).y, epos.x, epos.y);
    }
    else {
      col getcolor = cols.get(i);
      stroke(getcolor.h, getcolor.s, getcolor.b);
      pos1 = mposs.get(1);
      pos0 = mposs.get(0);
      eposbefore = mposs.get(mposs.size()-1);
      epos = mposs.get(mposs.size()-2);
      line(pos0.x, pos0.y, mid_point(pos0, pos1).x, mid_point(pos0, pos1).y);
      line(mid_point(eposbefore, epos).x, mid_point(eposbefore, epos).y, epos.x, epos.y);
      for(int a = 0; a < mposs.size(); a++){
        if(a + 2 < mposs.size()){
          threeP_bezier(mposs.get(a), mposs.get(a + 1), mposs.get(a + 2));
        }
      }
    }
  }
}

class dataset {
  ArrayList<pos> ds = new ArrayList<pos>();
  
}

class col {
  float h = random(190, 210);
  float s = random(0, 255);
  float b = 255;
}

class pos {
  float x, y, speedx, speedy;
}

class HPP{
  float x, y, presre, decay;
}
