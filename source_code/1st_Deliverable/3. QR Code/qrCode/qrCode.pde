import qrcodeprocessing.*;

Decoder decoder;

void setup() {
  
  size(400, 400);
  decoder = new Decoder(this);
  PImage img = loadImage("qrcode.png");
  decoder.decodeImage(img);
}

void draw()
{ 
 background(0);
}

void decoderEvent(Decoder decoder) {
  String statusMsg = decoder.getDecodedString(); 
  println(statusMsg);
  link(statusMsg);
}
