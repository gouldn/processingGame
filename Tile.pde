
public class Tile {
  
  // X,Y coordinates of the top left corner of the tile
  private float posX, posY;
  
  // Initial color of the sqare in reference to array of possible colors
  private int col = (int)random(0,4);
  
  // X/Y coordinates of the center of this particular square
  private float centerX, centerY;
  
  // Size of each 
  
  public Tile(float posX, float posY) {
    this.posX = posX;
    this.posY = posY;
    centerX = posX + (board.getSizeSquares()/2);
    centerY = posY + (board.getSizeSquares()/2);
  }
   
  public void updateColor() {
   col++;
   col %= 4;
  }
  
  /**
   * Draws a new tile at the known x/y position of this specific instance
   * with a random fill color from global colors array. Successive calls
   * will cycle through the array according to instance variable col
   */
  public void drawTile() {
    fill(colors[col][0], colors[col][1], colors[col][2]);
    rect(posX, posY, board.getSizeSquares(), board.getSizeSquares());
  }
  
  // Used by drawOverlayedSquares to draw pipelines in the correct positions
  public float getCenterX() {
    return centerX;
  }
  
  public float getCenterY() {
    return centerY;
  }
}

