class Dot {
  PVector pos;
  PVector vel;
  PVector acc;
  Brain brain;
  //TODO: MAKE EVERY DOT HAVE A UNIQUE COLOR THAT GRADUALLY BECOME THE SAME COLOR BASED ON HOW DIFFERENT THEIR DNA IS

  boolean dead = false;
  boolean reachedGoal = false;
  boolean isBest = false;

  float fitness = 0;
  float passgateGo = 0;

  Dot() {
    brain = new Brain(400);
    pos = new PVector(width/2, height- 10);
    vel = new PVector(0, 0);
    acc = new PVector(0, 0);
  }

  void show() {
    if (isBest) {
      fill(0, 255, 255);
      stroke(0, 255, 255);
      ellipse(pos.x, pos.y, 4, 4);
    } else { 
      fill(0);
      stroke(0, 0, 0);

      ellipse(pos.x, pos.y, 4, 4);
    }
  }

  void move() {

    if (brain.directions.length > brain.step) {
      acc = brain.directions[brain.step];
      brain.step++;
    } else {
      dead = true;
    }
    vel.add(acc);
    vel.limit(5);
    pos.add(vel);
  }
  boolean touchedObs = false;

  void update() {


    if (!dead && !reachedGoal) {
      move();
      if (pos.x<2|| pos.y<2 || pos.x>width-2 || pos.y>height-2) {
        dead = true;
      } else if (dist(pos.x, pos.y, goal.x, goal.y)<5) {
        //if reached goal
        reachedGoal = true;
      }
    }
    for (int i=0; i<maze.obstacles.length; i++) {
      if (pos.x>maze.obstacles[i].xstart_pos && pos.y>maze.obstacles[i].ystart_pos && pos.x<(maze.obstacles[i].xstart_pos+maze.obstacles[i].obs_width) &&pos.y<(maze.obstacles[i].ystart_pos+maze.obstacles[i].obs_length)) {
        dead = true;
        touchedObs = true;
      } else if ((pos.x>maze.passGate[i].xstart_pos && pos.y>maze.passGate[i].ystart_pos && pos.x<(maze.passGate[i].xstart_pos+maze.passGate[i].obs_width) &&pos.y<(maze.passGate[i].ystart_pos+maze.passGate[i].obs_length)) && test.better) {
        passgateGo *= maze.passGate[i].points;
        maze.passGate[i].visible = false;
      }
    }
  }



  void calculateFitness() {

    if (reachedGoal) {
      fitness = 1.0/16.0 +(100000.0 - passgateGo)/(float)(brain.step * brain.step);
      //TODO: ADD IN A TIMER AND INCREASE FITNESS BASED ON SHORTER TIME
    } else {
      float distanceToGoal = dist(pos.x, pos.y, goal.x, goal.y);
      fitness = 1.0/(distanceToGoal * (distanceToGoal));
      fitness *= 2*(passgateGo);
      fitness *= (600-pos.y)/100;
      if (dist(pos.x, pos.y, (goal.x), (goal.y))<10) {
        fitness *= 5;
      }
      if (pos.y<350) {
        fitness *=5; 
        if (pos.y<250) {
          fitness *= 5; 
          if (pos.y<150) {
            fitness *= 6;
            if (pos.y<100 ) {
              fitness *= 7;
              if (pos.y<75) {
                fitness*=5;
                if (pos.y<50) {
                  fitness *= 10;
                  if (pos.x<350 && pos.x>150) {
                    fitness *=10;
                    if (pos.x<300 && pos.x>200) {
                      fitness *= 10;
                      if (pos.x<275 && pos.x>225) {
                        fitness *=15;
                      }
                    }
                  }
                }
              }
            }
          }
        }
      }
      if (dead) {
        fitness = (1.0)/((distanceToGoal)*((distanceToGoal)));
        fitness /= 100;
        if (test.better) {
          fitness /= 1000;
          if (touchedObs) {
            fitness /= 10000;
          }
        }
      }
    }
    if (pos.y>350) {
      fitness /= pos.y;
      if (touchedObs) {
        fitness /= 10000;
      }
    }
  }
  //----------------------------------------------------------
  //star wars clone wars  
  Dot gimmeBaby() {
    Dot baby = new Dot();
    baby.brain = brain.clone();
    return baby;
  }
}
