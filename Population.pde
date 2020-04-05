class Population {
  Dot[] dots;
  float fitnessSum;
  int gen = 1;
  int bestDot = 0;
  float[] dotfitness = new float[1000000];


  int minStep = 400;
  boolean better = false;
  boolean sub50, mutation_edits = false;

  Population(int size) {
    dots = new Dot[size];
    for (int i = 0; i<size; i++) {
      dots[i] = new Dot();
    }
  }

  //----------------------------------------------------------

  void show() {
    for (int i =0; i<dots.length; i++)
      dots[i].show();

    dots[0].show();
  }
  //----------------------------------------------------------

  void update() {
    for (int i = 0; i<dots.length; i++) {
      if (dots[i].brain.step > minStep) {
        dots[i].dead = true;
      } else {
        dots[i].update();
      }
    }
  }
  //----------------------------------------------------------

  void calculateFitness() {
    for (int i = 0; i<dots.length; i++) {
      dots[i].calculateFitness();
    }
  }
  //----------------------------------------------------------
  boolean allDotsDead() {
    for (int i = 0; i<dots.length; i++) {
      if (!dots[i].dead && !dots[i].reachedGoal) {
        return false;
      }
    }
    for (int i=0; i<maze.obstacles.length; i++) {
      maze.passGate[i].visible = true;
    }

    return true;
  }
  //----------------------------------------------------------
  void NaturalSelection() {
    Dot[] newDots = new Dot[dots.length];
    setBestDot();
    calculateFitnessSum();

    newDots[0] = dots[bestDot].gimmeBaby();
    newDots[0].isBest = true;
    for (int i = 1; i<newDots.length; i++) {
      //start at one so we dont overwrite newdot[0]

      //select parent based on fitness
      Dot parent = selectParent();

      //get baby from the parent
      newDots[i] = parent.gimmeBaby();
    }

    dots = newDots.clone();
    gen++;
  }
  //----------------------------------------------------------
  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i =0; i<dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
    dotfitness[gen] = dots[bestDot].fitness;
    if (gen > 5) {
      if (dotfitness[gen] == dotfitness[gen-1] || dotfitness[gen-1] == dotfitness[gen-2] || dotfitness[gen-2] == dotfitness[gen-3]) {
        mutation_edits = true;
        if (dotfitness[gen] == dotfitness[gen-1] && dotfitness[gen-1] == dotfitness[gen-2] && dotfitness[gen-2] == dotfitness[gen-3] && dotfitness[gen-3] == dotfitness[gen-4]) {
          mutation_edits = false;
        }
      } else {
        mutation_edits = false;
      }
    }
  }
  //----------------------------------------------------------

  Dot selectParent() {
    float rand = random(fitnessSum);

    float runningSum = 0;
    for (int i = 0; i<dots.length; i++) {
      runningSum += dots[i].fitness;
      if (runningSum>rand) {
        return dots[i];
      }
    }
    //should never get to this point

    return null;
  }  
  //----------------------------------------------------------

  void mutateDemBabies() {
    for (int i = 1; i<dots.length; i++) {
      dots[i].brain.mutate();
    }
  }  
  //----------------------------------------------------------  
  void setBestDot() {

    float max = 0;
    int maxIndex =0;
    for (int i=0; i<dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;

    if (dots[bestDot].pos.y<50) {
      sub50 = true;
    } else {
      sub50=false;
    }



    if (DevMode && !dots[bestDot].reachedGoal) {
      println("sub50: ", sub50);
      println("mutation_edits: ", mutation_edits);
    }


    if (DevMode) {
      println("fitness: ", dots[bestDot].fitness);
    }


    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
      println("step: ", minStep);
      better= true;
    }
  }
}
