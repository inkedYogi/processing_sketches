class Link {
  Node base, tip;
  float d;
  
  PVector params;
    //params.x ideal length
    //params.y stiffness coeff

  Link(Node A, Node B) {
    base = A;
    tip = B;
    params = new PVector(50, -.005);
  }
  
  void update() {
   d = dist(base.pos.x, base.pos.y, tip.pos.x, tip.pos.y);
   PVector midP = base.pos.copy();
   midP.add(tip.pos);
   midP.mult(.5);
   PVector dBase = base.pos.copy();
   dBase.sub(midP);
   dBase.mult(params.y*(d-params.x));
   dBase.mult(.5);
   PVector dTip = tip.pos.copy();
   dTip.sub(midP);
   dTip.mult(params.y*(d-params.x));
   dTip.mult(.5);
   base.addForce(dBase);
   tip.addForce(dTip);
   base.update();
   tip.update();
  }
  
  void disp() {
   push();
   stroke(0);
   strokeWeight(2);
   line(base.pos.x, base.pos.y, tip.pos.x, tip.pos.y); 
   pop();
  }

  boolean eq(Node U, Node V) {
    if (U.eq(base) || U.eq(tip))
      if (V.eq(base) || V.eq(tip))
        if (!U.eq(V))  
          return true;
    return false;
  }
}
