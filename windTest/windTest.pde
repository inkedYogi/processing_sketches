int pSize = 5;//2
float hMult = 1500;//500
float scale = 100;//50 noise scale
float amp = 0.002;//0.002
float blurFac = 0.1;//0.1

Terrain terrain;

void setup(){
  fullScreen(P3D);
  //size(1000, 700, P3D);
  terrain = new Terrain(0);
}

void keyPressed(){
  if(key=='r'){
    terrain = new Terrain(random(10));
  }
}

void draw(){
  background(255);
  translate(0, height/2, -height/2);
  rotateX(radians(30));
  lights();
  noStroke();
  terrain.show();
  terrain.moveEdge(float(frameCount)/100);
  terrain.wind();//contains blur
}

//Utility Functions
float[][] blur(float[][] arr, int blurSize, float fac){
  float[][] gaussMat = getGaussMat(blurSize, blurSize);
  int arrW = arr.length;
  int arrH = arr[0].length;
  float[][] resArr = new float[arrW][arrH];
  for(int x=0; x<arrW; x++){
    for(int y=0; y<arrH; y++){
      float sum = 0;
      for(int i=-blurSize; i<=blurSize; i++){
        for(int j=-blurSize; j<=blurSize; j++){
          int ci0 = constrain(i+x, 0, arrW-1);
          int cj0 = constrain(j+y, 0, arrH-1);
          float f = arr[ci0][cj0];
          int ci = i+blurSize;
          int cj = j+blurSize;
          sum += f*gaussMat[ci][cj];
        }
      }
      resArr[x][y] = sum*fac + arr[x][y]*(1-fac);
    }
  }
  return resArr;
}

float[][] getGaussMat(float sigma, int size){
  float[][] result = new float[size*2+1][size*2+1];
  float sum = 0;
  for(int i = -size; i <= size; i++){
    for(int j = -size; j <= size; j++){
      float r2 = i*i + j*j;
      float gs = gaussF(sigma, r2);
      result[i+size][j+size] = gs;
      sum+=gs;
    }
  }
  //normalize value
  for(int i = -size; i <= size; i++){
    for(int j = -size; j <= size; j++){
      result[i+size][j+size] /= sum;
    }
  }
  return result;
}

float gaussF(float sigma, float x2){
  return exp(-x2/(2*sigma*sigma))/(2*PI*sigma*sigma);
}
