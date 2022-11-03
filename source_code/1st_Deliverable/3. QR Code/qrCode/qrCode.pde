// 3. QR Code:

// βιβλιοθήκη για να αναγνωρίζει το Qr
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

// μια κλαση οπου γινετε το σκαναρισμα απο την καμερα και
// επιστρεφει το decoder
void decoderEvent(Decoder decoder) {
  String statusMsg = decoder.getDecodedString(); 
  println(statusMsg);
  link(statusMsg); // για να με "πεταει" στην ιστοσελιδα μου 
}
