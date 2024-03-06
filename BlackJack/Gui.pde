public class Gui extends Actor {
  // Constructor sets the origin of draw at (0,0), so I can basically use draw normally rather then drawing based on a different coordinate
  Gui() {
    super(0, 0, 0, 0);
  }
  // Need it in this class to work
  public void act(float deltaTime) {

  }
  // Overrides the other draw() in the main file named BlackJack
  public void draw() {
    // basically just draws the rectangles, scores, and winners 
    // colors
    color white = color(255, 255, 255);
    color black = color(0, 0, 0);
    // all text is centered
    textAlign(CENTER);
    fill(black);
    rect(95, 480, 140 + (2 * world.getPlayerShift()), 90);
    rect(495, 480, 140 + (2 * world.getComputerShift()), 90);
    fill(white);
    rect(105, 490, 120 + (2 * world.getPlayerShift()), 70);
    rect(505, 490, 120 + (2 * world.getComputerShift()), 70);
    textSize(20);
    fill(black);
    text("Press 'h' to hit", 175, 100);
    text("Press 's' to stand", 575, 100);
    // everytime a card is picked up, playerShift increases in MainWorld so expands text box and shifts text over
    text("You", 165 + world.getPlayerShift(), 510);
    text(world.getPlayerTotal(), 165 + world.getPlayerShift(), 530);
    // checks for if the player busts or not
    if (world.getPlayerTotal() <= 21) {
      text("Safe", 165 + world.getPlayerShift(), 550);
    } else {
      text("Bust", 165 + world.getPlayerShift(), 550);
    }
    text("Dealer", 565 + world.getComputerShift(), 510);
    text(world.getComputerTotal(), 565 + world.getComputerShift(), 530);
    // checks for if the computer busts or not
    if (world.getComputerTotal() <= 21) {
      text("Safe", 565 + world.getComputerShift(), 550);
    } else {
      text("Bust", 565 + world.getComputerShift(), 550);
    }
    // if the end of the game occurs, print the result that is in winConditions()
    if (world.getGameOver() == true) {
      textSize(120);
      text(world.getResult(), 400, 280);
    }
  }
}
