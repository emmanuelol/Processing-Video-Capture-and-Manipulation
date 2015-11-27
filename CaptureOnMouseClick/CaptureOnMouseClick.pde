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

void setup() {
  size(640, 480);

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
}


void draw() {

  set(0, 0, cam);
}

void mouseReleased() {    // the system only checks for new data from the 
                          // camera when mouse released is called.
                          
  if (cam.available() == true) {
    cam.read();
  }
  
}

