class Population {
  Dot[] dots;
  float fitnessSum;
  int gen = 1;
  int bestDot = 0;
  float[] dotfitness = new float[1000000];


  int minStep = 400;
  boolean better = false;
  boolean sub75, mutation_edits = false;

  Population(int size) {
    dots = new Dot[size];
    int ColorChangeInt = 1;
    for (int i = 0; i<size; i++) {
      dots[i] = new Dot();
      dots[i].setColorChange = ColorChangeInt;
      ColorChangeInt+=1;
      if (ColorChangeInt == 6) {
        ColorChangeInt=1;
      }


      if (gen == 1) {
        dots[i].rgb[0] = (int) random(75, 225);
        dots[i].rgb[1] = (int) random(75, 225);
        dots[i].rgb[2] = (int) random(75, 225);
        dots[i].dotColor = color(dots[i].rgb[0], dots[i].rgb[1], dots[i].rgb[2]);
      }
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

      //TODO: SET DOT COLORS AND THEN CHANGE BASED ON ITERATION NUMBER AHHHHH
      // ACTUALLY MIGHT NOT WORK SINCE ITERATION NUMBER IS BIGGER THAN 255, WHAT NEEDS TO 
      //HAPPEN IS IT GOES BY CATEGORY 1 BY 1 BREAKING IT UP INTO 2 GROUPS, ODD AND EVEN (SUBTRACT && ADD)
      //AND THEN BROKENN UP AGAIN 3 SETS INTO RED GREEN BLUE CATEGORIES

      //---COLOR ALGORITHM-------------

      if (!dots[bestDot].reachedGoal) {
        if (!(newDots[i].rgb[0] < 30 && newDots[i].rgb[0] > 230)) {
          newDots[i].rgb[0] = (int)random(parent.rgb[0]+(100*newDots[i].brain.CurrentMutationRate), parent.rgb[0]-(100*newDots[i].brain.CurrentMutationRate));
        } else { 
          if (newDots[i].rgb[0]<30) {
            newDots[i].rgb[0]+= 50;
          } else {
            newDots[i].rgb[0]-=15;
          }
        }
        if (!(newDots[i].rgb[1] < 30 && newDots[i].rgb[1] > 230)) {
          newDots[i].rgb[1] = (int)random(parent.rgb[1]+(100*newDots[i].brain.CurrentMutationRate), parent.rgb[1]-(100*newDots[i].brain.CurrentMutationRate));
        } else { 
          if (newDots[i].rgb[1]<75) {
            newDots[i].rgb[1]+= 50;
          } else {
            newDots[i].rgb[1]-=15;
          }
        }

        if (!(newDots[i].rgb[2] < 30 && newDots[i].rgb[2] > 230)) {
          newDots[i].rgb[2] = (int)random(parent.rgb[2]+(100*newDots[i].brain.CurrentMutationRate), parent.rgb[2]-(100*newDots[i].brain.CurrentMutationRate));
        } else { 
          if (newDots[i].rgb[2]<75) {
            newDots[i].rgb[2] += 50;
          } else {
            newDots[i].rgb[2] -= 15;
          }
        }
      } else {
        newDots[i].rgb = parent.rgb;
        if ((random(0, 100)<=(100*newDots[i].brain.CurrentMutationRate))||((newDots[i].rgb[0] < 30) && (newDots[i].rgb[1] < 30) && (newDots[i].rgb[2] < 30)) ||  ((newDots[i].rgb[0]-newDots[i].rgb[1]<15)||((newDots[i].rgb[1]-newDots[i].rgb[0]<15)))) {
          int temp = (int)random(1, 3);
          if (temp == 1) {
            newDots[i].rgb[0] = parent.rgb[0] + (int)random(-3, 3);
            newDots[i].rgb[1] = parent.rgb[1];
            newDots[i].rgb[2] = parent.rgb[2] ;
          } else if (temp ==2) {
            newDots[i].rgb[0] = parent.rgb[0] ;
            newDots[i].rgb[1] = parent.rgb[1] + (int)random(-3, 3);
            newDots[i].rgb[2] = parent.rgb[2] ;
          } else {
            newDots[i].rgb[0] = parent.rgb[0] ;
            newDots[i].rgb[1] = parent.rgb[1] ;
            newDots[i].rgb[2] = parent.rgb[2] + (int)random(-3, 3);
          }

          if ((newDots[i].rgb[0] > (newDots[i].rgb[1]-10) && (newDots[i].rgb[0]<newDots[i].rgb[1]+10))) {
            if ((newDots[i].rgb[2] > newDots[i].rgb[2]-10)&&(newDots[i].rgb[2]<newDots[i].rgb[2]+10)) {
              int tempRandom = (int)random(1, 3);
              if (tempRandom == 1) {
                newDots[i].rgb[0] += 30;
              } else if (tempRandom ==2) {
                newDots[i].rgb[1] += 30;
              } else {
                newDots[i].rgb[2] += 30;
              }
            }
          }
        }
      }




      //----------------------

      newDots[i].dotColor = color(newDots[i].rgb[0], newDots[i].rgb[1], newDots[i].rgb[2]);
    }

    dots = newDots.clone();
    gen++;
  }
  //----------------------------------------------------------
  Dot best() {
    return dots[bestDot];
  }

  //----------------------------------------------------------
  void calculateFitnessSum() {
    fitnessSum = 0;
    for (int i =0; i<dots.length; i++) {
      fitnessSum += dots[i].fitness;
    }
    dotfitness[gen] = dots[bestDot].fitness;
    if (gen > 10) {
      if (dotfitness[gen] == dotfitness[gen-1] || dotfitness[gen-1] == dotfitness[gen-2] || dotfitness[gen-2] == dotfitness[gen-3]) {
        mutation_edits = true;
        if (dotfitness[gen] == dotfitness[gen-6] && dotfitness[gen-7] == dotfitness[gen-7] && dotfitness[gen-8] == dotfitness[gen-8] && dotfitness[gen-9] == dotfitness[gen-10]) {
          mutation_edits = false;
          dots[0].fitness *= 100;
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
    int maxIndex = 0;
    for (int i=0; i<dots.length; i++) {
      if (dots[i].fitness > max) {
        max = dots[i].fitness;
        maxIndex = i;
      }
    }
    bestDot = maxIndex;

    if (dots[bestDot].pos.y<75) {
      sub75 = true;
    } else {
      sub75=false;
    }



    if (DevMode && !dots[bestDot].reachedGoal) {
      println("sub75: ", sub75);
      println("mutation_edits: ", mutation_edits);
    }


    if (DevMode) {
      println("fitness: ", dots[bestDot].fitness);
    }


    if (dots[bestDot].reachedGoal) {
      minStep = dots[bestDot].brain.step;
      if (DevMode) {
        println("step: ", minStep);
      }
      better= true;
    }
  }
}
