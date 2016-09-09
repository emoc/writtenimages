class MultipleLines extends Node {
  
  private int etapes;
  private PVector posa, lasta, posb, lastb;
  private PVector posc, lastc, posd, lastd;
  private float longueur, largeur;
  
  MultipleLines(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    node_lives = _nl;
    largeur = _size / 5;
    largeur = _size;
    longueur = 5;
    posa = new PVector(pos.x + (largeur * 4 * cos(radians(angle+90))), pos.y + (largeur * 4 * sin(radians(angle+90))));
    posb = new PVector(pos.x + (largeur * 2 * cos(radians(angle+90))), pos.y + (largeur * 2 * sin(radians(angle+90))));
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
      node_lives--;
    }
  }
  
  void update() {
    
        
    if (etapes == 0) {
      etapes = 10;
      float r = random(1);
      if ((r > .3) && (r < .5)) angle_mod = 9;
      if ((r > .5) && (r < .7)) angle_mod = -9;
      else if ((r > .5) && (r <= 1)) angle_mod = 18;
      else angle_mod = 0;
      if (angle_mod != 0) longueur =  5 * PI / 4;
      else longueur = 5;    
    }
    
    angle = angle + angle_mod;

    last.set(pos.x, pos.y, 0);
    lasta.set(posa.x, posa.y, 0);
    lastb.set(posb.x, posb.y, 0);
    
    pos.x = pos.x + (longueur * cos(radians(angle)));
    pos.y = pos.y + (longueur * sin(radians(angle)));
    posa.x = pos.x + (largeur * 4 * cos(radians(angle+90)));
    posa.y = pos.y + (largeur * 4 * sin(radians(angle+90)));
    posb.x = pos.x + (largeur * 2 * cos(radians(angle+90)));
    posb.y = pos.y + (largeur * 2 * sin(radians(angle+90)));
       
    etapes --;
    //if ((node_lives%50 == 0) && (largeur > 2.5)) largeur = largeur * .95;
  }
  
  void ink() {
    strokeWeight(2);
    stroke(255);
    line(last.x, last.y, pos.x, pos.y);
    //stroke(0);
    line(lasta.x, lasta.y, posa.x, posa.y);
    line(lastb.x, lastb.y, posb.x, posb.y);
  }
  
  boolean create() {
    return false;
  }
}
