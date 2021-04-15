class Sphere {
  int ptsW, ptsH;
  PImage[] maps;
  PImage img;
  int legend;
  int numPointsW;
  int numPointsH_2pi; 
  int numPointsH;
  float[] coorX;
  float[] coorY;
  float[] coorZ;
  float[] multXZ;

  Sphere(String[] pics, int W, int H) {
    maps = new PImage[pics.length];
    for (int i=1; i<pics.length; i++)  maps[i] = requestImage(pics[i]);
    maps[0] = loadImage(pics[0]);
    ptsW = W;
    ptsH = H;
    legend = 0;
    init(ptsW, ptsH);
  }

  void init(int numPtsW, int numPtsH_2pi) {            // The number of points around the width and height
    numPointsW = numPtsW + 1;
    numPointsH_2pi = numPtsH_2pi;                      // How many actual pts around the sphere (not just from top to bottom)
    numPointsH = ceil((float)numPointsH_2pi / 2) + 1;  // How many pts from top to bottom (abs(....) b/c of the possibility of an odd numPointsH_2pi)
    coorX = new float[numPointsW];                     // All the x-coor in a horizontal circle radius 1
    coorY = new float[numPointsH];                     // All the y-coor in a vertical circle radius 1
    coorZ = new float[numPointsW];                     // All the z-coor in a horizontal circle radius 1
    multXZ = new float[numPointsH];                    // The radius of each horizontal circle (that you will multiply with coorX and coorZ)
    for (int i=0; i<numPointsW; i++) {                 // For all the points around the width
      float thetaW = 2 * PI * i / (numPointsW-1);
      coorX[i] = sin(thetaW);
      coorZ[i] = cos(thetaW);
    }
    
    for (int i=0; i<numPointsH; i++) {                     // For all points from top to bottom
      if (int(numPointsH_2pi / 2) != (float)numPointsH_2pi / 2 && i == numPointsH - 1) {    // If the numPointsH_2pi is odd and it is at the last pt
        float thetaH = (i - 1) * 2 * PI / (numPointsH_2pi);
        coorY[i] = cos(PI + thetaH); 
        multXZ[i] = 0;
      } else {
        float thetaH=i * 2 * PI / (numPointsH_2pi);        //The numPointsH_2pi and 2 below allows there to be a flat bottom if the numPointsH is odd
        coorY[i] = cos(PI + thetaH);                       //PI+ makes the top always the point instead of the bottom.
        multXZ[i] = sin(thetaH);
      }
    }
  }

  void tSphere(float rad, PImage t) {                // These are so we can map certain parts of the image on to the shape 
    float rx = rad;
    float ry = rad;
    float rz = rad;
    float changeU=t.width/(float)(numPointsW-1); 
    float changeV=t.height/(float)(numPointsH-1); 
    float u=0;                                       // Width variable for the texture
    float v=0;                                       // Height variable for the texture
    beginShape(TRIANGLE_STRIP);
    texture(t);
    for (int i=0; i<(numPointsH-1); i++) {           // For all the rings but top and bottom
      float coory = coorY[i];                        // Goes into the array here instead of loop to save time
      float cooryPlus = coorY[i+1];
      float multxz = multXZ[i];
      float multxzPlus = multXZ[i+1];
      for (int j=0; j<numPointsW; j++) {             // For all the pts in the ring
        normal(-coorX[j]*multxz,       -coory,       -coorZ[j]*multxz);
        vertex(coorX[j]*multxz*rx,      coory*ry,     coorZ[j]*multxz*rz,      u, v);
        normal(-coorX[j]*multxzPlus,   -cooryPlus,   -coorZ[j]*multxzPlus);
        vertex(coorX[j]*multxzPlus*rx,  cooryPlus*ry, coorZ[j]*multxzPlus*rz,  u, v+changeV);
        u+=changeU;
      }
      v+=changeV;
      u=0;
    }
    endShape();
  }
}
