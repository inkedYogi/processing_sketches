class Tree {
  ArrayList<Node> nodes;
  ArrayList<Link> links;
  ArrayList<Node> leafs;
  Node root;
  int maxGen;

  Tree() {
    nodes = new ArrayList<Node>();
    links = new ArrayList<Link>();
    leafs = new ArrayList<Node>();
    root = new Node();
    root.id = 0;
    nodes.add(root);
    leafs.add(root);
    root.pos.set(width/4, 25);
  }

  void update() {
  }

  void disp() {
    for (Link l : links)  l.disp();
    for (Node n : nodes)  n.disp();
  }

  void addSingle(Node M, Node N) {
    boolean ok = true;
    for (Node n : nodes) if (N.pos.copy().sub(n.pos).mag()==0) ok=false;
    if (M.generation < maxGen) {
      if (ok) {
        nodes.add(N);
        links.add(new Link(M, N));
        N.id = nodes.size()-1;
        N.generation = M.generation+1;
        leafs.remove(M);
        leafs.add(N);
      }
    }
  }

  void addDouble(Node M, Node N, Node W) {
    boolean ok = true;
    for (Node n : nodes) if (N.pos.copy().sub(n.pos).mag()==0) ok=false;
    if (M.generation < maxGen) {
      if (ok) {
        nodes.add(N);
        links.add(new Link(M, N));
        N.id = nodes.size()-1;
        N.generation = M.generation+1;
        leafs.remove(M);
        leafs.add(N);
      }
    }
    ok = true;
    for (Node n : nodes) if (W.pos.copy().sub(n.pos).mag()==0) ok=false;
    if (M.generation < maxGen) {
      if (ok) {
        nodes.add(W);
        links.add(new Link(M, W));
        W.id = nodes.size()-1;
        W.generation = M.generation+1;
        leafs.remove(M);
        leafs.add(W);
      }
    }
  }
  
  void popNode(Node N) {
    leafs.remove(N);
    nodes.remove(N);
    for (Link l : links)  if (l.A==N || l.B==N)  links.remove(l);
  }

  void tree2Mat() {
    int n = nodes.size();
    int[][] M = new int[n][n];

    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        M[i][j] = 0;
      }
    }

    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        Node a = nodes.get(i);
        Node b = nodes.get(j);
        for (Link l : links) {
          if (l.eq(a, b)) {
            M[i][j] = 1;
            M[j][i] = 1;
          }
        }
        if (i==j)  M[i][j] = 1;
      }
    }


    for (int i=0; i<n; i++) {
      for (int j=0; j<n; j++) {
        print(M[i][j]+" ");
      }
      println();
    }
  }

  Tree copy() {
    Tree T = new Tree();
    for (Node n : nodes)  T.nodes.add(n);
    for (Link l : links)  T.links.add(l);
    for (Node f : leafs)  T.nodes.add(f);
    T.maxGen = this.maxGen;
    return T;
  }
}
