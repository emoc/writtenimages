class LUT {

  /**
  adapted from :
  sincoslookup taken from http://wiki.processing.org/index.php/Sin/Cos_look-up_table
  @author toxi (http://www.processinghacks.com/user/toxi)
  */
 
  // declare arrays and params for storing sin/cos values 
  float sinLUT[];
  float cosLUT[];
  
  float SC_PRECISION = 1f; // set table precision to X degrees
  float SC_INV_PREC = 1/SC_PRECISION; // caculate reciprocal for conversions
  int SC_PERIOD = (int) (360f * SC_INV_PREC); // compute required table length

  LUT() {
    sinLUT = new float[SC_PERIOD];
    cosLUT = new float[SC_PERIOD];
    for (int i = 0; i < SC_PERIOD; i++) {
      sinLUT[i] = (float) Math.sin(i * DEG_TO_RAD * SC_PRECISION);
      cosLUT[i] = (float) Math.cos(i * DEG_TO_RAD * SC_PRECISION);
    }
  }
  
  float posAng(float ang) {
    //println("ang" + ang);
    //ang = 360 - (ang % 360);
    ang = 360 - ang;
    return ang;
  }
  
  public float sinlut(float ang) {
    if (ang < 0) ang = posAng(ang);
    int theta=(int)((ang*SC_INV_PREC) % SC_PERIOD);
    return sinLUT[theta];
  }
  
  public float coslut(float ang) {
    if (ang < 0) ang = posAng(ang);
    int theta=(int)((ang*SC_INV_PREC) % SC_PERIOD);
    return cosLUT[theta];
  }
  
}
