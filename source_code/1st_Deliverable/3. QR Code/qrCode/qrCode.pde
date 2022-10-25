
PImage img; 

void setup() {
  size(320, 240);
 
  img = loadImage("runde_bird_cliffs.jpg");
}

void draw() {
  background(0);

  image(img, 0, 0, width, height);
}
