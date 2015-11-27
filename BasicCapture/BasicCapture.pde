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


import processing.video.*;            // This imports all (using the * wildcard) the parts
// of the Processing video library, assuming that you 
// have it installed in the correct place.

Capture cam;                          // Initialise your Capture object.  

void setup() {
  size(640, 480);

  String[] cameras = Capture.list();  // Get a list of all available webcams, their available resolutions and framerates

  if (cameras.length == 0) {          // Check how long the above list is, if it's empty it means that no cameras were found

    println("There are no cameras available for capture.");
    exit();
  } 

  else {    // Otherwise, we must have found some cameras, so print out the list:

    println("Available cameras:");
    
    for (int i = 0; i < cameras.length; i++) {
      println("[" + i + "]" + cameras[i]);
    }

    cam = new Capture(this, cameras[0]);  // The camera can then be initialized directly using an 
                                          // element from the array returned by list():
    
    cam.start();      // Start the capture (your webcam should turn on at this point!) you should be 
                      // able to stop it with cam.stop();
  }
}


void draw() {
  
  if (cam.available() == true) {    // The available() method checks if there's a new frame of
                                    // data vailable from the webcam, if there is then it:
    cam.read();                     // <------- reads it
  }
  
  set(0, 0, cam);    // using set is the fastest way to put this data on screen, if you 
                     // want to resize the image, perform any transformations or add a tint() then
                     // you could use image(cam, 0, 0); instead (which is slightly less optimised than set).
}

