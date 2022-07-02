class Tree
{
  PVector pos;
  int nodes_count;
  ArrayList<Branch> branches;
  
  Tree(float x, float y)
  {
    this.pos = new PVector(x, y);
    this.branches = new ArrayList<Branch>();
  }
  
  void draw()
  {
    for (Branch b : this.branches) {
      b.draw(this.pos.x, this.pos.y);
    }
  }
  
  void generate()
  {
    this.branches.clear();
    this.branches.add(new Branch( new Node(0,0, root_w, -HALF_PI, 0) , 0)); // the main log
    
    for (int k=0; k<10; k++)
    {
      for (int i=this.branches.size()-1; i>-1; i--) {
        Branch b = this.branches.get(i);
        if (b.is_done_growing) break;
        
        while ( b.grow_end() ) {} //grow branch
        if (b.d < max_branch_d)
          branch_off(b);
        b.is_done_growing = true;
      }
    }
  }
  
  Branch get_branch(int i) {
    return this.branches.get(i);
  }
  
  void branch_off(Branch b) {
    for (int ni=0; ni<b.get_nodes_count()-1; ni++) {
      Node n = b.get_node(ni);
      
      //float prob = map(ni, 0, b.get_nodes_count(), 0, prob_branchoff);
      float prob = n.d * branchoff_rate;
      if (random(1) > prob) continue;
      
      float bw = n.w * random(min_d_branch_w, max_d_branch_w);
      if (bw <= min_branch_w) continue;
      int side = random(1)<prob_branchoff_right ? 1 : -1;
      float ba = n.a + random(min_branchoff_angle, max_branchoff_angle)*side;
      
      //Branch bo = new Branch(new Node( n.pos, bw, ba, n.d+1), b.d+1);
      Branch bo = new Branch(n, b.d+1);
      bo.grow(ba, bw);
      this.branches.add(bo);
    }
  }
}
