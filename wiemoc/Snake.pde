class Snake {
  float[][] sg; // tableau contenant les coordonnées de points pour chaque segment
  int seg;
  float x, y, ln, wd;
  float angd1 = -0.9;  // variation de l'angle entre chaque segment, borne basse
  float angd2 = .9; // variation de l'angle entre chaque segment, borne haute
  //float lnc;        // longueur des controles de courbe
  float lnmod; // modulation de la longueur des vecteurs de controle
  int color_mode = 0; // 0 : tout le spectre, sinon prend la valeur de color_mode comme base; 
  
  Snake (float _x, float _y, int _seg, float _length, float _width) {
    x = _x;
    y = _y;
    seg = _seg;
    ln = _length;
    wd = _width;
    //lnc = ln / 2;
    lnmod = 1;
    sg = new float[seg][15];
    initSegments(); 
    draw();
  } 
  
  void initSegments(){
    float s_x = 0, s_y = 0, s_a = 0, s_ax = 0, s_ay = 0, s_bx = 0, s_by = 0;
    float s_c1ax, s_c1ay, s_c2ax, s_c2ay, s_c1bx, s_c1by, s_c2bx, s_c2by;
    float s_x0 = 0, s_y0 = 0, s_a0 = 0, s_ax0 = 0, s_ay0 = 0, s_bx0 = 0, s_by0 = 0;

    /* que contient le tableau sg des segments ?
    
            c2 (c2ax, c2ay)
           / 
          /
         *  a (ax,ay) ------------------ * a {n+1} ------- ...
       / |                               |
      /  |                               |
     c1  |                               |
         |                               |
         * point de départ (x, y)        * (point suivant
         |                               |
         |  c2 (c2bx, c2by)              |
         | /                             |
         |/                              |
         *  b (bx, by) ------------------* b {n+1} --------- ...
        /                                    
       /
      c1 (c1bx, c1by)
      
    sg[n][0] ;  // coordonnée X du point de départ            (s_x)
    sg[n][1] ;  // coordonnée Y du point de départ            (s_y)
    sg[n][2] ;  // angle de direction du segment              (s_a)
    sg[n][3] ;  // coordonnée X du point externe a            (s_ax)
    sg[n][4] ;  // coordonnée Y du point externe a            (s_ay)
    sg[n][5] ;  // coordonnée X du point externe b            (s_bx)
    sg[n][6] ;  // coordonnée Y du point externe b            (s_by)
    sg[n][7] ;  // coordonnée X du point de controle 1 de a   (s_c1ax)
    sg[n][8] ;  // coordonnée Y du point de controle 1 de a   (s_c1ay)
    sg[n][9] ;  // coordonnée X du point de controle 2 de a   (s_c2ax)
    sg[n][10] ; // coordonnée Y du point de controle 2 de a   (s_c2ay)
    sg[n][11] ; // coordonnée X du point de controle 1 de b   (s_c1bx)
    sg[n][12] ; // coordonnée Y du point de controle 1 de b   (s_c1by)
    sg[n][13] ; // coordonnée X du point de controle 2 de b   (s_c2bx)
    sg[n][14] ; // coordonnée Y du point de controle 2 de b   (s_c2by)

    */
    
    // on commence par créer tous les points et les angles entre les segments...
    for (int i = 0; i < seg; i++) {
      if (i == 0) { // cas particulier du premier segment
        sg[i][2] = random(-PI, PI);
        sg[i][0] = x;
        sg[i][1] = y;
      } else {
        float ang = random(angd1, angd2);
        sg[i][2] = sg[i-1][2] + ang;
        sg[i][0] = sg[i-1][0] + ln * cos(sg[i-1][2]);
        sg[i][1] = sg[i-1][1] + ln * sin(sg[i-1][2]);
      }
      
    }
    for (int i = 0; i < seg; i++) {
      
      float lnc;
      
      if (i == 0) { // cas particulier du premier segment
      
        s_x = sg[0][0];
        s_y = sg[0][1];
        s_a = sg[0][2];

        s_ax = s_x + wd * cos(s_a - HALF_PI);  
        s_ay = s_y + wd * sin(s_a - HALF_PI);
        s_bx = s_x + wd * cos(s_a + HALF_PI);
        s_by = s_y + wd * sin(s_a + HALF_PI);
        
        lnc = ln / 2 * lnmod;
        
        s_c1ax = s_ax + lnc * cos(s_a - PI);
        s_c1ay = s_ay + lnc * sin(s_a - PI);
        s_c2ax = s_ax + lnc * cos(s_a);
        s_c2ay = s_ay + lnc * sin(s_a);
        
        s_c1bx = s_bx + lnc * cos(s_a - PI);
        s_c1by = s_by + lnc * sin(s_a - PI);
        s_c2bx = s_bx + lnc * cos(s_a);
        s_c2by = s_by + lnc * sin(s_a);
        
        // ajouter les valeurs au tableau
        sg[i][0]  = s_x;
        sg[i][1]  = s_y;
        sg[i][2]  = s_a;
        sg[i][3]  = s_ax;
        sg[i][4]  = s_ay;
        sg[i][5]  = s_bx;
        sg[i][6]  = s_by;
        sg[i][7]  = s_c1ax;
        sg[i][8]  = s_c1ay;
        sg[i][9]  = s_c2ax;
        sg[i][10] = s_c2ay;
        sg[i][11] = s_c1bx;
        sg[i][12] = s_c1by;
        sg[i][13] = s_c2bx;
        sg[i][14] = s_c2by;
        
        // conserver certaines valeurs pour le calcul du segment suivant
        /*
        s_x0 = s_x;
        s_y0 = s_y;
        s_a0 = s_a; */
 
      } else {
        // TODO : reprendre ici !
        s_x = sg[i][0];
        s_y = sg[i][1];
        s_a = sg[i][2];
        
        float ang1, ang2;
        
        ang1 = atan2(sg[i][1] - sg[i-1][1], sg[i][0] - sg[i-1][0]);
        if (i == seg - 1) ang2 = ang1;
        else ang2 = atan2(sg[i+1][1] - sg[i][1], sg[i+1][0] - sg[i][0]);
        
        if (abs(ang2 - ang1) > (TWO_PI - abs(angd2) - abs(angd1))) {
         ang2 = ang2 * -1;
        }
        // probleme ici quand on est proche de -PI et + PI la moyenne est faussée...
        //float angmed = (ang2 + ang1) / 2;
        float angmed = (ang2 - ang1) / 2 + ang1;
        
        //println(i + " ang1 : " + ang1 + " ang2 : " + ang2 + " angmed : " + angmed ); 
        
        s_ax = s_x + wd * cos(angmed - HALF_PI);  
        s_ay = s_y + wd * sin(angmed - HALF_PI);
        s_bx = s_x + wd * cos(angmed + HALF_PI);
        s_by = s_y + wd * sin(angmed + HALF_PI);
        
        /*
        s_ax0 = s_x0 + wd * cos((s_a0 - (ang/2)) - HALF_PI);  
        s_ay0 = s_y0 + wd * sin((s_a0 - (ang/2)) - HALF_PI);
        s_bx0 = s_x0 + wd * cos((s_a0 - (ang/2)) + HALF_PI);
        s_by0 = s_y0 + wd * sin((s_a0 - (ang/2)) + HALF_PI);
        */
        
        // calculer les points de contrôle
        // TODO : définir la longeur des vecteurs de controle 
        // en fonction de la distance entre les points de controle...
        lnc = ln / 2 * lnmod;
        
        s_c1ax = s_ax + lnc * cos(angmed - PI);
        s_c1ay = s_ay + lnc * sin(angmed - PI);
        s_c2ax = s_ax + lnc * cos(angmed);
        s_c2ay = s_ay + lnc * sin(angmed);
        
        s_c1bx = s_bx + lnc * cos(angmed - PI);
        s_c1by = s_by + lnc * sin(angmed - PI);
        s_c2bx = s_bx + lnc * cos(angmed);
        s_c2by = s_by + lnc * sin(angmed);
        
        // ajouter les valeurs au tableau
        sg[i][0]  = s_x;
        sg[i][1]  = s_y;
        sg[i][2]  = s_a;
        sg[i][3]  = s_ax;
        sg[i][4]  = s_ay;
        sg[i][5]  = s_bx;
        sg[i][6]  = s_by;
        sg[i][7]  = s_c1ax;
        sg[i][8]  = s_c1ay;
        sg[i][9]  = s_c2ax;
        sg[i][10] = s_c2ay;
        sg[i][11] = s_c1bx;
        sg[i][12] = s_c1by;
        sg[i][13] = s_c2bx;
        sg[i][14] = s_c2by;
        
        // TODO :  prévoir le cas du dernier segment
        
        // conserver certaines valeurs pour le calcul du segment suivant
        /*s_x0 = s_x;
        s_y0 = s_y;
        s_a0 = s_a; */
        
        
      }
    }
  }
  
  void draw() {
    stroke(255); fill(255); strokeWeight(5);

    for (int i = 0; i < seg-1; i++) {

      noStroke();

      
      //fill(255, 0, wd*20);   
      if (color_mode == 0) {
        fill(random(255), 250, 250);
      } else {
        float c = color_mode + random(-25,25);
        //float c = random(255);
        if (i%2 == 0) {
          //fill(255, 0, wd*5+55);
          fill(c, 150, 200);
        } else {
          fill(c, 150, 200);
        }
      }
      if (i == 0) ellipse(sg[i][0], sg[i][1], wd*2, wd*2);
      if (i == seg - 2) ellipse(sg[i+1][0], sg[i+1][1], wd*2, wd*2);
      

      
      beginShape();   
      vertex(sg[i][3], sg[i][4]);
      bezierVertex(sg[i][9], sg[i][10], sg[i+1][7], sg[i+1][8], sg[i+1][3], sg[i+1][4]);
      vertex(sg[i+1][5], sg[i+1][6]);
      bezierVertex(sg[i+1][11], sg[i+1][12], sg[i][13], sg[i][14], sg[i][5], sg[i][6]);
      endShape(CLOSE); 
      
      
      /* ************ afficher les points de controle
      stroke(200); strokeWeight(1);
      line(sg[i][3], sg[i][4], sg[i][7], sg[i][8]);
      line(sg[i][3], sg[i][4], sg[i][9], sg[i][10]);
      line(sg[i][5], sg[i][6], sg[i][11], sg[i][12]);
      line(sg[i][5], sg[i][6], sg[i][13], sg[i][14]); */
      
      /* ************ afficher les valeurs pour ce segment
      for (int j = 0; j < sg[i].length; j++) {
        println(i + " : " + j + " : " + sg[i][j]);
      } */
      
    }
    //println(); println();
  }
}
