class LinePattern extends Node {
  
  private float longueur;
  private color col;
  
  LinePattern(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c, float[] params) {
                
    super(_startX, _startY, _start_angle, _nl, _nsa, _generation, _size, _c); 
    longueur = 2;
    col = color(params[0], params[1], params[2]);
    
  }
  
  void doActions() {
    if (node_start_after > 0) {
      node_start_after--;
    } else {
      update();
      ink();
      if ( create() ) {
        //float[] params = {red(c), blue(c), green(c)};
        float[] params = {random(255), random(255), random(255)};
        float aaa;
        /* crystal growth
        if (random(1) > .5) aaa = angle + 30 + random(-5,5);
        else aaa = angle - 30 + random(-5, 5);
        aaa = aaa%360; */
        aaa = random(360);
        //                                                          nl,             nsa  g,            size
        sketch.createNode("linepattern", pos.x, pos.y, aaa, node_lives / 2, 0, generation - 1, node_size, color(0), params);
      }
    
      last.set(pos.x, pos.y, 0); 
      /*
      if (node_lives == 1) {
        float[] params = {random(255), random(255), random(255)};
        sketch.createNode("linepattern", pos.x, pos.y, random(360), 100, 100, generation-1, 1, params);
      }*/
      node_lives--;
    }
  }
  
  void update() {
    pos.x = last.x + longueur * lut.coslut(angle);
    pos.y = last.y + longueur * lut.sinlut(angle);
  }
  
  void ink() {
    colorMode(RGB);
    strokeWeight(node_size);
    stroke(col);
    line(last.x, last.y, pos.x , pos.y);
  }
  
  boolean create() {
    if ( (node_lives%5 == 0) && (generation > 0) ) {
      return true;
    } else return false;
  }
  

}
