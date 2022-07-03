class Leaf
{
  PVector pos;
  int ci; //color index (in leaf_colors)
  float s; //size
  
  Leaf(PVector p)
  {
    this.s = random(min_leaf_size, max_leaf_size);
    this.pos = p.add(random(-0.5,0.5)*this.s, random(-0.5,0.5)*this.s);
    this.ci = floor(random(leaf_colors.length));
  }
  
  void draw(float xoff, float yoff)
  {
    fill(leaf_colors[this.ci]);
    square(this.pos.x+xoff, this.pos.y+yoff, this.s);
  }
}
