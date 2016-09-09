class CrossHatch extends Node {
  
  private float largeur;
  
  CrossHatch(float _startX, float _startY, float _start_angle, int _nl, int _nsa, int _generation, float _size, color _c) {
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
        sketch.createNode("crosshatch", random(width), random(height), 315, 10, 0, generation - 1, 10, color(0), params);
      }
    
      last.set(pos.x, pos.y, 0); 
      //if ((node_lives%2) == 0) angle_mod *= -1;
      //angle += 8 * angle_mod;
      node_lives--;
    }
  }
  
  void update() {
    pos.x = last.x + largeur * cos(radians(angle));
    pos.y = last.y + largeur * sin(radians(angle));
  }
  
  void ink() {
    strokeWeight(1);
    stroke(255);
    float pp = random(50, 100);
    line(pos.x , pos.y, pos.x + pp, pos.y + pp);
  }
  
  boolean create() {
    if ((node_lives == 1) && (generation > 0)) {
      return true;
    } else return false;
  }
  

}
