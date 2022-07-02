class Branch
{
  ArrayList<Node> nodes;
  boolean is_done_growing = false;
  int d;
  
  Branch(Node root, int d) {
    this.nodes = new ArrayList<Node>();
    this.nodes.add(root);
    this.d = d;
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
      stroke(255, 0, 255);
      strokeWeight(15);
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
    Node ln = this.nodes.get(this.nodes.size()-1);
    
    float bw = ln.w * random(min_d_branch_w, max_d_branch_w);
    if (bw <= min_branch_w) return false;
    
    float ba = ln.a + random(min_d_angle, max_d_angle);
    ln.a = ba;
    
    grow(ba, bw);
    return true;
  }
  
  void grow(float ba, float bw)
  {
    Node ln = this.nodes.get(this.nodes.size()-1);
    
    float blen = random(min_branch_len, max_branch_len) * (1-exp(-branch_len_factor * bw));
    
    nodes.add(new Node( ln.get_dir().mult(blen).add(ln.pos), bw, ba, ln.d+1 ));
  }
  
  Node get_node(int i) {
    return this.nodes.get(i);
  }
  
  int get_nodes_count() {
    return this.nodes.size();
  }
}
