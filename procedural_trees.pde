import controlP5.*;

float min_branch_len = 40.0;
float max_branch_len = 80.0;
float branch_len_factor = 0.8;

float root_w = 20;
float min_d_branch_w = 0.5;
float max_d_branch_w = 0.9;
float min_branch_w = 1.0;

float min_d_angle = -0.15;
float max_d_angle = 0.15;

float branchoff_rate = 0.2;
float min_branchoff_angle = 0.4;
float max_branchoff_angle = 0.78;
float prob_branchoff_right = 0.5; //prob. to branch off to the right vs left
int max_branch_d = 3;

PVector tendency = new PVector(0, -0.1);
float tendency_str = 0;

boolean show_debug = false;
boolean is_ready = false;
int tree_seed = 0;

Tree tree;
ControlP5 cp5;


void setup()
{
  size(900, 800);
  
  tree = new Tree(600, 800);
  tree_seed = 0;
  refresh_tree();
  
  cp5 = new ControlP5(this);
  
  cp5.addNumberbox("d_angle").setRange(0, PI)
    .setMultiplier(0.002)
    .setValue(0.15).linebreak();
  
  
  cp5.addNumberbox("branchoff_rate").setRange(0.0, 1.0)
    .setMultiplier(0.002)
    .setValue(0.2).linebreak();
  
  cp5.addRange("branchoff_angle").setPosition(10, 150).setSize(200, 40)
    .setRange(0, PI)
    .setRangeValues(0.4, 0.78).linebreak();
  
  cp5.addNumberbox("max_branch_d").setRange(0, 5)
    .setMultiplier(0.03)
    .setValue(2);
  
  cp5.addSlider2D("tendency").setPosition(10, 200)
    .setMinMax(-1,-1, 1,1).setValue(0,0);
  cp5.addNumberbox("tendency_str").setPosition(120, 200)
    .setMultiplier(0.002)
    .setRange(0.0, 1.0).setValue(0.1);
}


void draw()
{
  background(220);
  tree.draw();
  
  noStroke();
  fill(113);
  rect(0, 0, 300, height);
  
  textSize(16);
  textAlign(RIGHT, TOP);
  fill(0);
  text("Seed: " + str(tree_seed), width, 0);
  
  if (!is_ready) is_ready = true;
}


void keyPressed()
{
  if (keyCode == 39 || keyCode == 37) {
    tree_seed += int(keyCode==39) - int(keyCode==37);
    randomSeed(tree_seed);
    tree.generate();
  }
  
  if (key == 'g') {
    show_debug = !show_debug;
  }
}


void refresh_tree() {
  if (!is_ready) return;
  randomSeed(tree_seed);
  tree.generate();
}
