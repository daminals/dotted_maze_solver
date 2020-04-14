class Brain {
  float CurrentMutationRate = 0.2;
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
    //TODO: SPLIT INTO GROUPS ONE WITH HIGH MUTATION RATE AND ONE WITH LOW

    float mutationRate = 0.2;
    if (test.gen<4) {
      mutationRate=0.75;
    }
    if (test.sub75 || test.mutation_edits) {
      mutationRate=0.007;
    }
    if (test.better) {
      mutationRate=0.015;
    }
    CurrentMutationRate = mutationRate;

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
