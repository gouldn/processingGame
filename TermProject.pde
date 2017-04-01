/** Nathan Gould
    CSC220 - 03
    Lab 4 */
    
/* This program will create a grid of between 10-30 randomly sized squares
   (size between 10-30) of random colors. When the user clicks the mouse
   the row and column in which the mouse was pressed will change their
   color to other random colors */

import controlP5.*;
ControlP5 controlp5;
Board board;

// 2-D array storing the RGB values of 4 separate colors
int[][] colors = {{255,0,0}, {0,255,0}, {0,0,255}, {255,255,0}};

void settings() {
  
  // Draw the initial canvas
  size((int)random(600,1000),(int)random(600,1000));

}

void setup() {
  
  // Set the board size to be random - could change depending on the size of the screen
  int BOARD_SIZE = (int)random(250,420);
  
  // Set up the UI elements
  controlp5 = new ControlP5(this);
  DropdownList d1 = controlp5.addDropdownList("name").setPosition((width-BOARD_SIZE)/2,((height-BOARD_SIZE)/2+BOARD_SIZE)+20);
  customize(d1);
  
  // Set up the board
  board = new Board(BOARD_SIZE, (width-BOARD_SIZE)/2, (height-BOARD_SIZE)/2, 11);
  board.initBoard();
}

void draw() {
  // Automatically polling for mousePressed()
}

void mousePressed() {
  // Find which tile the mouse was pressed in and draw that tile
  board.processInput();
  if(!board.checkOverlayedSquares())
    exit();
}

/**
 * Convenience function for customizing the dropdown to be more visually appealing
 */
void customize(DropdownList d1) {
  d1.setBackgroundColor(color(190));
  d1.setItemHeight(20);
  d1.setBarHeight(15);
  d1.setCaptionLabel("Difficulty");
  d1.getCaptionLabel().getStyle().marginTop = 3;
  d1.getCaptionLabel().getStyle().marginLeft = 3;
  d1.getValueLabel().getStyle().marginTop = 3;
  for (int i=6;i<17;i++) {
    d1.addItem(i+"X"+i, i);
  }
  d1.setColorBackground(color(60));
  d1.setColorActive(color(255, 128));
}

void controlEvent(ControlEvent theEvent) {
  // DropdownList is of type ControlGroup.
  // A controlEvent will be triggered from inside the ControlGroup class.
  // therefore you need to check the originator of the Event with
  // if (theEvent.isGroup())
  // to avoid an error message thrown by controlP5.
  if (theEvent.isGroup()) {
    
    // Clear the background and create a new board on top of the old one with new number of squares
    background(200);
    board.setNumSquares((int)theEvent.getGroup().getValue());
    board.initBoard();
  } 
}