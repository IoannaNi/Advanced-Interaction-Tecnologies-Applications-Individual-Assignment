
import processing.video.*; // βιβλιοθηκη video
Capture video;
void captureEvent(Capture video) {
  video.read();
}

// 1
void setup() {
  size(320, 240); //ρυθμισεις για το μεγεθοσ του παραθύρου
  video = new Capture(this, 320, 240); //
  video.start();
}
void draw() {
  image(video, 0, 0);
}
