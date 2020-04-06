class PassGate {
  int xstart_pos;
  int ystart_pos;
  int obs_length;
  int obs_width;
  int points;

  boolean visible = true;



  PassGate(int xstart_position, int ystart_position, int temp_width, int temp_len) {
    obs_width = temp_width;
    obs_length = temp_len;
    xstart_pos = xstart_position;
    ystart_pos = ystart_position;
  }


  void display() {
    if (DevMode) {
      fill(0);
      stroke(0);
      textSize(12);
      if (visible) {
        text(points, xstart_pos, ystart_pos-2);
      }
    } else {    
      fill(255);
      stroke(255);
    }
    if (visible) {
      rect(xstart_pos, ystart_pos, obs_width, obs_length);
    }
  }
}
