class Emote extends Actor {

  // set y value for win and lose emote, otherwise change x, image, and scale multiplier based on the image
  public Emote(float x, PImage image, float scaleMultiplier) {
    super(x, 240, image, scaleMultiplier);
  }
  // Need it for class to work
  public void act(float deltaTime) {

  }
}
