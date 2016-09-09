/*
	Rudolf Clausius vs. Jack Kirby [splash page]
	Built for the Written Images book, june 2010, http://writtenimages.net
	Copyright (c) <2010> <emoc / Pierre Commenge>
	http://emoc.org
	
	Comic book artists, especially Jack Kirby, developed a cosmic universe 
	populated with creatures "beyond imagination", colorful galaxies 
	and explosions of unlimited energy, which sometimes filled 
	a whole page (the splash page). In this program, graphical objects 
	inspired by visual codes of comics are evolving against each other in 
	a thermodynamics orgy!
	
	sample output : http://www.flickr.com/photos/emoc/6212059319/in/photostream
	
    Made with PROCESSING 1.0.9 (REV 0171), broken in 1.5.1!
	using a processing framework to output large pictures by Dave Bollinger

	
	--
	
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



/**
An example "framework" for the writtenimages.net project.
Specifically intended for the JAVA2D renderer when doing vector-based work.
That is, it's not a 3D framework, nor is it appropriate for pixel-based work.

Uses the "recorder" mechanism to allow a single sketch to serve as both the
development and production code base.  Also separates the code into two pieces:
this piece, which serves only as the "framework"; and the SketchWrapper class,
which serves as the container for all of the artist-specific sketching code.

In "development mode", the sketch will run interactively at reduced (1/4th,
1020x680) resolution, simulating a screen DPI of 75, corresponding to print DPI
of 300.  In "presentation mode", the sketch will simply scale up X4 and render
to high resolution output non-interactively then exit.

Your sketch-specific code shouldn't have to worry about any of these details
unless you do some really bizarre matrix manipulations that mess up the scaling.
(in which case you're probably advanced enough to figure out the solution)  Just
"pretend" that you're developing it to look right at 1020x680 and the framework
will handle the rest.

A particular advantage of the JAVA2D renderer is that strokeWeight() should scale
up accordingly (assuming you have a non-defective java runtime available) so that
the high resolution version is a correct representation of the screen res version.
(that is, production output scaled to 25% will match screen output in dev mode)

Provided *AS IS*, use as you wish, or don't, either way don't blame me.  ;-p
Dave Bollinger, 03/2010
Portions from the original 2D "processingExample.pde" posted by writtenimages.net

*/

// the two available modes of operation:
static int MODE_DEVELOPMENT = 0;
static int MODE_PRODUCTION = 1;
// uncomment one of the following:
static int mode = MODE_DEVELOPMENT; // use this when developing your sketch
//static int mode = MODE_PRODUCTION; // use this if you wish to test production output from the pde

// note that "mode" is automatically set to MODE_PRODUCTION when application is run from the command-line

static String actualNameOfSketch = "wiemoc"; //<- PApplet Filename here <- important!!!

static String[] exportFiles = {
  // USE YOUR OWN LOCAL PATHS FOR THE DEBUG FILENAMES
  // (these filenames are used when testing production mode from inside the pde, taking the place of actual command-line args)
  //
  // windows example: (as i was using)
  "h:/sketchbook/2010wi/debug_img.png"
  //"d:/temp/debug_img1.png", "d:/temp/debug_img2.png"
  // mac/*nix example:
  //"/yourPath/debug_img1.png", "/yourPath/debug_img2.png"
}; 

// THE REMAINING CODE BELOW SHOULDN'T REQUIRE ANY CHANGES:

static public void main(String args[]) { // dont' change this function
  exportFiles = new String[args.length]; 
  for(int i=0; i<args.length; i++){ 
    exportFiles[i] = args[i]; 
  }
  mode = MODE_PRODUCTION;
  PApplet.main(new String[] {actualNameOfSketch} );
}

SketchWrapper sketch; // this would contain "your sketch"
LUT lut;

void setup(){
  size(4080/4,2720/4,JAVA2D); // don't change the required image size
  smooth();
  lut = new LUT();
  sketch = new SketchWrapper(this);
  
  if (mode == MODE_PRODUCTION) {
    noLoop(); // run draw() just once
  } else {
    sketch.setup(); // define a new sketch
    // draw will run continuously, allowing you to tweak/fine tune/test
    // it interactively if you put in some key/mouse controls in sketchwrapper
  }
}

void draw(){
  if (mode == MODE_PRODUCTION) {
    PGraphics hirez = createGraphics(4080,2720,JAVA2D);
    for(int i=0; i<exportFiles.length; i++){ // loop all export arguments
      beginRecord(hirez);
      hirez.smooth();
      hirez.scale(4);
      sketch.setup(); // define/redefine a new sketch
      sketch.draw(); // render that sketch
      hirez.endDraw();
      hirez.save(exportFiles[i]);
      println(exportFiles[i]+" saved successfully");
    }
    exit();
  } else {
    sketch.draw();
  }
}

void keyPressed() {
  if (mode == MODE_DEVELOPMENT) // just a safety valve, shouldn't get a press from command-line anyway
    sketch.keyPressed();
}

void keyReleased() {
  if (mode == MODE_DEVELOPMENT) // just a safety valve, shouldn't get a press from command-line anyway
    sketch.keyReleased();
}

void mouseDragged() {
  if (mode == MODE_DEVELOPMENT) // just a safety valve, shouldn't get a press from command-line anyway
    sketch.mouseDragged();
}

void mousePressed() {
  if (mode == MODE_DEVELOPMENT) // just a safety valve, shouldn't get a press from command-line anyway
    sketch.mousePressed();
}

void mouseReleased() {
  if (mode == MODE_DEVELOPMENT) // just a safety valve, shouldn't get a press from command-line anyway
    sketch.mouseReleased();
}

