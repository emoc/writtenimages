class NoiseLine extends Node {
  
  /* params
       0 : modulo pour la création des nouvelles générations
       1 : gen_mode, qu'est ce que ça cree?
       2 : longueur d'un segment
  */
  
  private int etapes;
  private PVector posa, lasta, posb, lastb;
  private float longueur, largeur;
  private int node_start;
  private int gen_mode;
  private int gen_modulo;
  
  NoiseLine(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c, float[] _params) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    node_lives = _nl;
    node_start = _nl;
    largeur = _size / 3;
    
    posa = new PVector(pos.x + (largeur * cos(radians(angle+90))), pos.y + (largeur * sin(radians(angle+90))));
    posb = new PVector(pos.x + (largeur * cos(radians(angle+270))), pos.y + (largeur * sin(radians(angle+90))));
    lasta = new PVector();
    lastb = new PVector();
    //println(pos);
    //gen_mode = int(random(3));
    if (_params[0] > 0) {
      gen_modulo = int(_params[0]);
      //println("gen_modulo" + gen_modulo);
      //delay(500);
    } else {
      gen_modulo = 9;
      //println("gen_modulo" + gen_modulo);
      //delay(500);
    }
    
    if (_params[1] >= 0) gen_mode = int(_params[1]);
    else gen_mode = 1;
    
    if ((_params.length > 1) &&(_params[2] > 0)) longueur = _params[2];
    else longueur = 5;
    
    //println("gen_mode " + gen_mode); 
  }
  

  void doActions() {
    if (node_start_after > 0) {
      node_start_after --;
    } else {
      update();
      ink();
      if ( create() ) {
        // chouette effet ci-dessous avec noiseline(s)
        //                                                                     nl, nsa  g,              size
        if (gen_mode == 0) {
          //println("gen_mode " + gen_mode);
          sketch.createNode("arcs", pos.x, pos.y, angle, 2, 50, generation - 1, largeur * 2, color(0), params);
          sketch.createNode("arcs", pos.x, pos.y, angle+180, 2, 50, generation - 1, largeur * 2, color(0), params);
        } else {
          sketch.createNode("noiseline", pos.x, pos.y, angle + (30 * angle_mod), 15, 100, generation - 1, (largeur * 3) * .7, c, new float[] {gen_modulo, -1, longueur});
        }
      }
      node_lives--;
    }
  }
  
  void update() {
    
        
    if (etapes == 0) {
      etapes = 10;
      angle_mod = random(-10, 10);
      //if (angle_mod != 0) longueur =  5 * PI / 4;
      //else longueur = 5;  
      //longueur = 5;  
    }
    
    angle = angle + angle_mod;

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
    etapes --;
    if ((node_lives%50 == 0) && (largeur > 2.5)) largeur = largeur * .95;
  }
  
  void ink() {
    if (node_lives == node_start) {
      fill(0); noStroke(); strokeWeight(1);
      ellipse(last.x, last.y, largeur*3, largeur*3);
    }
    /*
    if (node_lives == 1) {
      fill(0); noStroke(); strokeWeight(1);
      ellipse(pos.x, pos.y, largeur*3, largeur*3);
    }*/
    stroke(0); strokeWeight(largeur);
    line(lasta.x, lasta.y, posa.x, posa.y);
    line(lastb.x, lastb.y, posb.x, posb.y);
    
    strokeWeight(largeur);
    stroke(c);
    line(last.x, last.y, pos.x, pos.y);
  }
  
  boolean create() {
    if ( ((node_lives%gen_modulo) == 0) && generation > 0) {
      return true;
    } else return false;
  }
}

/* ****************************************************************************************** */


class NoiseLineDot extends Node {
  
  private int etapes;
  //private PVector posa, lasta, posb, lastb;
  private float longueur, largeur_a, largeur_b;
  private int gen_mode;
  
  private boolean inkable = true;
  
  NoiseLineDot(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    node_lives = _nl;
    
    largeur_a = _size / 3;
    largeur_b = _size;
    longueur = _size;
    //posa = new PVector(pos.x + (largeur * cos(radians(angle+90))), pos.y + (largeur * sin(radians(angle+90))));
    //posb = new PVector(pos.x + (largeur * cos(radians(angle+270))), pos.y + (largeur * sin(radians(angle+90))));
    //lasta = new PVector();
    //lastb = new PVector();
    //println(pos);
    gen_mode = int(random(3));
    //println("gen_mode " + gen_mode); 
  }
  

  void doActions() {
    if (node_start_after > 0) {
      node_start_after --;
    } else {
      update();
      ink();
      if ( create() ) {
        // chouette effet ci-dessous avec noiseline(s)
        //                                                                     nl, nsa  g,              size
        /*
        if (gen_mode == 0) {
          sketch.createNode("arcs", pos.x, pos.y, angle, 2, 50, generation - 1, largeur * 20, params);
        } else {
          sketch.createNode("noiseline", pos.x, pos.y, angle + (30 * angle_mod), 10, 100, generation - 1, (largeur * 3) / 1.3, params);
        }*/
      }
      node_lives--;
    }
  }
  
  void update() {
    
        
    if (etapes == 0) {
      etapes = 10;
      angle_mod = random(-10, 10);
      //if (angle_mod != 0) longueur =  5 * PI / 4;
      //else longueur = 5;  
      //longueur = 5;  
    }
    
    angle = angle + angle_mod;

    last.set(pos.x, pos.y, 0);
    //lasta.set(posa.x, posa.y, 0);
    //lastb.set(posb.x, posb.y, 0);
    
    pos.x = pos.x + (longueur * cos(radians(angle)));
    pos.y = pos.y + (longueur * sin(radians(angle)));
    //pos.x = pos.x + (longueur * lut.coslut(angle));
    //pos.y = pos.y + (longueur * lut.sinlut(angle));
       
    etapes --;
    //if ((node_lives%50 == 0) && (largeur > 2.5)) largeur = largeur * .95;
    if (node_lives%1 == 0) inkable = !inkable;
  }
  
  void ink() {
    if (inkable) {
      strokeWeight(largeur_b);
      stroke(0);
      line(last.x, last.y, pos.x, pos.y);
      
      strokeWeight(largeur_a);
      stroke(255);
      line(last.x, last.y, pos.x, pos.y);
    }
  }
  
  boolean create() {
    if ( ((node_lives%9) == 0) && generation > 0) {
      return true;
    } else return false;
  }
}

/* ****************************************************************************************** */


class NoiseLineHairy extends Node {
  
  private int etapes;
  private PVector posa, lasta, posb, lastb;
  private float longueur, largeur;
  
  NoiseLineHairy(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
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
        float aaa;
        if (random(1) > 0.5) aaa = 50;
        else aaa = 310; 
        float xn = pos.x + (largeur * 0.3) * lut.coslut(angle+aaa);
        float yn = pos.y + (largeur * 0.3) * lut.sinlut(angle+aaa);
        sketch.createNode("noiseline", xn, yn, angle + aaa, 20, 80, generation - 1, largeur / 3, color(255), new float[] {-1, -1, -1});
      }
      node_lives--;
    }
  }
  
  void update() {
    
        
    if (etapes == 0) {
      etapes = 10;
      angle_mod = random(-10, 10);
      //if (angle_mod != 0) longueur =  5 * PI / 4;
      //else longueur = 5;  
      //longueur = 5;  
    }
    
    angle = angle + angle_mod;

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
    etapes --;
    if ((node_lives%10 == 0) && (largeur > 2.5)) largeur = largeur * .95;
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
    if ( ((node_lives%5) == 0) && generation > 0) {
      return true;
    } else return false;
  }
}
