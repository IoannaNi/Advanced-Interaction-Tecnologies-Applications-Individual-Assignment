//4. QR Code - Camera Read: 

import processing.video.*; //βιβλιοθήκη για να μπορει να αναγνωρίσει με την κάμερα
import qrcodeprocessing.*; //βιβλιοθήκη για να μπορει να αναγνωρίσει Qr

 
Capture video;                                 
String statusMsg = "Waiting for an image";     

// Decoder object from prdecoder library
Decoder decoder;

void setup() {
  size(800, 800);
  video = new Capture(this, 720, 620);
  video.start();

  // Create a decoder object
  decoder = new Decoder(this);
}

// When the decoder object finishes
// this method will be invoked.
void decoderEvent(Decoder decoder) {
  statusMsg = decoder.getDecodedString();
}

void captureEvent(Capture video) {
  video.read();
}

void draw() {
  background(0);

  // Display video
  image(video, 0, 0);
  // Display status
  text(statusMsg, 10, height-4);

  // If we are currently decoding
  if (decoder.decoding()) {
    // Display the image being decoded
    PImage show = decoder.getImage();
    image(show, 0, 0, show.width/4, show.height/4); 
    statusMsg = "Decoding image";
    
    for (int i = 0; i < (frameCount/2) % 10; i++) statusMsg += ".";
  }
}

void keyReleased() {
  // Depending on which key is hit, do different things:
  switch (key) {
  case ' ':        

    PImage savedFrame = createImage(video.width, video.height, RGB);
    savedFrame.updatePixels();
    decoder.decodeImage(savedFrame);
    String statusMsg = decoder.getDecodedString(); 
  println(statusMsg);
  link(statusMsg);
   
    break;
  case 'f':    // f runs a test on a file
    PImage preservedFrame = loadImage("qrcode.png");
   
    // Decode file
    decoder.decodeImage(preservedFrame);
    break;
  }
}
