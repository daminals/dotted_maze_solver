class Brain {

  PVector[] directions;
  int step = 0;

  Brain(int size) {
    directions = new PVector[size];
    randomize();
  }

  //----------------------------------------------------------

  void randomize() {
    for (int i = 0; i< directions.length; i++) {
      float randomAngle = random(2*PI);
      directions[i] = PVector.fromAngle(randomAngle);
    }
  }
  //----------------------------------------------------------
  Brain clone() {
    Brain clone = new Brain(directions.length);
    for (int i = 0; i<directions.length; i++) {
      clone.directions[i] = directions[i].copy();
    }
    return clone;
  }
  //----------------------------------------------------------
  void mutate() {

    float mutationRate = 0.2;
    if (test.sub50 || test.mutation_edits) {
      mutationRate=0.007;
    }
    if (test.better) {
      mutationRate=0.005;
    }
    for (int i=0; i<directions.length; i++) {
      float rand = random(1);
      if (rand < mutationRate) {
        //set this direction as a random direction
        float randomAngle = random(2*PI);
        directions[i] = PVector.fromAngle(randomAngle);
      }
    }
  }
}
