Population test;
Maze maze;
PVector goal = new PVector(250, 20);
boolean DevMode = false;
boolean DarkMode = true;




void setup() {
  size(500, 500);
  test = new Population(1000);
  maze = new Maze(15);
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
  Dot bestDot = test.best();


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
  if (DarkMode) {
    fill(255);
  } else {
    fill(0);
  }
  if (test.gen<10) {
    text("00" + test.gen, 435, 490);
  } else if (test.gen<100) {
    text("0" + test.gen, 435, 490);
  } else {
    text(test.gen, 435, 490);
  }

  textSize(15);
  noStroke();
  text("Best Dot", 2, 12);  

  if (bestDot.timer<10) {
    text("0000" + test.gen, 7, 65);
  } else if (bestDot.timer<100) {
    text("000" + bestDot.timer, 7, 65);
  } else if (bestDot.timer<1000) {
    text("00"+bestDot.timer, 7, 65);
  } else if (bestDot.timer<10000) {
    text("0"+bestDot.timer, 7, 65);
  } else {
    text(bestDot.timer, 7, 65);
  }

  if (test.gen >1) {
    fill(bestDot.dotColor);
  } else {
    noFill();
  }
  ellipse(30, 33, 30, 30);


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
