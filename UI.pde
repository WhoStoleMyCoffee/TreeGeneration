//Just a bunch of ControlP5 related functions
//You can ignore this file

void controlEvent(ControlEvent event) {
  if (event.isFrom("branchoff_angle")) {
    min_branchoff_angle = event.getController().getArrayValue(0);
    max_branchoff_angle = event.getController().getArrayValue(1);
    refresh_tree();
    return;
  } else if (event.isFrom("branch_length")) {
    min_branch_len = event.getController().getArrayValue(0);
    max_branch_len = event.getController().getArrayValue(1);
    refresh_tree();
    return;
  } else if (event.isFrom("leaf_size")) {
    min_leaf_size = event.getController().getArrayValue(0);
    max_leaf_size = event.getController().getArrayValue(1);
    refresh_tree();
    return;
  }
  
  if (event.isFrom("tendency")) {
    tendency.set(event.getController().getArrayValue(0), event.getController().getArrayValue(1)).normalize();
    refresh_tree();
    return;
  }
}

void tendency_str(float v) {
  tendency_str = v;
  refresh_tree();
}


void max_branch_d(int v) {
  max_branch_d = v;
  refresh_tree();
}


void d_angle(float v) {
  min_d_angle = -v;
  max_d_angle = v;
  refresh_tree();
}

void branchoff_rate(float v) {
  branchoff_rate = v;
  refresh_tree();
}

void branch_len_factor(float v) {
  branch_len_factor = v;
  refresh_tree();
}

void enable_leaves(boolean v) {
  enable_leaves = v;
  refresh_tree();
}
void leaves_amt(int v) {
  leaves_amt = v;
  refresh_tree();
}
void leaf_branch_max_w(float v) {
  leaf_branch_max_w = v;
  refresh_tree();
}
