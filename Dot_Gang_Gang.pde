Population test;
Maze maze;
PVector goal = new PVector(250, 20);
boolean DevMode = false;

void setup() {
  size(500, 500);
  test = new Population(1000);
  maze = new Maze(15);
}

void draw() {
  background(255);
  fill(255, 0, 0);
  stroke(255, 0, 0);
  ellipse(goal.x, goal.y, 10, 10);
  
  textSize(32);
  fill(0);
  text(test.gen, 445,490);


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
