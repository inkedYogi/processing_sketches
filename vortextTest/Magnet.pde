class Magnet{
  PVector pos;
  float power;
  color col;
  
  Magnet(PVector pos, float power, color col){
    this.pos = pos;
    this.power = power;
    this.col = col;
  }
  
  void genParticles(float power){
    particles.add(new Particle(pos.copy().add(PVector.random2D().mult(magR-partiR)), power, col)); 
  }
  
  void show(){
    fill(col);
    ellipse(pos.x, pos.y, magR*2, magR*2);
  }
}
