// A World is where the Actors are able to interact with one-another.
// For most games, you will only need one World.
class MainWorld extends World {
  // array lists
  ArrayList < Card > deck, playerHand, computerHand;
  // number of cards and total value of cards
  int playerTotal;
  int playerNumberOfCards = 0;
  int computerTotal;
  int computerNumberOfCards = 0;
  // indicates if parts of the game are finished yet
  boolean playerTurnOver = false;
  boolean gameOver = false;
  // prevents printing the result multiple times
  boolean print = false;
  // text result
  String result;
  // shift after pulling a card for the Gui class
  int playerShift;
  int computerShift;

  public MainWorld(int x, int y) {
    super(x, y, loadImage("Sprites/MainWorld.png"));
    deck = new ArrayList < Card > ();
    playerHand = new ArrayList < Card > ();
    computerHand = new ArrayList < Card > ();
  }
  // Run once when the world is loaded
  // World positions are measured in pixels from the top left to the bottom right
  public void prepare() {
    // Make all the cards by using an individual for loop for each
    // The ace is not 1 or 11, it is only 1
    for (int i = 1; i <= 13; i++) {
      if (i <= 10) {
        deck.add(new Card("Hearts", i, i));
        deck.add(new Card("Clubs", i, i));
        deck.add(new Card("Diamonds", i, i));
        deck.add(new Card("Spades", i, i));
      } else {
        deck.add(new Card("Hearts", 10, i));
        deck.add(new Card("Clubs", 10, i));
        deck.add(new Card("Diamonds", 10, i));
        deck.add(new Card("Spades", 10, i));
      }
    }

    // For every card that is added at the very beginning of the game, choose randomly from the deck and add 1 to the number of cards variable
    for (int i = 0; i < 2; i++) {
      int k = (int) random(0, deck.size() - 1);
      playerHand.add(deck.remove(k));
      playerNumberOfCards += 1;
      int j = (int) random(0, deck.size() - 1);
      computerHand.add(deck.remove(j));
      computerNumberOfCards += 1;
    }
    // create the objects for each card, display them, and add their value to their hand total
    for (int i = 0; i <= playerHand.size() - 1; i++) {
      Card c1 = playerHand.get(i);
      c1.setLocation(150 + (i * 30), 400);
      addObject(c1);
      playerTotal += playerHand.get(i).getValue();
    }
    // same as above for computer
    for (int i = 0; i <= computerHand.size() - 1; i++) {
      Card c2 = computerHand.get(i);
      c2.setLocation(550 + (i * 30), 400);
      addObject(c2);
      computerTotal += computerHand.get(i).getValue();
    }

    System.out.println("Player Hand Value: " + playerTotal);
    System.out.println("Computer Hand Value: " + computerTotal);

    // Basically just allows Deck and Gui to appear
    Deck d = new Deck(400, 100, loadImage("Sprites/cardBack_red2.png"), 0.77);
    addObject(d);
    Gui g = new Gui();
    addObject(g);

  }

  // Run every frame - this is where you might do things that aren't tied to a specific Actor, like handling scores
  public void act(float deltaTime) {
    // hit h key to hit if player total is less than 21 and if the player's turn is still going
    if (green.isKeyDownThisFrame('h') == true && playerTotal < 21 && playerTurnOver == false) {
      // add a card with the playerHit() method, add the object and display it, add it to the hand value, add it to the amount of cards variable, change the shift for Gui
      playerHit();
      Card c10 = playerHand.get(playerNumberOfCards);
      c10.setLocation(150 + (playerNumberOfCards * 30), 400);
      addObject(c10);
      playerTotal += playerHand.get(playerNumberOfCards).getValue();
      playerNumberOfCards += 1;
      System.out.println("Player Hand Value: " + playerTotal);
      playerShift += 15;
    }
    // hit s key to stand or if the player's total is over 21, end their turn and go to the computer
    if (green.isKeyDownThisFrame('s') == true || playerTotal > 21) {
      playerTurnOver = true;
    }
    if (playerTurnOver == true) {
      // computer hits until at 17 or above
      while (computerTotal < 17) {
        // same code as above for player
        computerHit();
        Card c6 = computerHand.get(computerNumberOfCards);
        c6.setLocation(550 + (computerNumberOfCards * 30), 400);
        addObject(c6);
        computerTotal += computerHand.get(computerNumberOfCards).getValue();
        computerNumberOfCards += 1;
        System.out.println("Computer Hand Value: " + computerTotal);
        computerShift += 15;
      }
      // if the computer gets 17 or more, the game is over and the scores are compared
      if (computerTotal >= 17) {
        gameOver = true;
      }
    }
    // compares scores by calling winConditions(), check the method at the bottom
    winConditions();
    // makes four objects, two for wins, two for loses
    Emote win1 = new Emote(100, loadImage("Sprites/award.png"), 0.05);
    Emote win2 = new Emote(700, loadImage("Sprites/award.png"), 0.05);
    Emote lose1 = new Emote(100, loadImage("Sprites/sad.png"), 0.2);
    Emote lose2 = new Emote(700, loadImage("Sprites/sad.png"), 0.2);
    // if the game is over
    if (gameOver == true) {
      // if the player won, add and display the win emotes
      if (playerTotal <= 21 && computerTotal <= 21 && playerTotal > computerTotal) {
        addObject(win1);
        addObject(win2);
      } else if (playerTotal <= 21 && computerTotal > 21) {
        addObject(win1);
        addObject(win2);
      }
      // if the computer won, add and display the lose emotes
      else if (playerTotal <= 21 && computerTotal <= 21 && playerTotal < computerTotal) {
        addObject(lose1);
        addObject(lose2);
      } else if (playerTotal > 21 && computerTotal <= 21) {
        addObject(lose1);
        addObject(lose2);
      } else if (playerTotal > 21 && computerTotal > 21) {
        addObject(lose1);
        addObject(lose2);
      }
    }

  }
  // method for all win conditions
  public void winConditions() {
    // when the game is over
    while (gameOver == true && print == false) {
      // if nobody has busted, whoever has the higher number wins, ties if it's a tie
      if (playerTotal <= 21 && computerTotal <= 21) {
        if (playerTotal > computerTotal) {
          result = "You Win";
          System.out.println(result);
          print = true;
        } else if (playerTotal < computerTotal) {
          result = "You Lose";
          System.out.println(result);
          print = true;
        } else if (playerTotal == computerTotal) {
          result = "Tie";
          System.out.println(result);
          print = true;
        }
      }
      // if the player busts and the computer doesn't, the computer wins
      else if (playerTotal > 21 && computerTotal <= 21) {
        result = "You Lose";
        System.out.println(result);
        print = true;
      }
      // vice versa of what is above
      else if (playerTotal <= 21 && computerTotal > 21) {
        result = "You Win";
        System.out.println(result);
        print = true;
      }
      // if both players bust, they both lose
      else if (computerTotal > 21 && playerTotal > 21) {
        result = "You Lose";
        System.out.println(result);
        print = true;
      }
    }

  }
  // methods for adding cards from the deck to the two hands
  public void playerHit() {
    int a = (int) random(0, deck.size() - 1);
    playerHand.add(deck.remove(a));
  }
  public void computerHit() {
    int b = (int) random(0, deck.size() - 1);
    computerHand.add(deck.remove(b));
  }

  // a bunch of get methods for other classes to access
  public int getPlayerTotal() {
    return playerTotal;
  }
  public int getComputerTotal() {
    return computerTotal;
  }

  public int getPlayerShift() {
    return playerShift;
  }
  public int getComputerShift() {
    return computerShift;
  }

  public String getResult() {
    return result;
  }
  public boolean getGameOver() {
    return gameOver;
  }

}
