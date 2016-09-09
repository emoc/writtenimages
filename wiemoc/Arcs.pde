class Arcs extends Node {

  private float largeur;
  
  Arcs(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    largeur = _size;
    node_lives = 1;
    println("newarc");
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
    
      last.set(pos.x, pos.y, 0); 
      //if ((node_lives%2) == 0) angle_mod *= -1;
      //angle += 8 * angle_mod;
      node_lives--;
    }
  }
  
  void update() {
  }
  
  void ink() {
    ellipseMode(CENTER);
    //float arcs = random(4, 12);
    //float p = 1.0 / arcs;
    float diameter = node_size;
    float angle_wide = random(80, 160);
    int arcs = int(angle_wide / 10); 
    float angle_0 = angle + 180 - angle_wide;
    float step = angle_wide / ( arcs * 2); 
    for (float i = 0; i < arcs; i++) {
      if (i%2 == 0) noFill();
      else fill(255);
      noStroke();
      arc(pos.x, pos.y, diameter * random(.7,1.2), diameter * random(.7,1.2), radians(angle_0 + (i * step)), radians(angle_0 + ((i+1) * step)));
    }
  }
  
  boolean create() {
    return false;
  }
}


/* ************************************************************************************ */

class SpectrumArc extends Node {

  float chue;
  //boolean spectrum_ray = true;
  
  SpectrumArc(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after --;
    } else {
      update();
      ink();
      node_lives--;
    }
  }
  
  boolean create() {
    return false;
  }
    
  void update() {
    angle = random(360);
  }
  
  void ink() {
    chue = hue(c);
    colorMode(HSB);
    noStroke();
    float pp = random(1);
    //println("pp" + pp);
    
    
    if (pp <= .1) { // spectrum color ray 
      for (float k = 0; k < 40; k++) {
        float col = (chue + (6.25 * k))%255;
        //println("spectrum ray col" + col);
        fill(col,255,255,255);
        arc(pos.x, pos.y, node_size, node_size, radians(angle), radians(angle+.12));
        angle += .1;
      }
      //println("pp" + pp + " spectrum");
    } else if ((pp > .1) && (pp < .8)) { // white ray
    
      fill(0,0,255,255);
      if (pp > .4) {
        arc(pos.x, pos.y, node_size, node_size, radians(angle), radians(angle+3));
        //println("pp" + pp + " white ray full");
      } else {
        for (float k = 0; k < 10; k++) {
          arc(pos.x, pos.y, node_size, node_size, radians(angle), radians(angle+.1));
          angle += .3;
        }
        //println("pp" + pp + " white ray semi");
      }
      
    } else { // black ray
    
      fill(0,0,0,255);
      if (pp < .9) {
        arc(pos.x, pos.y, node_size, node_size, radians(angle), radians(angle+3));
        //println("pp" + pp + " black ray full");
      } else {
        for (float k = 0; k < 10; k++) {
          arc(pos.x, pos.y, node_size, node_size, radians(angle), radians(angle+.2));
          angle += .3;
        }
        //println("pp" + pp + " black ray semi");
      }
      //arc(pos.x, pos.y, node_size, node_size, radians(angle), radians(angle+5));
      
    }
    //delay(300);
    colorMode(RGB);
  }
  
}
