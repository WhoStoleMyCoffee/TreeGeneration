import controlP5.*;

/*
IMPROVEMENT IDEAS
  - Remove the Leaf class entirely. It can be represented as a 3D vector
    (x, y, s) and its color can be determined using noise.
*/


// * CONFIGS ---------------------------------------
float min_branch_len = 40.0;
float max_branch_len = 80.0;
float branch_len_factor = 0.2; //how much a branch's width influences its length

float root_w = 20; //root node width
float min_d_branch_w = 0.5; //how much the width should change from node to node
float max_d_branch_w = 0.9; // *
float min_branch_w = 1.0; //the smallest allowed branch width

float min_d_angle = -0.15; //how "wobbly" the tree will be
float max_d_angle = 0.15; // *

float branchoff_rate = 0.2; //the likeliness of branching off
float min_branchoff_angle = 0.4; //angle at which to branch off
float max_branchoff_angle = 0.78; // *
float prob_branchoff_right = 0.5; //prob. to branch off to the right vs left
int max_branch_d = 3; //how many branchoffs

PVector tendency = new PVector(0, 0); //which direction the tree will tend to grow in
float tendency_str = 0; //how strong the tendency is (also influenced by the branch's width)

color[] leaf_colors = { //possible leaf colors
  color(255, 170, 0), //brighter orange
  color(255, 150, 0), //orange
  color(240, 137, 0) //darker orange
};
float leaf_branch_max_w = 6.3; //what width should a branch be so that a leaf grows on it
float min_leaf_size = 10; //leaf size
float max_leaf_size = 20; // *
int leaves_amt = 1; //number of leaves to add per branch (also influenced by the branch's width)
// * -----------------------------------------------

boolean show_debug = false; //toggle with G
boolean is_ready = false;
boolean enable_leaves = true;
int tree_seed = 0;

Tree tree;
ControlP5 cp5;


void setup()
{
  size(900, 800);
  
  tree = new Tree(600, 750);
  
  cp5 = new ControlP5(this);
  
  cp5.addNumberbox("d_angle").setRange(0, PI)
    .setMultiplier(0.002)
    .setValue(0.15).linebreak();
  
  
  cp5.addNumberbox("branchoff_rate").setRange(0.0, 2.0)
    .setMultiplier(0.002)
    .setValue(0.2).linebreak();
  
  cp5.addRange("branchoff_angle").setPosition(10, 150).setSize(200, 40)
    .setRange(0, PI)
    .setRangeValues(0.4, 0.78).linebreak();
  
  cp5.addNumberbox("max_branch_d").setRange(0, 5)
    .setMultiplier(0.03)
    .setValue(3);
  
  cp5.addSlider2D("tendency").setPosition(10, 200)
    .setMinMax(-1,-1, 1,1).setValue(0,0);
  cp5.addNumberbox("tendency_str").setPosition(120, 200)
    .setMultiplier(0.002)
    .setRange(0.0, 1.0).setValue(0.0);
  
  cp5.addRange("branch_length").setPosition(10, 350).setSize(200, 40)
    .setRange(0, 200)
    .setRangeValues(40.0, 80.0);
  cp5.addNumberbox("branch_len_factor").setPosition(10, 400)
    .setRange(0.0, 2.0).setMultiplier(0.01)
    .setValue(0.2);
  
  cp5.addToggle("enable_leaves").setPosition(10, 500)
    .setValue(true)
    .setMode(ControlP5.SWITCH);
  cp5.addNumberbox("leaves_amt").setRange(1, 10).setPosition(10, 535)
    .setMultiplier(0.05)
    .setValue(1);
  cp5.addNumberbox("leaf_branch_max_w").setRange(0.0, 80.0).setPosition(100, 535)
    .setMultiplier(0.08)
    .setValue(6.3);
  cp5.addRange("leaf_size").setPosition(10, 580).setSize(200, 40)
    .setRange(1, 50)
    .setRangeValues(10, 20);
}


void draw()
{
  background(220);
  tree.draw();
  
  noStroke();
  fill(113);
  rectMode(CORNER);
  rect(0, 0, 300, height);
  
  textSize(16);
  textAlign(RIGHT, TOP);
  fill(0);
  text("Seed: " + str(tree_seed), width, 0);
  
  if (!is_ready) {
    is_ready = true;
    refresh_tree();
  }
}


void keyPressed()
{
  //if left or right arrow is pressed
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
