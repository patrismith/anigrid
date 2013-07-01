////// Anigrid v.01 by p. smith (https://github.com/patrismith)

//// draft for the first session of the Creative Programming course on coursera
//// https://class.coursera.org/digitalmedia-001/

//// Draws a grid of squares that play sounds and animations when activated
//// Activate squares by clicking and dragging!

//// requires Processing 2.0.1
//// If you are viewing this code from the peer assessment page,
//// please visit the github link for the data files and Maxim library.

//// sounds for this version from S. Duda, used with permission

//// volume control fix courtesy Martin Bruner
//// https://github.com/mbruner63/Maxim_Java_API


// graphical constants
int cols = 8;
int rows = 8;
int screenWidth = 600;
int screenHeight = 600;
int sqX = screenWidth/cols;
int sqY = screenHeight/rows;

// initialize an array of squares
Square[][] squares = new Square[cols][rows];

// sound library
Maxim maxim;

// iterate through an array
// i don't know java so i'm sure there's a better way to do this ;)
void iter(int f) {
  for (int i = 0; i < cols; i++) {
    for (int j = 0; j < rows; j++) {
      if (f == 0) {
        // fill square array with new squares
        float x = map(i * cols,0,cols,0,sqX);
        float y = map(j * rows,0,rows,0,sqY);
        squares[i][j] = new Square(x, y, sqX, sqY);
        
        
      } else if (f == 1) {        
        squares[i][j].display();
      } else if (f == 2) {
        squares[i][j].aura();
      } else if (f == 3) {
        squares[i][j].press(mouseX, mouseY);
      } else if (f == 4) {
        squares[i][j].drag(pmouseX, pmouseY, mouseX, mouseY);
      } 
    }
  }
}

void setup() {
  size(screenWidth, screenHeight);
  background(0);
  smooth();
  noStroke();
  frameRate(72);
  
  maxim = new Maxim(this);
  
  //make the square objects
  iter(0);

}


void draw() {
  // a grid of squares
  iter(1);
  iter(2);
}

void mousePressed() {
  iter(3);
}

void mouseDragged() {
  iter(4);
}
