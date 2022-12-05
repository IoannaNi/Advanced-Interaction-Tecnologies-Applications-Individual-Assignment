//2. Motion Detection:
//ένα σχήμα που να ακολουθεί ένα κινούμενο αντικείμενο (π.χ. χέρι).

//Βιβλιοθήκη για το βιντεο-καμερα
import processing.video.*;

Capture video;
PImage prevFrame;

//Ευαισθησία κίνησης
float threshold = 100;

void setup()
{
  size(320, 240);
  video = new Capture(this, width, height);
  video.start();
  prevFrame = createImage(video.width, video.height, RGB);
}

void captureEvent(Capture video) {
 
  prevFrame.copy(video, 0, 0, video.width, video.height, 0, 0, video.width, video.height);
  prevFrame.updatePixels();  
  video.read();
}

void draw() {
  background(0);
  image(video, 0, 0);


  loadPixels();
  video.loadPixels();
  prevFrame.loadPixels();

 
  float sumX = 0;
  float sumY = 0;
  int motionCount = 0; 

  for (int x = 0; x < video.width; x++ ) {
    for (int y = 0; y < video.height; y++ ) {
      color current = video.pixels[x+y*video.width];

      // What is the previous color
      color previous = prevFrame.pixels[x+y*video.width];

      //Συγκρίση χρωμάτων των pixel των τωρινων με το παλιων 
      float r1 = red(current); 
      float g1 = green(current);
      float b1 = blue(current);
      float r2 = red(previous); 
      float g2 = green(previous);
      float b2 = blue(previous);
      float diff = dist(r1, g1, b1, r2, g2, b2);

      //οταν το σημειο κουνιεται αλλαζει το χρωμα που προηγούμενου pixel σε σχεση με του τωρινού
      if (diff > threshold) {
        sumX += x;
        sumY += y;
        motionCount++;
      }
    }
  }

  //οριζει την τοποθεσίας
  float avgX = sumX / motionCount; 
  float avgY = sumY / motionCount; 

  // επεξεργασια σφαιρας
  smooth(8);
  noStroke();
  fill(248, 200, 220);
  ellipse(avgX, avgY, 50,50);
}