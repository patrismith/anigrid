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

class Square {

  float x, y;
  float centerX, centerY;
  float radius;
  float theta;
  float r, g, b, a;
  int w, h;
  int fill;
  int auraType;
  boolean on;
  
  AudioPlayer player;

  float colorPick() {
    return 64*random(5);
  }
  
  void soundPick(int f) {
    if (f == 0) {
      int n = int(random(6));
      if (n == 0) {
        player = maxim.loadFile("Pad C2.wav");
        player.setLooping(false);
      } else if (n == 1) {
        player = maxim.loadFile("Pad D#.wav");
        player.setLooping(false);
      } else if (n == 2) {
        player = maxim.loadFile("Pad F.wav");
        player.setLooping(false);
      } else if (n == 3) {
        player = maxim.loadFile("Pad A.wav");
        player.setLooping(false);
      } else if (n == 4) {
        player = maxim.loadFile("Pad A#.wav");
        player.setLooping(false);
      } else {
        player = maxim.loadFile("Pad C3.wav");
        player.setLooping(false);
      }
    } else if (f == 1) {
      int n = int(random(4));
      if (n == 0) {
        player = maxim.loadFile("Ice C3.wav");
        player.setLooping(false);
      } else if (n == 1) {
        player = maxim.loadFile("Ice F.wav");
        player.setLooping(false);
      } else if (n == 2) {
        player = maxim.loadFile("Ice C4.wav");
        player.setLooping(false);
      } else {
        player = maxim.loadFile("Melody 2.wav");
        player.setLooping(false);
      }
    } else if (f == 2) {
      int n = int(random(4));
      if (n == 0) {
        player = maxim.loadFile("Arp C3.wav");
        player.setLooping(false);
      } else if (n == 1) {
        player = maxim.loadFile("Arp D#.wav");
        player.setLooping(false);
      } else if (n == 2) {
        player = maxim.loadFile("Arp F.wav");
        player.setLooping(false);
      } else {
        player = maxim.loadFile("Arp G#.wav");
        player.setLooping(false);
      }
    }
  }
  
  
  Square(float tempX, float tempY, int tempCols, int tempRows) {
    x = tempX;
    y = tempY;
    w = tempCols;
    h = tempRows;
    centerX = x + w/2;
    centerY = y + h/2;
    on = false;
    fill = 100;
    radius = 5;
    theta = 0;
    r = colorPick();
    g = colorPick();
    b = colorPick();
    a = random(100,256);
    auraType = int(random(3));
    soundPick(auraType);
  }
  
  
  //helper functions
  
  // draws the square
  void display() {
    fill(fill);
    // watch out for this, sqX and sqY are defined in main file
    rect(x, y, sqX, sqY);
  }
 

  void radiusLoop() {
    radius += .25;
      if (radius > 50) {
         radius = 5;
       }
  }
 
  // the shapes of the aura
   void drawAura() {     
     pushMatrix();
     translate(centerX, centerY);
     if (radius == 5) {
       player.cue(0);
       player.play();
     }
     // expanding circle     
     if (auraType == 0) {
       ellipse(0, 0, radius*2, radius*2);
       radiusLoop();
       
     } else if (auraType == 1) {
       // spinning circles
       for (int i = 0; i < 6; i++) {
         pushMatrix();
         rotate(theta+i);
         translate(50, 0);   
         ellipse(0, 0, 10, 10);
         popMatrix();
       }
       theta += 0.025;
       radiusLoop();
       // radius += 0.001; // a dumb temporary fix
       
     } else if (auraType == 2) {
     // circles radiating outwards
       for (int i = 0; i < 6; i++) {
         pushMatrix();
         rotate(i);
         translate(radius*2, 0);   
         ellipse(0, 0, 10, 10);
         popMatrix();
       }
       radiusLoop();
       
     }
     popMatrix();
   }
 
 
   void playAura() {
     if (on) {       
       //player.cue(0);
       //player.play();
     } else {
       player.stop();
       radius = 5;
       theta = 0;
     }
   }
   
 
   // draws the aura
   void aura() {
     if (on) {      
       fill(r, g, b, a);
       drawAura();
     }
   }
 
 
  // toggle the 'on' status of the square 
  void toggle() {
    on = !on;
    fill_color();
  }


  // toggle the square's color
  void fill_color() {
    if (on) {
      fill = 255;
    } else {
      fill = 100;
    }
  }
  
  
  // click() and drag() together enables an array of
  // squares to be toggled interestingly by clicking
  // and dragging the pointer around.
  
  void press(int mX, int mY) {
    boolean in = mX > x && mX < x + w && mY > y && mY < y + h;
    if (in) {
      toggle();
      playAura();
    }
  }
  
  
  void drag(int pmX, int pmY, int mX, int mY) {
    boolean in = mX > x && mX < x + w && mY > y && mY < y + h;
    boolean wasIn = pmX > x && pmX < x + w && pmY > y && pmY < y + h;
    if (in && !wasIn) {
      toggle();
      playAura();
    }
  }
}

