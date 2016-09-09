
public class SketchWrapper {
  private PApplet applet; // in case you'd like an explicit reference to parent applet
  public ArrayList nodes = new ArrayList();
  public String SKETCH_NAME = "wiemoc";
  boolean STOP = false;
  boolean END = false;
  int f;
  float[] params;
  PVector[] anchor = new PVector[7]; // fake random anchor points

  float[][][] bc =  // basic colors : darker / brighter
  { 
           { {  94.0,  45.0, 191.0 }, { 111.0, 191.0,  40.0 }, { 255.0,  20.0, 229.0 } }, // bleu violet / vert printemps / rose vif
           { { 255.0,   0.0,   0.0 }, { 255.0, 255.0,   0.0 }, { 255.0,  20.0, 229.0 } }, // rouge vif / jaune vif / rose vif
           { {  14.0, 137.0,  35.0 }, { 255.0,  20.0, 229.0 }, { 255.0, 255.0,   0.0 } }, // vert printemps foncé / rose vif / jaune vif
           { { 137.0,  15.0,  75.0 }, {   3.0, 175.0, 255.0 }, { 255.0, 166.0, 175.0 } }, // pourpre violet / bleu turquoise / vieux rose
           { { 223.0,  27.0,  14.0 }, { 255.0, 166.0, 175.0 }, { 100.0,  19.0, 124.0 } }, // vermillon / vieux rose / violet
           { {  13.0,  62.0, 202.0 }, { 223.0,  27.0,  47.0 }, { 223.0,  27.0,  14.0 } }, // bleu roi dense / rouge pourpre clair / vermillon
           { { 100.0,  19.0, 124.0 }, { 255.0, 173.0,  51.0 }, { 255.0, 255.0,   0.0 } }  // violet / jaune orange / jaune vif
  };  
  int crnd; // duo color index 
  
  /** CONSTRUCTOR */
  public SketchWrapper(PApplet applet) {
    this.applet = applet;
  }
  
  
  
  /** SETUP */
  public void setup() {
    smooth();
    STOP = false;
    END = false;
    f = 0;
    crnd = int(random(bc.length));
    //println("crnd : " + crnd);
    initAnchors(anchor.length);
    initPicture();
    
  } // setup()



  public void draw() {
    //println(mode);
    //f++;
    
    
    if (mode == 1) { // PRODUCTION MODE ONLY
      while (!STOP) {
        f++;
        println(f);
        for (int i = 0; i < nodes.size(); i++) {
          Node n = (Node) nodes.get(i);
          if (n.node_lives > 0) n.doActions();
          else nodes.remove(i);
        }
        if (nodes.size() == 0) {
          STOP = true;
        }
        
        
      }
      println("FIN! " + ceil(millis() / 1000)); // TODO pour la version finale : supprimer
      noLoop(); 
    } else {
      //if (f == 0) initBackground();
      f++;
      for (int i = 0; i < nodes.size(); i++) {
        Node n = (Node) nodes.get(i);
        if (n.node_lives > 0) n.doActions();
        else nodes.remove(i);
        
      }
      if (nodes.size() == 0) {
        if (!END) {
          END = true;
          println("FIN! " + ceil(millis() / 1000)); 
        }
        //noLoop();
      } else {
        //println(f + " nodes.size : " +nodes.size() + " framerate : " + frameRate);
      }   
    }
  } // draw()
  
  
  
  public void initAnchors(int points) {
    
    float angmod = 360 / points;
    float ang = random(360);
    float mod = width / height;
    
    for (int i = 0; i < points; i++) {
      float dis = random(height * .1, height * .7);
      float x = (width * .5) + dis * cos(ang) * mod;
      float y = (height * .5) + dis * sin(ang);
      fill(255); stroke(255);
      anchor[i] = new PVector(x, y);
      ang += angmod;
    }
  }
  
  
  public void initBackgroundTest() {
    int total_pixels = width*height;
    color pink = color(255, 102, 204);

    loadPixels();
    for (int i = 0; i < total_pixels; i++) {
      pixels[i] = pink;
    }
    updatePixels();
  }
  
  public void initBackground() {
    
    PVector v1, v2, v3, v4, v5;
    float cv1, cv2, cv3, cv4, cv5;
    
    v1 = new PVector(random(width), random(height));
    v2 = new PVector(random(width), random(height));
    v3 = new PVector(random(width), random(height));
    v4 = new PVector(random(width), random(height));
    v5 = new PVector(random(width), random(height));
    cv1 = random(1);
    cv2 = random(5);
    cv3 = random(1);
    cv4 = random(1);
    cv5 = random(1);
    
    colorMode(HSB, 1);
      
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < width; j++) {
        float p1 = (20 / dist(i, j, v1.x, v1.y)) * cv1;
        float p2 = (20 / dist(i, j, v2.x, v2.y)) * cv2;
        float p3 = (20 / dist(i, j, v3.x, v3.y)) * cv3;
        float p4 = (100 / dist(i, j, v4.x, v4.y)) * cv4;
        float p5 = (20 / dist(i, j, v5.x, v5.y)) * cv5;
        float cp = p1 + p2 + p3 + p4 + p5 / 5;
        stroke(p1,p2,cp);
        point(i, j);
      }
    }
    colorMode(RGB, 255);
  }
  
  public void initBackground2() { // fond colore 7.2a
    
    int maxStella = 20;
    ArrayList stellas;
    float pp = 0;
    float ppp = 0;
    
    stellas = new ArrayList();
    for (int i = 0; i < maxStella; i++) {
      stellas.add( new Stella() );
    }

    colorMode(HSB, 1);
  
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < width; j++) {
        float p = 0;
       
        for (int k = 0; k < stellas.size(); k++) {
          Stella s = (Stella) stellas.get(k);
          p += s.getV(i, j);
          if (k == 2) pp = p;
          if (k == 4) ppp = p;
        }
        p /= stellas.size()*2;
        //stroke(1-pp/10%1,1-ppp/10,2-p*2);
        stroke(1-pp/10%1/(j*1.8/(i+1*5)),1-ppp/10,2-p*2-(i/width));
        point(i, j);
      }
    }
    
    colorMode(RGB, 255);
  }
  /*
  public void initBackground3() { // fond colore 7.2
  
    int maxStella = 20;
    ArrayList stellas;
    float pp = 0;
    float ppp = 0;
    
    stellas = new ArrayList();
    for (int i = 0; i < maxStella; i++) {
      stellas.add( new Stella() );
    }

    colorMode(HSB, 1);
    
    for (int i = 0; i < width; i++) {
      for (int j = 0; j < width; j++) {
        float p = 0;
        
        for (int k = 0; k < stellas.size(); k++) {
          Stella s = (Stella) stellas.get(k);
          p += s.getV(i, j);
          if (k == 2) pp = p;
          if (k == 4) ppp = p;
        }
        p /= stellas.size()*2;
        stroke(pp/10,ppp/10,p);
        point(i, j);
      }
    } 
    
    colorMode(RGB, 255);
  }*/
  
  public void initBackground4() {
    PGraphics hirez = createGraphics(20, 20, JAVA2D);
    hirez.beginDraw();
    hirez.background(255);
    for (int i = 0; i < 20; i++) {
      color dd = color(random(255), random(255), random(255), 255);
      hirez.stroke(dd);
      //hirez.point(random(20), random(20));
      hirez.line(0, i, 20, i);
    }
    //hirez.point(2, 2);
    hirez.smooth();
    //hirez.scale(10);
    
    //hirez.filter(BLUR);
    //hirez.filter(INVERT);
    hirez.endDraw();
    image(hirez, 0, 0, width, height);
    //noLoop();
  }
  
  
  public void initPicture() {
    
    //background(160,240,60);
    //background(55, 1, 197);
    //background(56, 16, 122);
    //background(255);
    background(0);
    //initBackground2();
    //initBackground4();
    //initBackgroundTest();
    

    
    float[] lpparams = {random(255), random(255), random(255)};
    float[] nlparams = {-1, -1, -1};
    
    //                             posx,          posy,           angle,         nl,    nsa,  g,  size,    color,            params 

    nodes.add( new SpectrumArc(    anchor[0].x,   anchor[0].y,    0.0,           100,   0,    0,  width*2.3, color(80,20,0) ));
    nodes.add( new SpectrumArc(    random(width), random(height), 0.0,           50,    0,    0,  200,     color(80,20,0) ));
    nodes.add( new NoiseLine(      anchor[0].x,   anchor[0].y,    random(360),   200,   0,    0,  500,     color(255),       nlparams ));
    nodes.add( new NoiseLine(      anchor[0].x,   anchor[0].y,    random(360),   100,   50,   0,  200,     color(255),       nlparams ));
    //nodes.add( new LinePattern(    anchor[0].x,   anchor[0].y,    170,           100,   400,  2,  4,       color(0),         lpparams)); // masse de couleurs
    nodes.add( new LinePattern(    anchor[0].x,   anchor[0].y,    170,           350,   0,    3,  1,       color(0),         lpparams)); // masse de couleurs
    nodes.add( new NoiseLine(      anchor[5].x,   anchor[5].y,    random(360),   20,    0,    3,  10,      color(255),       new float[] {2, 1, 5} )); // <--
    //nodes.add( new NoiseLine(      anchor[2].x,   anchor[2].y,  random(360),   10,    800,  1,  100,     color(255),      new float[] {1, 0, 5} )); // + arcs
    //nodes.add( new NoiseLine(      anchor[2].x,   anchor[2].y,  random(360),   200,   600,  0,  200,     color(0) ));
    nodes.add( new LinePattern(    anchor[3].x,   anchor[3].y,    170,           200,   100,  3,  2,       color(0),         lpparams)); // masse de couleurs
    //nodes.add( new LinePattern(    anchor[3].x,   anchor[3].y,  170,           300,   200,  1,  6,       color(0), params)); // masse de couleurs
    //nodes.add( new LinePattern(    anchor[6].x,   anchor[6].y,  170,           300,   200,  2,  random(2,6), color(0), params)); // masse de couleurs
    //float xx = 
    float bb = random(360);
    nodes.add( new NoiseLineHairy( anchor[6].x, anchor[6].y,      bb,            500,   100,  0,  50,      color(0) )); //
    nodes.add( new NoiseLineHairy( anchor[6].x, anchor[6].y,     (bb+180)%360,   500,   100,  0,  50,      color(0) )); //
    //nodes.add( new NoiseLine(      width / 3,     height / 3,     random(360),   300,   300,  2,  10,      color(255),       nlparams ));
    nodes.add( new NoiseLine(      random(width), height / 3,     random(360),   200,   200,  2,  8,      color(255),       new float[] {3, 1, 3} ));
    //nodes.add( new NoiseLineDot(   random(width), height / 2,   random(360),   200,   0,    0,  20,      color(0) ));
    //nodes.add( new NoiseLineDot(   random(width), height / 2,   random(360),   200,   0,    0,  20,      color(0) ));
    //nodes.add( new NoiseLineDot(   random(width), height / 2,   random(360),   200,   0,    0,  20,      color(0) ));
    nodes.add( new NoiseLineDot(   random(width), height / 2,     random(360),   500,   0,    0,  5,      color(0) ));

    nodes.add( new NoiseLineDot(   random(width), random(height), random(360),   500,   0,    0,  2,      color(0) ));
    nodes.add( new NoiseLineDot(   random(width), height / 2,     random(360),   200,   300,  0,  5,      color(0) ));
    //nodes.add( new NoiseLine(      width / 3,     random(height), random(360),   300,   200,  2,  4,       color(255),         nlparams )); 
    //nodes.add( new Basic(          width / 2,     height / 2,     270        ,   100,   300,  2,  0,       color(0) ));
    //nodes.add( new Basic(          width / 2,     height / 2,     270        ,   100,   300,  2,  0,       color(255,0,0) ));
    //nodes.add( new MultipleLines(  width / 2,     height / 2,   random(360), 1000, 100, 2, 4,   color(0)));
    //nodes.add( new MultipleLines(  width / 2,     height / 2,   random(360), 2000, 100, 2, 8));
    //nodes.add( new CrossHatch(     random(width), random(height), 315        , 100,  100, 20, 8,  color(0)));
    //nodes.add( new SpectrumArc(300.0,120.0,0.0,50,0,0,width*2,color(255,120,0)));
    //nodes.add( new Fgbt(           width / 3,     height / 4,     random(360), 1000, 500, 2, 10));
    //nodes.add( new SpectrumArc(200.0,200.0,0.0,50,0,0,width*2,color(0,10,0)));
    //nodes.add( new LinePattern(    width / 3,     height / 3,     50,          100,   30,   3,  5,       color(0)));
    
    //println("crnd : " + crnd);
    //println(bc[crnd][0][0] + " " + bc[crnd][0][1] + " " + bc[crnd][0][2]);
    //println(bc[crnd][1][0] + " " + bc[crnd][1][1] + " " + bc[crnd][1][2]);
    
    //fill(bc[crnd][0][0], bc[crnd][0][1], bc[crnd][0][2]); noStroke();
    //ellipse(anchor[0].x, anchor[0].y, width, width);
    nodes.add( new NodeCircle( anchor[0].x, anchor[0].y, 1, width*.8, color(bc[crnd][0][0], bc[crnd][0][1], bc[crnd][0][2])));
    nodes.add( new Krackle( anchor[0].x, anchor[0].y, 2, width*.8, width*.9, color(bc[crnd][0][0], bc[crnd][0][1], bc[crnd][0][2])));
    
    //fill(bc[crnd][1][0], bc[crnd][1][1], bc[crnd][1][2]); noStroke();
    //ellipse(anchor[4].x, anchor[4].y, width*.7, width*.7);
    nodes.add( new NodeCircle( anchor[4].x, anchor[4].y, 4, width*.6, color(bc[crnd][1][0], bc[crnd][1][1], bc[crnd][1][2])));
    nodes.add( new Krackle( anchor[4].x, anchor[4].y, 5, width*.6, width*.7, color(bc[crnd][1][0], bc[crnd][1][1], bc[crnd][1][2])));
    
    int cccc = int(random(bc.length));
    for (int i = 0; i < anchor.length; i++) {
      //int cccc = (crnd+1)%bc.length;
      
      nodes.add( new Krackle( anchor[i].x, anchor[i].y, 5, width*random(.2,.7), width*.2, color(bc[cccc][1][0], bc[cccc][1][1], bc[cccc][1][2])));
      //nodes.add( new Krackle( anchor[i].x, anchor[i].y, 5, width*random(.2,.7), width*.2, color(bc[crnd][2][0], bc[crnd][2][1], bc[crnd][2][2])));
    }
    //                             posx,          posy,           angle,         nl,    nsa,  g,  size,    color,         params 
    
    for (int i = 0; i < 15; i++) {
      float[] bwparams = {random(16,60)};
      nodes.add( new BlackAndWhiteWheel(random(width), random(height), random(360), 1, int(random(500)), 0, random(10,60), color(0), bwparams) );
    }
    for (int i = 0; i < 4; i++) {
      float[] cwparams = {random(16,60)};
      nodes.add( new ColorWheel(random(width), random(height), random(360), 1, int(random(400, 600)), 0, random(5,20), color(0), cwparams) );
    }
    
    for (int i = 0; i < 50; i++) {
      nodes.add( new Spiral(color(0,0,0)));
    }
  }

  public void createNode(String _type, float _x, float _y, float _ang, int _nl, int _gen, int _nsa, float _size, color _c, float[] params) {
    if (_type.equals("basic")) {
      nodes.add( new Basic(_x, _y, _ang, _nl, _gen, _nsa, _size, _c));
    } else if (_type.equals("fgbt")) {
      nodes.add( new Fgbt(_x, _y, _ang, _nl, _gen, _nsa, _size, _c));
    } else if (_type.equals("basicbold")) {
      nodes.add( new BasicBold(_x, _y, _ang, _nl, _gen, _nsa, _size, _c));
    } else if (_type.equals("linepattern")) {
      //float[] params = {random(255), random(255), random(255)};
      nodes.add( new LinePattern(_x, _y, _ang, _nl, _gen, _nsa, _size, _c, params));
    } else if (_type.equals("noiseline")) {
      nodes.add( new NoiseLine(_x, _y, _ang, _nl, _gen, _nsa, _size, _c, new float[] {params[0], params[1], params[2]}));
    } else if (_type.equals("crosshatch")) {
      nodes.add( new CrossHatch(_x, _y, _ang, _nl, _gen, _nsa, _size, _c));
    } else if (_type.equals("arcs")) {
      nodes.add( new Arcs(_x, _y, _ang, _nl, _gen, _nsa, _size, _c));
    }
  }
  
  //
  // INTERACTIVE DEV-MODE TWEAKING HOOKS FOR KEY/MOUSE:
  //
  void keyPressed() {
    if (key == 's') {
      saveFrame(SKETCH_NAME+"-"+year()+month()+day()+hour()+minute()+second()+millis()+".png");
    }
    if (key == 'r') {
      initPicture();
    }
    if (key == 'k') {
      noLoop();
    }
    if (key == 'l') {
      loop();
    }
  }
  void keyReleased() {
  }
  void mouseDragged() {
  }
  void mousePressed() {
  }
  void mouseReleased() {
  }
}

