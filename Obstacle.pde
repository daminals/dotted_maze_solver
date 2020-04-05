class Obstacle {
  int xstart_pos;
  int ystart_pos;
  int obs_length;
  int obs_width;



  Obstacle(int xstart_position, int ystart_position, int temp_width, int temp_len) {
    obs_width = temp_width;
    obs_length = temp_len;
    xstart_pos = xstart_position;
    ystart_pos = ystart_position;
  }


  void display() {
    fill(0, 0, 255);
    stroke(0, 0, 255);
    rect(xstart_pos, ystart_pos, obs_width, obs_length);
  }
}
