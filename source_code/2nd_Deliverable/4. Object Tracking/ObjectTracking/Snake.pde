
// klasi snake 

//metablitew gia to xrvma toy kykloy
float r ;
float g ;
float b ;


class Snake {
  int[] xpos;
  int[] ypos;

 
  Snake(int n) {
    xpos = new int[n];
    ypos = new int[n];
  }

  void update(int newX, int newY) {

    for (int i = 0; i < xpos.length-1; i ++ ) {
      xpos[i] = xpos[i+1]; 
      ypos[i] = ypos[i+1];
    }

    // Update the last spot in the array with the mouse location.
    xpos[xpos.length-1] = newX; 
    ypos[ypos.length-1] = newY;
  }

  void display() {
    // Draw everything
    for (int i = 0; i < xpos.length; i ++ ) {
      // Draw an ellipse for each element in the arrays. 
      // Color and size are tied to the loop's counter: i.
      stroke(0);
     r= random(255);
     g= random(255);
     b= random(255);
     
  
   
    
  fill(r,g,b);
      ellipse(xpos[i],ypos[i],i,i); 
    }

  }

}
