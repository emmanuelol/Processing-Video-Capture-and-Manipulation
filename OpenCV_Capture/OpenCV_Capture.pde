/* 
*    This program is adapted from the LiveCamTest.pde example at:
*
*    https://github.com/atduskgreg/opencv-processing/blob/master/examples/LiveCamTest/LiveCamTest.pde
*
*    Part of the Processing project - http://processing.org
*      
*    Copyright (c) 2011-12 Elie Zananiri
*    Copyright (c) 2008-11 Andreas Schlegel
*      
*    This program is free software; you can redistribute it and/or
*    modify it under the terms of the GNU General Public License
*    as published by the Free Software Foundation; either version 2
*    of the License, or (at your option) any later version.
*      
*    This program is distributed in the hope that it will be useful,
*    but WITHOUT ANY WARRANTY; without even the implied warranty of
*    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
*    GNU General Public License for more details.
*      
*    You should have received a copy of the GNU General Public License
*    along with this program; if not, write to the Free Software
*    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.
*
*/


 // Import your libraries

import processing.video.*;    // we're using video to get footage from the webcam
import gab.opencv.*;          // OpenCV is used for the face detection 
import java.awt.*;            // This library is a dependance of OpenCV (which means that 
                              // if we don't include it some aspects of OpenCV won't work 
                              // properly.

Capture video; 
OpenCV opencv;

void setup() {
  
  size(640, 480);
    
  // set up our Capture and OpenCV objects to expect images the same size as our canvas.
  // You might get some errors here if the size doesn't match one of the supported resolutions of your webcam:
  
  video = new Capture(this, width, height);
  opencv = new OpenCV(this, width, height);
  
  // For the face detection to work, you need to load in a 'cascade' file. This a file that contains 
  // information on what OpenCV should be looking for. In our case we are loading a cascade for face
  // recognition but you can look for all sorts of features in your video. 
  
  // You seem to need the full file path for this to work. A relative URL isn't good enough.
  // To use this program, navigate to your folder for this sketch and then get the file path to the file inside 
  // the cascade-files folder.
  
  opencv.loadCascade("C:/Users/in13db/Desktop/Processing Video Capture and Manipulation/OpenCV_Capture/cascade-files/haarcascade_frontalface_alt.xml", true);  

  video.start();
}

void draw() {
  
  background(255);
  
  opencv.loadImage(video);      // load a frame of data from video into the OpenCV object.

  image(video, 0, 0 );          // load the video on to the screen.
  
  // notice that the two steps above are totally seperate. You can still be running face recognition 
  // without needing to display the video on screen.
  
  noFill();
  stroke(0, 255, 0);
  strokeWeight(1);
  
  Rectangle[] faces = opencv.detect();      // Get an array of Rectangles from OpenCV, one for each face
                                            // The Rectangle class isn't part of Processing, it's a native Java
                                            // class - look here for a reference: 
                                            // http://docs.oracle.com/javase/7/docs/api/java/awt/Rectangle.html
  
  println("Found " + faces.length + " face(s) this frame at the coords:");

  for (int i = 0; i < faces.length; i++) {
    println("Face " + i + " at\t" + faces[i].x + "," + faces[i].y);
    rect(faces[i].x, faces[i].y, faces[i].width, faces[i].height);
  }
}

void captureEvent(Capture c) {
  
  c.read();
  
  
}
