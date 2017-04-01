public class Board {
  // Size of the board
  private int BOARD_SIZE;
  
  // Size of the buffer space in X direction and Y direction
  private int BUFFER_X, BUFFER_Y;
  
  // Number and size of each square
  private int numberSquares;
  private float sizeSquares;
  
  // Array of tile objects within the board
  Tile[][] tiles;
  
  public Board(int BOARD_SIZE, int BUFFER_X, int BUFFER_Y, int numberSquares) {
    this.BOARD_SIZE = BOARD_SIZE;
    this.BUFFER_X = BUFFER_X;
    this.BUFFER_Y = BUFFER_Y;
    this.numberSquares = numberSquares;
  }
  
  /**
   * Draws the board by initializing an array of Tile objects
   * with their respective x/y coordinates
   */
  public void initBoard() {
    sizeSquares = ((float)BOARD_SIZE/numberSquares);
    tiles = new Tile[numberSquares][numberSquares];
    for(int i = 0; i<numberSquares; i++) {
      for(int j = 0; j<numberSquares; j++) {
        tiles[i][j] = new Tile((i*sizeSquares) + BUFFER_X, (j*sizeSquares)+ BUFFER_Y);
        tiles[i][j].drawTile();
      }
    }
    checkOverlayedSquares();
  }
  
  /**
   * Draws a new board over the old one without initializing a new array of tiles
   */
  public void drawNewBoard() {
    for(int i = 0; i<numberSquares; i++) {
      for(int j = 0; j<numberSquares; j++) {
        tiles[i][j].drawTile();
      }
    }
  }
  
  /**
   * Finds the specific tile in which the mouse was pressed as an array index
   * and draws a new tile at that index in the array
   */
  public void processInput() {
    if((mouseX>BUFFER_X && mouseX<(width-BUFFER_X)) && (mouseY>BUFFER_Y && mouseY<(height-BUFFER_Y))) {
      
      // Use integer division to get even mutiple to pass to array
      // Find position to draw new square in terms of the buffer space
      int x = (int)(((mouseX-BUFFER_X)/sizeSquares));
      int y = (int)((mouseY-BUFFER_Y)/sizeSquares);
      
      // Change the color of that tile
      tiles[x][y].updateColor();
      
      // Draw new board with the new tile color
      drawNewBoard();
    }
  }

  /**
   * Algorithm for finding the overlayed squares in the array of Tiles.
   * Returns whether or not there is a rectangle to draw
   */
  public boolean checkOverlayedSquares() { //<>//
    boolean check=false;
    for(int i=0; i<numberSquares-1; i++) {  //<>//
      for(int j=i+1; j<numberSquares; j++) { //<>//
        for(int k=0; k<numberSquares-1; k++) {
          for(int l=k+1; l<numberSquares; l++) {
            if(tiles[i][k].col == tiles[j][k].col && tiles[j][k].col == tiles[j][l].col && tiles[i][k].col == tiles[i][l].col) {
              board.drawOverlayedSquare(i,j,k,l); //<>//
              check = true;
            }
          }
        }
      }
    }
    return check;
  }
  
  /**
   * Actually draw the overlayed square in the correct position based on array indices
   */
  private void drawOverlayedSquare(int i,int j,int k,int l) {
    fill(255); //<>//
    rectMode(CENTER);
    rect(tiles[i][k].getCenterX(), ((tiles[i][l].getCenterY() + tiles[i][k].getCenterY())/2), 5, (tiles[i][k].getCenterY() - tiles[i][l].getCenterY()));
    rect(tiles[j][k].getCenterX(), ((tiles[j][k].getCenterY() + tiles[j][l].getCenterY())/2), 5, (tiles[j][l].getCenterY() - tiles[j][k].getCenterY()));
    rect(((tiles[i][k].getCenterX() + tiles[j][k].getCenterX())/2), tiles[i][k].getCenterY(), (tiles[j][k].getCenterX() - tiles[i][k].getCenterX()) + 5, 5);
    rect(((tiles[i][l].getCenterX() + tiles[j][l].getCenterX())/2), tiles[i][l].getCenterY(), (tiles[j][l].getCenterX() - tiles[i][l].getCenterX()) + 5, 5);
    rectMode(CORNER);
  }
  
  // Get and set methods for variables that need to be used or set by other classes
  public float getSizeSquares() {
    return sizeSquares;
  }
  
  public void setNumSquares(int numSquares) {
    numberSquares = numSquares;
  }
}
