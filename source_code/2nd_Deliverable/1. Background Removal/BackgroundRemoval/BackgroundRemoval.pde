// Background removal
// 

//βιβλιοθήκη για το βιντεο
import processing.video.*;

// Variable for capture device
Capture video;

// μεταβλητες του background
PImage backgroundImage;
Movie backgroundReplace;


//Ευαισθησία κίνησης 
float threshold = 10;

void setup() {
  size(1280, 720);
  video = new Capture(this, width, height, 30);
  video.start();

 
  //Το μεγεθος του background ειναι το μεγεθος του βιντεο 
  backgroundImage = createImage(video.width, video.height, RGB);
   // Το background που θα μετατρεπει
  backgroundReplace = new Movie(this,"pink.mp4");
  backgroundReplace.loop();
}

// κλαση για να διαβάζει την κάμερα
void captureEvent(Capture video) {
  video.read();
}

// κλαση για να διαβάζει την κάμερα
void movieEvent (Movie backgroundReplace) 
{
  backgroundReplace.read();
}

void draw() 
{

  threshold = map(mouseX, 0, width, 5, 50);
  image(backgroundReplace, width, height); //kalesa thn entoli ayti gia na anakalesei to video

 
  loadPixels();
  video.loadPixels(); 
  backgroundReplace.loadPixels();


  for (int x = 0; x < video.width; x ++ ) {
    for (int y = 0; y < video.height; y ++ ) {
      int loc = x + y*video.width; // Step 1, what is the 1D pixel location
      color fgColor = video.pixels[loc]; // Step 2, what is the foreground color

     
      color bgColor = backgroundImage.pixels[loc];

      // Step 4, compare the foreground and background color
      float r1 = red(fgColor);
      float g1 = green(fgColor);
      float b1 = blue(fgColor);
      float r2 = red(bgColor);
      float g2 = green(bgColor);
      float b2 = blue(bgColor);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      // Step 5, Is the foreground color different from the background color
   if (diff > threshold) 
    {
        // If so, display the foreground color
        pixels[loc] = fgColor;
      } else
      {
        // If not, display the beach scene
        pixels[loc] = backgroundReplace.pixels[loc];
      }
      
    }
    
  }
  updatePixels();
}

void mousePressed() {

  backgroundImage.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  backgroundImage.updatePixels();
}
