/*
*    This code is an adaptation of the example code from the following
 *    Processing reference page:
 *
 *    https://processing.org/reference/libraries/video/Capture.html
 *
 *    It was originally released under a CC BY-NC-SA 4.0 license 
 *
 *    This program is licennced under the GPLv3:
 *
 This program is free software: you can redistribute it and/or modify
 it under the terms of the GNU General Public License as published by
 the Free Software Foundation, either version 3 of the License, or
 (at your option) any later version.
 
 This program is distributed in the hope that it will be useful,
 but WITHOUT ANY WARRANTY; without even the implied warranty of
 MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 GNU General Public License for more details.
 
 You should have received a copy of the GNU General Public License
 along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */


// This program is similar to the BasicCapture program with the exception that
// it gets the information from the camera on a mouseReleased action instead of
// every frame of draw()

import processing.video.*;

Capture cam;
PImage processedCapture;

int numberOfPixels;

void setup() {
  
  size(640, 480);   // as with previous programs, I manually set size to match one of
                    // the supported resolutions that my webcam offers
                    
  numberOfPixels = width * height;                  

  String[] cameras = Capture.list();

  if (cameras.length == 0) {
    
    println("There are no cameras available for capture.");
    exit();
  } 
  else {
    
    println("Available cameras:");
    for (int i = 0; i < cameras.length; i++) {
      println(cameras[i]);
    }

    cam = new Capture(this, cameras[0]);
    cam.start();
  }  
    
  processedCapture = createImage(width, height, ARGB);

  println("Go!");      // Setup can take ages - I just put this in to reassure myself that there's no crash happening
}


void draw() {
  
  background(0);
  
  image(processedCapture, 0, 0);    // the image displayed in draw is the PImage
                                    // that I defined above which will hold the 
                                    // processed version of my webcam
  
}

void captureEvent(Capture newCapture) {      // So before, we were checking for new frames from 
                                             // the webcam manually. That's a bit tedious, so here we're making 
                                             // use of the captureEvent method. 
                                    
                                             // Much like mousePressed() is called automaticall every
                                             // time a mouse button is pressed, captureEvent is called 
                                             // automatically whenever new data is available from the webcam.  
  
  newCapture.read();                         // As this is only called when new data is available, we can safely read straight away
  
  
  for (int i = 0; i < numberOfPixels; i++) {
    
    color pixelColour = newCapture.pixels[i];
    
    colorMode(HSB, 100);
    
    if(brightness(pixelColour) > 50){
     
        pixelColour = color(0, 99, 99);
      
    }
    
    colorMode(ARGB);
    
    processedCapture.pixels[i] = pixelColour;
  }
  processedCapture.updatePixels(); 
}
