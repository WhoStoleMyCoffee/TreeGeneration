class Node
{
  PVector pos;
  float w;
  float a;
  int d; // id/dist to root
  
  Node(float x, float y, float w, float a, int d) {
    this.pos = new PVector(x, y);
    this.w = w;
    this.d = d;
    this.a = PVector.fromAngle(a).add(PVector.mult(tendency, d*tendency_str)).heading();
  }
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
