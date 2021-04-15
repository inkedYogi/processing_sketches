class Link {
  Node A, B;
  
  Link(Node a, Node b) {
    A = a;
    B = b;
  }
  
  void disp() {
   push();
   stroke(0);
   strokeWeight(2);
   line(A.pos.x, A.pos.y, B.pos.x, B.pos.y); 
   pop();
  }
  
  boolean eq(Node U, Node V) {
    if (U.eq(A) || U.eq(B))
      if (V.eq(A) || V.eq(B))
        if (!U.eq(V))  
          return true;
    return false;
  }
}
