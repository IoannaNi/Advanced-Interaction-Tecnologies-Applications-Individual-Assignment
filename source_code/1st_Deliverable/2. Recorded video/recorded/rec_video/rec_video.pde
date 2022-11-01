

import processing.video.*; // βιβλιοθηκη για αναγνωρισει τησ εντολες
Movie ballMovie; // μεταβλητη ballMovie τυπου Movie 

void setup() {
  size(600, 300); // μεγεθοσ παραθυρου 
  frameRate(30);
  ballMovie = new Movie(this, "videaki.mp4"); // δημιουργια αντικειμενου "ballMovie" τησ κλασησ Movie 
  ballMovie.speed(2.0); // ταχυτητα με την οποια θα τρεχει το βιντεακι
  ballMovie.loop(); // εντολη για να τρεχει το βιντεακι σε λουπα (ξανα και ξανα)
}

void draw() {
  float r = map(mouseX,0,width,0,4); // θετω μια μεταβλητη στην οποια εκχωρω την εντολη map
  ballMovie.speed(r); // οταν κουνω το ποντικi αλλαζει η ταχυτητα του βιντεο
  if (ballMovie.available()) {
    ballMovie.read();
  }
  image(ballMovie, 0, 0);
}
