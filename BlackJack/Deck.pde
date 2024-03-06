class Deck extends Actor
{
  // Construct the actor at the start of the program (run once)
  // asks for some parameters for an image, wants to display the card object at the top
  public Deck(float x, float y, PImage image, float scaleMultiplier)
  {
    super(x, y, image, scaleMultiplier);
  }
  // Needed for the class to work
  public void act(float deltaTime)
  {
    
  }
}
