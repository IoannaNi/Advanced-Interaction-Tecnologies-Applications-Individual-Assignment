// Background removal
// 

//βιβλιοθήκη για το βιντεο
import processing.video.*;

// Variable for capture device
Capture video;

// μεταβλητες του background 
PImage backgroundImage;
PImage backgroundReplace;

//Ευαισθησία κίνησης 
float threshold = 100;

void setup() {
  size(416, 416);
  video = new Capture(this, width, height, 30);
  video.start();

  //Το μεγεθος του background ειναι το μεγεθος του βιντεο 
  backgroundImage = createImage(video.width, video.height, RGB);
  // Το background που θα μετατρεπει
  backgroundReplace = loadImage("pink.jpg");
}

// κλαση για να διαβάζει την κάμερα
void captureEvent(Capture video) {
  video.read();
}


void draw() {
  // Map the threshold to mouse location
 //-- threshold = 80;

  // We are looking at the video's pixels, the memorized backgroundImage's pixels, as well as accessing the display pixels. 
  // So we must loadPixels() for all!
  
  loadPixels();
  video.loadPixels(); 
  backgroundImage.loadPixels();

  // Begin loop to walk through every pixel
  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width; // Step 1, what is the 1D pixel location
      color fgColor = video.pixels[loc]; // Step 2, what is the foreground color

      // Step 3, what is the background color
      color bgColor = backgroundReplace.pixels[loc];

      // Step 4, compare the foreground and background color
      float r1 = red(fgColor);
      float g1 = green(fgColor);
      float b1 = blue(fgColor);
      float r2 = red(bgColor);
      float g2 = green(bgColor);
     float b2 = blue(bgColor);
     float diff = dist(r1, g1, b1, r2, g2, b2);

      // Step 5, Is the foreground color different from the background color
      if  (diff > threshold) 
      {
        // If so, display the foreground color
        pixels[loc] = backgroundReplace.pixels[loc];
        
      } else {
        // αν δεν 
        pixels[loc] = fgColor;
      }
    }
  }
  updatePixels();
}
