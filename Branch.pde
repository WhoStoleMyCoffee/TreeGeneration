class Branch
{
  ArrayList<Node> nodes;
  boolean is_done_growing = false;
  float len = 0.0; //total length
  int d;
  
  Branch(Node root, int d) {
    this.nodes = new ArrayList<Node>();
    this.nodes.add(root);
    this.d = d; //branchoff/distance from the tree's root
  }
  
  void draw(float xoff, float yoff)
  {
    stroke(0);
    for (int i=0; i<this.nodes.size()-1; i++) {
      Node n = this.nodes.get(i);
      Node nn = this.nodes.get(i+1);
      strokeWeight(nn.w);
      line(n.pos.x+xoff, n.pos.y+yoff, nn.pos.x+xoff, nn.pos.y+yoff);
    }
    
    //draw nodes
    if (!show_debug) return;
    for (Node n : this.nodes) {
      stroke((this.d*97+150) % 255, (this.d*56+37) % 255, (this.d*120+56) % 255); //random color based on this.d
      strokeWeight(16);
      point(n.pos.x+xoff, n.pos.y+yoff);
      
      stroke(0, 0, 255);
      strokeWeight(2);
      PVector dir = n.get_dir();
      line(n.pos.x+xoff, n.pos.y+yoff, n.pos.x+xoff + dir.x*40, n.pos.y+yoff + dir.y*40);
    }
  }
  
  //returns whether a node was added
  boolean grow_end()
  {
    Node ln = this.end();
    ln.a += random(min_d_angle, max_d_angle);
    return this.grow_end(ln.a);
  }
  
  //returns whether a node was added
  boolean grow_end(float ba)
  {
    Node ln = this.end();
    
    float bw = ln.w * random(min_d_branch_w, max_d_branch_w);
    if (bw <= min_branch_w) return false;
    //branch len     [          random length             ]    [          branch_len_factor           ]
    float blen = max(random(min_branch_len,max_branch_len)  -  (max_branch_len / bw)*branch_len_factor, 0.0);
    if (blen < 5) return false; //haha, magic numbers lmfao
    
    nodes.add(new Node( ln.get_dir().mult(blen).add(ln.pos), bw, ba, ln.d+1 ));
    ln.a = ba;
    len += blen;
    return true;
  }
  
  void grow_leaves(ArrayList<Leaf> leaves)
  {
    for (int i=0; i<this.nodes.size()-1; i++) {
      Node n = this.nodes.get(i);
      if (n.w>leaf_branch_max_w) continue;
      
      int count = int(leaf_branch_max_w - n.w) * leaves_amt;
      for (int k=0; k<count; k++)
        leaves.add(new Leaf(random_point_from_node(i)));
    }
  }
  
  Node get_node(int i) {
    return this.nodes.get(i);
  }
  
  int get_nodes_count() {
    return this.nodes.size();
  }
  
  Node end() {
    return this.nodes.get(this.nodes.size()-1);
  }
  
  //get a random point on the segment (i -> i+1)
  PVector random_point_from_node(int i) {
    Node n = this.nodes.get(i);
    return PVector.add(
      n.pos,
      n.get_dir().mult( random(PVector.dist(n.pos, this.nodes.get(i+1).pos)) )
    );
  }
}
