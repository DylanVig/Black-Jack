public class Card extends Actor{
  // variables for suit, number, value
  // important for getting the right card from the sprites folder
  String suit;
  // important for adding up score in each hand
  int value;
  // important for getting the right card from the sprites folder, different from value because face cards value is 10 but the number is different
  int number;
  
  // Constructor that displays the card as well as gives each card a suit, number, and value
  public Card(String suit, int value, int number){
    super(0,0,loadImage("Sprites/card" + suit + number + ".png"),100,150);
    this.suit = suit;
    this.value = value;
    this.number = number;
  }
  // get method for value in MainWorld
  public int getValue(){
    return value;
  }
  // Need it in the class to work
  public void act(float deltaTime)
  {
    
  }
}
