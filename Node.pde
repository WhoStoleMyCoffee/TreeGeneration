class Node
{
  PVector pos;
  float w;
  float a;
  int d; // id/distance from the tree's root
  
  Node(PVector pos, float w, float a, int d) {
    this.pos = pos;
    this.w = w;
    this.d = d;
    this.a = PVector.fromAngle(a).add(PVector.mult(tendency, d*tendency_str)).heading();
  }
  
  PVector get_dir() {
    return new PVector(cos(this.a), sin(this.a));
  }
}
