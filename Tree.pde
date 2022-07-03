class Tree
{
  PVector pos; //pos of the root
  ArrayList<Branch> branches;
  ArrayList<Leaf> leaves; //yes, leaves are stored here
  
  Tree(float x, float y)
  {
    this.pos = new PVector(x, y);
    this.branches = new ArrayList<Branch>();
    this.leaves = new ArrayList<Leaf>();
  }
  
  void draw()
  {
    for (Branch b : this.branches) {
      b.draw(this.pos.x, this.pos.y);
    }
    
    if (!enable_leaves) return;
    noStroke();
    rectMode(CENTER);
    for (Leaf l : this.leaves) {
      l.draw(this.pos.x, this.pos.y);
    }
  }
  
  void generate()
  {
    this.branches.clear();
    this.leaves.clear();
    this.branches.add(new Branch( new Node(new PVector(), root_w, -HALF_PI, 0) , 0)); //root
    
    //we loop  k  to let all the branches grow
    for (int k=0; k<max_branch_d; k++)
    {
      //loop branches backwards and grow all currently existing branches
      for (int i=this.branches.size()-1; i>-1; i--) {
        Branch b = this.branches.get(i);
        //if this branch is done growing, then we know that all the previous branches are also done growing
        if (b.is_done_growing) break;
        
        while ( b.grow_end() ) {} //grow branch
        if (b.d < max_branch_d)
          branch_off(b);
        
        b.is_done_growing = true;
      }
    }
    
    //remove unneccessary branches
    // couldn't find a better solution to this  ( ;-;)_
    for (int i=this.branches.size()-1; i>-1; i--) {
      if (this.get_branch(i).get_nodes_count() < 3) {
        this.branches.remove(i);
        continue;
      }
      
      if (enable_leaves)
        this.get_branch(i).grow_leaves(this.leaves);
    }
  }
  
  Branch get_branch(int i) {
    return this.branches.get(i);
  }
  
  void branch_off(Branch b) {
    //we loop until  get_nodes_count()-2  because we want this branch to end with an akward branchoff
    for (int ni=0; ni<b.get_nodes_count()-2; ni++) {
      Node n = b.get_node(ni);
      
      float prob = n.d * branchoff_rate;
      if (random(1) > prob) continue;
      
      int side = random(1)<prob_branchoff_right ? 1 : -1;
      float ba = n.a + random(min_branchoff_angle, max_branchoff_angle)*side;
      
      Branch bo = new Branch(new Node(b.random_point_from_node(ni), n.w, ba, n.d+1), b.d+1);
      this.branches.add(bo);
    }
  }
}
