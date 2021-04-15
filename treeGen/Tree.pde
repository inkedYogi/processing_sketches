class Tree {
  ArrayList<Node> nodes;
  ArrayList<Link> links;

  Node root;
  ArrayList<Node> leafs;
  ArrayList<Node> branches;

  Tree() {
    nodes = new ArrayList<Node>();
    links = new ArrayList<Link>();
    leafs = new ArrayList<Node>();
    branches = new ArrayList<Node>();

    root = new Node(0);
    root.mass = 10000;
    nodes.add(root);
    leafs.add(root);
  }

  void update() {
    if (nodes.size() > 1) {
      //ArrayList<Link> antiLinks = new ArrayList<Link>();
      //for (Link l : antiLinks) { 
      //  l.update();
      //  stroke(255);
      //  line(l.base.pos.x, l.base.pos.y, l.tip.pos.x, l.tip.pos.y);
      //}
      for (Link l : links)  l.update();
    }
  }

  void disp() {
    for (Link l : links)  l.disp();
    for (Node n : nodes)  n.disp();
  }

  void grow(Node L, Node G) {
    leafs.remove(L);            //remove leaf node from leafs
    links.add(new Link(L, G));  //link leaf node to new node
    leafs.add(G);               //add new node to leafs
    nodes.add(G);
    G.generation = L.generation+1;
    if (L.offspring==1)  branches.add(L);
    L.offspring++;
  }  

  void grow(Node L, Node A, Node B) {
    leafs.remove(L);            //remove leaf node from leafs
    branches.add(L);            //add leaf node to branches
    links.add(new Link(L, A));   //link leaf node to A node
    links.add(new Link(L, B));   //link leaf node to B node
    leafs.add(A);               //add A to leafs
    leafs.add(B);               //add B to leafs
    nodes.add(A);
    nodes.add(B);
    A.generation = L.generation+1;
    B.generation = L.generation+1;
    L.offspring++;
    L.offspring++;
  }

  void insert() {
    //remove link between A and B
    //inserting node = C
    //create link between A,C
    //create link between C,B
    //new sequence is ACB!
  }

  void repel(ArrayList<Node> L) {
    PVector rest = new PVector(0, 0);
    for (Node n : L)  rest.add(n.pos); 
    rest.mult(1/L.size());
  }
}
