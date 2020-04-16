class Maze {
  Obstacle[] obstacles;
  PassGate[] passGate;
  int[] allObs;

  //TODO: FIX MAZE GENERATION SO THAT ONLY ONE MAZE PER Y VALUE


  Maze(int size) {
    obstacles=  new Obstacle[size];
    passGate = new PassGate[size];
    allObs = new int[size];
    for (int i = 0; i<obstacles.length; i++) {
      int ypos = (int)random(55, 430);
      while (yposition(ypos)) {
        ypos = (int)random(55, 430);
      }

      append(allObs, ypos);

      obstacles[i] = new Obstacle((int)random(0, 500), ypos, (int)random(1, 350), (int)random(5, 15));
      passGate[i] = new PassGate(0, obstacles[i].ystart_pos, 500, 1);
      passGate[i].points = 500* (500-passGate[i].ystart_pos);
    }
  }

  boolean yposition(int randomint) {

    for (int item=0; item<allObs.length; item++) {
      if ((item +5 > randomint) && (item -5 <randomint)) {
        return true;
      }
    }
    return false;
  }



  void update() {
    for (int i = 0; i<obstacles.length; i++) {
      if (DevMode) {
        passGate[i].display();
      }
    }
    for (int i = 0; i<obstacles.length; i++) {
      obstacles[i].display();
    }
  }
}
