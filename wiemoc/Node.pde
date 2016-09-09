abstract class Node {

  PVector start;     // start position
  PVector pos;       // current position
  PVector last;      // last position
  
  float start_angle; // start absolute angle 
  float angle;       // current angle
  float node_size;
  
  int generation;
  int node_start_after = 0;
  int node_lives = 10; 
  float angle_mod = 1;
  color c;
  
  float[] params = {0}; // variable parameters for real classes
  
  
  Node(float _startX, float _startY, float _start_angle, int _node_lives, int _node_start_after, int _generation, float _size, color _c) {
    start = new PVector(_startX, _startY);
    last = new PVector(_startX, _startY);
    pos = new PVector(_startX, _startY);

    start_angle = _start_angle;
    angle = _start_angle;
    generation = _generation;
    node_start_after = _node_start_after;
    node_size = _size;
    node_lives = _node_lives;
    c = _c;
  }
  
  abstract void doActions();
  abstract boolean create();
  abstract void update();
  abstract void ink();
}
