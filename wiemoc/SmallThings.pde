class ColorWheel extends Node {
                                  /* params
                                  0 : arcs number
                                  */
  int arcs;

  ColorWheel(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c, float[] params) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    arcs = int(params[0]);
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      node_lives = 0;
    }
  }
  
  void update() {
  }
  
  void ink() {
    colorMode(HSB, 1);
    ellipseMode(CENTER);
    float p = 1.0 / arcs;
    for (float i = 0; i < arcs; i++) {
      fill(p*i, 1, 1);
      noStroke();
      arc(pos.x, pos.y, node_size, node_size, radians(p*i*360+start_angle)-.1, radians(p*(i+1)*360+start_angle)+.1);
    }
    colorMode(RGB, 255);
  }
  
  boolean create() {
    return false;
  }
}

/* ****************************************************************************************** */

class BigCircle extends Node {

  BigCircle(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      node_lives = 0;
    }
  }
  
  void update() {
  }
  
  void ink() {
    colorMode(HSB, 1);
    noStroke();
    fill(random(1), 0.8, 0.8);
    ellipseMode(CENTER);
    ellipse(pos.x, pos.y, node_size, node_size);
    fill(0);
    float dec = node_size * .1;
    ellipse(pos.x + dec * lut.coslut(start_angle), pos.y + dec * lut.sinlut(start_angle), node_size, node_size);    
    colorMode(RGB, 255);
  }
  
  boolean create() {
    return false;
  }
}

/* ****************************************************************************************** */

class BlackAndWhiteWheel extends Node {
                                  /* params
                                  0 : arcs number
                                  */
  int arcs;

  BlackAndWhiteWheel(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c, float[] params) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    arcs = int(params[0]);
    if (arcs%2 != 0) arcs +=1;
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      node_lives = 0;
    }
  }
  
  void update() {
  }
  
  void ink() {
    ellipseMode(CENTER);
    float p = 1.0 / arcs;
    for (float i = 0; i < arcs; i++) {
      if (i%2 == 0) fill(0);
      else fill(255);
      noStroke();
      arc(pos.x, pos.y, node_size, node_size, radians(p*i*360), radians(p*(i+1)*360));
    }
  }
  
  boolean create() {
    return false;
  }
}

/* ****************************************************************************************** */



/* ****************************************************************************************** */

class Stella {
  PVector pos;
  float cw, cwmax; // color weight
  float s; // size

  Stella() {
    pos = new PVector(random(width), random(height));
    //cwmax = random(10);
    //cw = random(10);
    //s = random(2, 60);
    cw = random(11);
    s = random(10, 50);
  }
      
  float getV(int i, int j) {
    return (s / (dist(i, j, this.pos.x, this.pos.y))) * cw;
  } 
}




/* ****************************************************************************************** */

class Spiral extends Node {
  
  float inc;
  float angle_max;
  float points = 2000;
  float distance = 0;
  
  Spiral() {
    super(random(width), random(height), random(360), 1, int(random(20)), 1, 0, color(0,0,0)); 
    inc = random (0.001, 0.1);
    angle_max = random (360, 3600);  
  }
  
  Spiral(color _c) {
    super(random(width), random(height), random(360), 1, int(random(20)), 1, 0, _c); 
    inc = random (0.001, 0.1);
    angle_max = random (360, 3600);  
  }

  Spiral(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    inc = random (0.001, 0.1);
    angle_max = random (360, 3600);  
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      node_lives = 0;
    }
  }
  
  void update() {
  }
  
  void ink() {
    stroke(c);
    strokeWeight(1);
    float step_angle = angle_max / points;
    if (random(1) > .5) step_angle *= -1;
    for (int i = 1; i < points; i++) {
      angle += step_angle;
      if (random(1) > .3) point( pos.x + distance * lut.coslut(angle), pos.y + distance * lut.sinlut(angle));
      distance += inc; 
    }
  }
  
  boolean create() {
    return false;
  }
}

/* ****************************************************************************************** */


class Segment extends Node {
  
  float angle_length;
  float angle_dep;
  float diameter;
  float sw;
  color c;
  
  Segment() {
    super(random(width), random(height), random(360), 1, int(random(300)), 1, 0, color(0,0,0)); 
    angle_length = random(180);
    angle_dep = random(360); 
    diameter = random (20, 50);
    sw = int(random(6, 20));
    setColor(); 
  }

  Segment(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    angle_length = random(180);
    angle_dep = random(360); 
    diameter = random (20, 50);
    sw = int(random(6, 20));
    setColor();  
  }
  
  void setColor() {
    int nbb = int(random(0, 3));
    switch (nbb) {
      case 0: c = color(255, 0, 0); break;
      case 1: c = color(0, 255, 0); break; 
      case 2: c = color(0, 0, 255); break; 
    }
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      node_lives = 0;
    }
  }
  
  void update() {
  }
  
  void ink() {
    stroke(c);
    noFill();
    strokeWeight(sw);
    strokeCap(SQUARE);
    arc( pos.x, pos.y, diameter, diameter, radians(angle_dep), radians(angle_dep + angle_length));
    arc( pos.x, pos.y, diameter + (3 * sw) , diameter + (3 * sw), radians(angle_dep), radians(angle_dep + angle_length));
    arc( pos.x, pos.y, diameter + (6 * sw) , diameter + (6 * sw), radians(angle_dep), radians(angle_dep + angle_length));
    strokeCap(ROUND);
  }
  
  boolean create() {
    return false;
  }
}

/* ****************************************************************************************** */

class Krackle extends Node {
  
  float s, sk;
  
  Krackle(float _x, float _y, int _nsa, float _size, float _sizek, color _c) {
    super(_x, _y, 0, 1, _nsa, 1, _size, _c); 
    s = node_size / 2;
    sk = _sizek;
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      node_lives = 0;
    }
  }
  
  void update() {
  }
  
  void ink() {

    for (int i = 0; i < 360; i+=3) {
      float x0 = pos.x + s * lut.coslut(i);
      float y0 = pos.y + s * lut.sinlut(i);
      int nb = int(random(s * .2)); 
      for (int j = 0; j < nb; j++) {
        float d = random(5, sk * .5); 
        float ss = (sk * .1) * (5 / d) * random(.2, 1.4);
        float a = (360 / nb) * j;
        float x = x0 + d * lut.coslut(a);
        float y = y0 + d * lut.sinlut(a);
        fill(c); noStroke();
        ellipse(x, y ,ss, ss);
      }
    }
  }
 
 
  boolean create() {
    return false;
  }
}

/* ****************************************************************************************** */

class NodeCircle extends Node {
  
  //float s;
  
  NodeCircle(float _x, float _y, int _nsa, float _size, color _c) {
    super(_x, _y, 0, 1, _nsa, 1, _size, _c); 
    //s = node_size / 2;
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      node_lives = 0;
    }
  }
  
  void update() {
  }
  
  void ink() {
    fill(c); noStroke();
    ellipse(pos.x, pos.y, node_size, node_size);
  }
 
 
  boolean create() {
    return false;
  }
}

