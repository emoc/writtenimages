class Basic extends Node {
  
  private float largeur;
  
  Basic(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    largeur = _size;
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      if ( create() ) {
        sketch.createNode("arcs", pos.x, pos.y, angle, 10, 0, generation - 1, largeur * 4, color(0), params);
      }
    
      last.set(pos.x, pos.y, 0); 
      if ((node_lives%2) == 0) angle_mod *= random(-1,1);
      angle += 24 * angle_mod;
      if (angle < 0) angle = 360 - angle;
      node_lives--;
    }
  }
  
  void update() {
    //pos.x = last.x + 20 * cos(radians(angle));
    //pos.y = last.y + 20 * sin(radians(angle));
    pos.x = last.x + 20 * lut.coslut(angle);
    pos.y = last.y + 20 * lut.sinlut(angle);
  }
  
  void ink() {
    strokeWeight(largeur);
    stroke(c);
    line(last.x, last.y, pos.x , pos.y);
  }
  
  boolean create() {
    if ( ((node_lives%5) == 0) && generation > 0) {
      return true;
    } else return false;
  }
}


/* ****************************************************************************************************** */

class BasicBold extends Node {
  
  private int etapes;
  private PVector posa, lasta, posb, lastb;
  private float longueur, largeur;
  
  BasicBold(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    node_lives = _nl;
    largeur = _size / 3;
    longueur = 5;
    posa = new PVector(pos.x + (largeur * cos(radians(angle+90))), pos.y + (largeur * sin(radians(angle+90))));
    posb = new PVector(pos.x + (largeur * cos(radians(angle+270))), pos.y + (largeur * sin(radians(angle+90))));
    lasta = new PVector();
    lastb = new PVector();
    //println(pos);
  }
  

  void doActions() {
    if (node_start_after > 0) {
      node_start_after --;
    } else {
      update();
      ink();
      if ( create() ) {
        sketch.createNode("basicbold", pos.x, pos.y, angle + (30 * angle_mod), 10, 100, generation - 1, largeur / 1.3, color(0), params);
      }
      if ((node_lives%2) == 0) angle_mod *= -1;
      angle += 8 * angle_mod;
      if (angle < 0) angle = 360 - angle;
      node_lives--;
    }
  }
  
  void update() {
    
        
    //pos.x = last.x + 20 * cos(radians(angle));
    //pos.y = last.y + 20 * sin(radians(angle));
    
    //angle = angle + angle_mod;

    last.set(pos.x, pos.y, 0);
    lasta.set(posa.x, posa.y, 0);
    lastb.set(posb.x, posb.y, 0);
    
    pos.x = pos.x + (longueur * cos(radians(angle)));
    pos.y = pos.y + (longueur * sin(radians(angle)));
    posa.x = pos.x + (largeur * cos(radians(angle+90)));
    posa.y = pos.y + (largeur * sin(radians(angle+90)));
    posb.x = pos.x + (largeur * cos(radians(angle+270)));
    posb.y = pos.y + (largeur * sin(radians(angle+270)));
    /*
    pos.x = pos.x + (longueur * lut.coslut(angle));
    pos.y = pos.y + (longueur * lut.sinlut(angle));
    posa.x = pos.x + (largeur * lut.coslut(angle+90));
    posa.y = pos.y + (largeur * lut.sinlut(angle+90));
    posb.x = pos.x + (largeur * lut.coslut(angle+270));
    posb.y = pos.y + (largeur * lut.sinlut(angle+270));
    */
    //etapes --;
    //if ((node_lives%50 == 0) && (largeur > 2.5)) largeur = largeur * .95;
  }
  
  void ink() {
    strokeWeight(largeur);
    stroke(255);
    line(last.x, last.y, pos.x, pos.y);
    stroke(0);
    line(lasta.x, lasta.y, posa.x, posa.y);
    line(lastb.x, lastb.y, posb.x, posb.y);
  }
  
  boolean create() {
    if ( ((node_lives%2) == 0) && generation > 0) {
      return true;
    } else return false;
  }
}
