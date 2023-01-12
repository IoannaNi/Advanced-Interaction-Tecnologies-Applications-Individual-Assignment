//3o PARADOTEO //<>//

// import the TUIO library
import TUIO.*;
// declare a TuioProcessing client
TuioProcessing tuioClient;



float scale_factor = 1;
PFont font;
PImage img;
PImage img1;
int imagewidth, imageheight; // PLATOS KAI MIKOS EIKONAS
float zoom = 100;
boolean loadImage= false ;
float red=255;
float opacity = 255;

boolean verbose = true; // print console debug messages
boolean callback = true; // updates only after callbacks

void setup()
{
  // GUI setup
  // noCursor();
  // size(displayWidth,displayHeight); // 1o) allazw to mege8os gia na min pianei oli tin epifaneia ergasias
  size(800, 800);
  // noStroke();
  //fill(0);
  img = loadImage("pink.jpg"); //2o
  img1 = loadImage("pink2.jpg");

  // periodic updates
  if (!callback) {
    frameRate(60);
    loop();
  } else noLoop(); // or callback updates 

  font = createFont("Arial", 18);
  tuioClient  = new TuioProcessing(this);
  imagewidth = img.width;
  imageheight = img.height;
}


void draw()
{
  background(255);
  textFont(font, 18*scale_factor);

  // ένας πινακασ που αποθηκευει ολα τα αντικειμενα του 
  // τρεχει και εντοπίζει ολα α αντικειμενα , φτιαχνει ενα ορθογωνιο και ενα κειμενο
  ArrayList<TuioObject> tuioObjectList = tuioClient.getTuioObjectList();
  for (int i=0; i<tuioObjectList.size(); i++) {
    TuioObject tobj = tuioObjectList.get(i);


    if (tobj.getSymbolID()==0)
    {
      translate(tobj.getScreenX(width/2), tobj.getScreenY(height/2));
      rotate(tobj.getAngle());
      image(img, 0, 0, imagewidth, imageheight);
    }


    // an 8elw 2h eikona
    /* if (tobj.getSymbolID()==1)
     {
     translate(tobj.getScreenX(width),tobj.getScreenY(height));
     rotate(tobj.getAngle());
     image(img1, 0, 0);
     }*/

    if (loadImage)
    {
      if (tobj.getSymbolID()==2)
      {
        // ka8orizete apo thn taxytita peristrofis
        zoom =constrain(zoom +tobj.getRotationSpeed()*3, 10, 300 );
        imagewidth = int(img.width* zoom/100); // allazw to mege8ow tis eikonas me basi to zoom
        imageheight = int(img.height*zoom/100);
      }

      if (tobj.getSymbolID()==3)
      {
        // ka8orizete apo to xrwma
        red =map(tobj.getAngle(), 0, 6.2, 255, 0 );
        tint(red, 255, 255);
      }

      if (tobj.getSymbolID()==4)
      {
        opacity =map(tobj.getAngle(), 0, 15, 255, 50 );  
        tint( 255, 50);
      }
    }
  }
}
// --------------------------------------------------------------

// called when an object is added to the scene
void addTuioObject(TuioObject tobj) {
  if (verbose) println("add obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle());
  if (tobj.getSymbolID()==0)
  {
    loadImage= true;
  }
}

// called when an object is moved
void updateTuioObject (TuioObject tobj) {
  if (verbose) println("set obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+") "+tobj.getX()+" "+tobj.getY()+" "+tobj.getAngle()
    +" "+tobj.getMotionSpeed()+" "+tobj.getRotationSpeed()+" "+tobj.getMotionAccel()+" "+tobj.getRotationAccel());
}

// called when an object is removed from the scene
void removeTuioObject(TuioObject tobj) {
  if (verbose) println("del obj "+tobj.getSymbolID()+" ("+tobj.getSessionID()+")");
  if (tobj.getSymbolID()==0)
  {
    loadImage= false;
  }
  if (tobj.getSymbolID()==2)
  {
    imagewidth = img.width/2;
    imageheight = img.height/2;
  }
  if (tobj.getSymbolID()==3)
  {
    red = 255;  
    tint(red, 255, 255);
  }

  if (tobj.getSymbolID()==4)
  {
    opacity = 255;  
    tint( 255, 255);
  }
}

// --------------------------------------------------------------
// called when a cursor is added to the scene
void addTuioCursor(TuioCursor tcur) {
  if (verbose) println("add cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY());
  //redraw();
}

// called when a cursor is moved
void updateTuioCursor (TuioCursor tcur) {
  if (verbose) println("set cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+ ") " +tcur.getX()+" "+tcur.getY()
    +" "+tcur.getMotionSpeed()+" "+tcur.getMotionAccel());
  //redraw();
}

// called when a cursor is removed from the scene
void removeTuioCursor(TuioCursor tcur) {
  if (verbose) println("del cur "+tcur.getCursorID()+" ("+tcur.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called when a blob is added to the scene
void addTuioBlob(TuioBlob tblb) {
  if (verbose) println("add blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea());
  //redraw();
}



// called when a blob is moved
void updateTuioBlob (TuioBlob tblb) {
  if (verbose) println("set blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+") "+tblb.getX()+" "+tblb.getY()+" "+tblb.getAngle()+" "+tblb.getWidth()+" "+tblb.getHeight()+" "+tblb.getArea()
    +" "+tblb.getMotionSpeed()+" "+tblb.getRotationSpeed()+" "+tblb.getMotionAccel()+" "+tblb.getRotationAccel());
  //redraw()
}

// called when a blob is removed from the scene
void removeTuioBlob(TuioBlob tblb) {
  if (verbose) println("del blb "+tblb.getBlobID()+" ("+tblb.getSessionID()+")");
  //redraw()
}

// --------------------------------------------------------------
// called at the end of each TUIO frame
void refresh(TuioTime frameTime) {
  if (verbose) println("frame #"+frameTime.getFrameID()+" ("+frameTime.getTotalMilliseconds()+")");
  if (callback) redraw();
}
