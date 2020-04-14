Population test;
Maze maze;
PVector goal = new PVector(250, 20);
boolean DevMode = false;
boolean DarkMode = true;

//TODO: ADD IN THE BEST DOT'S COLOR IN THE CORNER

void setup() {
  size(500, 500);
  test = new Population(1000);
  maze = new Maze(5);
}

void keyPressed() {
  if (key== ' ') {
    if (DevMode) {
      DevMode = false;
    } else {
      DevMode = true;
    }
  }
    if (key == TAB) {
    if (DarkMode) {
      DarkMode = false;
    } else {
      DarkMode = true;
    }
  }
}

void draw() {
  if (DarkMode) {
    background(0);
  } else {
    background(255);
  }
  fill(255, 0, 0);
  stroke(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  if (DevMode) {
    rect(0, 75, 500, 3);
    rect(0, 100, 500, 3);
    rect(0, 50, 500, 3);
  }

  textSize(32);
  if(DarkMode){fill(255);}else{
  fill(0);}
  if (test.gen<10) {
    text("00" + test.gen, 435, 490);
  } else if (test.gen<100) {
    text("0" + test.gen, 435, 490);
  } else {
    text(test.gen, 435, 490);
  }


  if (test.allDotsDead()) {
    //genetic algorithm
    test.calculateFitness();
    test.NaturalSelection();
    test.mutateDemBabies();
  } else {
  }
  maze.update();
  test.update();
  test.show();
}  
