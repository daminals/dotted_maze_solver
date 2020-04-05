class Maze {
  Obstacle[] obstacles;
  PassGate[] passGate;
  
  //TODO: FIX MAZE GENERATION SO THAT ONLY ONE MAZE PER Y VALUE


  Maze(int size) {
    obstacles=  new Obstacle[size];
    passGate = new PassGate[size];
    for (int i = 0; i<obstacles.length; i++) {
      obstacles[i] = new Obstacle((int)random(0, 500), (int)random(55, 430), (int)random(1, 350), (int)random(5, 15));
      passGate[i] = new PassGate(0, obstacles[i].ystart_pos, 500, 1);
      passGate[i].points = 150* (500-passGate[i].ystart_pos);
    }
  }


  void update() {
    for (int i = 0; i<obstacles.length; i++) {
      passGate[i].display();
    }
    for (int i = 0; i<obstacles.length; i++) {
      obstacles[i].display();
    }
  }
}
