/*
 * @(#)MarchingMinkowski.java
 *
 * Subroutine: Does the calculation of the Minkowski Measures F, U, Chi.
 * 2008, Hubert Mantz, hubert.mantz@googlemail.com
 *
 * For PGM (portable greymap) images, the files Pixmap.java and ShortPixmap.java
 * (from http://www.enseignement.polytechnique.fr/profs/informatique/Philippe.Chassignet/PGM/ShortPixmap.java)
 * must be in the same directory as Measures.java and MarchingMinkowski.java.
 *
 * For all systems, use
 * > javac *.java
 * > java Measures image.pgm
 * for calculation of the Minkowski Measures.
 */

public class MarchingMinkowski {
	
  /* Minkowski Measures, with weighted side lengths */
  public double f = 0;
  public double u = 0;
  public double chi = 0;
    
  /** 
   * Constructor MarchingMinkowski 
   * Parameters: data as a 2D matrix, threshold
   */
  public MarchingMinkowski(short[][] matrix, float threshold) {
           
    int startX = 0;		       // start and end values of coordinates
    int startY = 0;
    int endX = matrix.length;
    int endY = matrix[0].length;

    int pattern = 0;                   // number of configuration (0...15)    
    float a1, a2, a3, a4;              // axis with weighted side lengths
	
    for (int i = startX; i < (endX - 1); i = i + 1) {
      for (int j = startY; j < (endY - 1); j = j + 1) {
        pattern = 0;        
        if (matrix[i][j] > threshold) pattern ++;          // is pixel 1 set ?
        if (matrix[i+1][j] > threshold) pattern += 2;      // is pixel 2 set ?
        if (matrix[i+1][j+1] > threshold) pattern += 4;    // is pixel 4 set ?
        if (matrix[i][j+1] > threshold) pattern += 8;      // is pixel 8 set ?

        // do the calculation according to the configuration

        switch (pattern) {
        
          case 0:
          
          break;

          case 1:
            a1 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i + 1][j]);
            a4 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i][j + 1]);
            f = f + .5f * a1 * a4;
            u = u + Math.sqrt(a1 * a1 + a4 * a4);
            chi = chi + .25f;
          break;

          case 2:
            a1 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i + 1][j]);
            a2 = (matrix[i + 1][j] - threshold) / (matrix[i + 1][j] - matrix[i + 1][j + 1]);
            f = f + .5f * (1 - a1) * (a2);
            u = u + Math.sqrt((1 - a1) * (1 - a1) + a2 * a2);
            chi = chi + .25f;
          break;

          case 3:
            a2 = (matrix[i + 1][j] - threshold) / (matrix[i + 1][j] - matrix[i + 1][j + 1]);
            a4 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i][j + 1]);
            f = f + a2 + .5f * (a4 - a2);
            u = u + Math.sqrt(1 + (a4 - a2) * (a4 - a2));
          break;

          case 4:
            a2 = (matrix[i + 1][j] - threshold) / (matrix[i + 1][j] - matrix[i + 1][j + 1]);
            a3 = (matrix[i][j + 1] - threshold) / (matrix[i][j + 1] - matrix[i + 1][j + 1]);
            f = f + .5f * (1 - a2) * (1 - a3);
            u = u + Math.sqrt((1 - a2) * (1 - a2) + (1 - a3) * (1 - a3));
            chi = chi + .25f;
          break;

          case 5:
            a1 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i + 1][j]);
            a2 = (matrix[i + 1][j] - threshold) / (matrix[i + 1][j] - matrix[i + 1][j + 1]);
            a3 = (matrix[i][j + 1] - threshold) / (matrix[i][j + 1] - matrix[i + 1][j + 1]);
            a4 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i][j + 1]);
            f = f + 1 - .5f * (1 - a1) * a2 - .5f * a3 * (1 - a4);
            u = u + Math.sqrt((1 - a1) * (1 - a1) + a2 * a2) + Math.sqrt(a3 * a3 + (1 - a4) * (1 - a4));
            chi = chi + .5f;
          break;

          case 6:
            a1 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i + 1][j]);
            a3 = (matrix[i][j + 1] - threshold) / (matrix[i][j + 1] - matrix[i + 1][j + 1]);
            f = f + (1 - a3) + .5f * (a3 - a1);
            u = u + Math.sqrt(1 + (a3 - a1) * (a3 - a1));
          break;

          case 7:
            a3 = (matrix[i][j + 1] - threshold) / (matrix[i][j + 1] - matrix[i + 1][j + 1]);
            a4 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i][j + 1]);
            f = f + 1 - .5f * a3 * (1 - a4);
            u = u + Math.sqrt(a3 * a3 + (1 - a4) * (1 - a4));
            chi = chi - .25f;
          break;

          case 8:
            a3 = (matrix[i][j + 1] - threshold) / (matrix[i][j + 1] - matrix[i + 1][j + 1]);
            a4 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i][j + 1]);
            f = f + .5f * a3 * (1 - a4);
            u = u + Math.sqrt(a3 * a3 + (1 - a4) * (1 - a4));
            chi = chi + .25f;
          break;

          case 9:
            a1 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i + 1][j]);
            a3 = (matrix[i][j + 1] - threshold) / (matrix[i][j + 1] - matrix[i + 1][j + 1]);
            f = f + a1 + .5f * (a3 - a1);
            u = u + Math.sqrt(1 + (a3 - a1) * (a3 - a1));
          break;

          case 10:
            a1 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i + 1][j]);
            a2 = (matrix[i + 1][j] - threshold) / (matrix[i + 1][j] - matrix[i + 1][j + 1]);
            a3 = (matrix[i][j + 1] - threshold) / (matrix[i][j + 1] - matrix[i + 1][j + 1]);
            a4 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i][j + 1]);
            f = f + 1 - .5f * a1 * a4 + .5f * (1 - a2) * (1 - a3);
            u = u + Math.sqrt(a1 * a1 + a4 * a4) + Math.sqrt((1 - a2) * (1 - a2) + (1 - a3) * (1 - a3));
            chi = chi + .5f;
          break;

          case 11:
            a2 = (matrix[i + 1][j] - threshold) / (matrix[i + 1][j] - matrix[i + 1][j + 1]);
            a3 = (matrix[i][j + 1] - threshold) / (matrix[i][j + 1] - matrix[i + 1][j + 1]);
            f = f + 1 - .5f * (1 - a2) * (1 - a3);
            u = u + Math.sqrt((1 - a2) * (1 - a2) + (1 - a3) * (1 - a3));
            chi = chi - .25f;
          break;

          case 12:
            a2 = (matrix[i + 1][j] - threshold) / (matrix[i + 1][j] - matrix[i + 1][j + 1]);
            a4 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i][j + 1]);
            f = f + (1 - a2) + .5f * (a2 - a4);
            u = u + Math.sqrt(1 + (a2 - a4) * (a2 - a4));
          break;

          case 13:
            a1 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i + 1][j]);
            a2 = (matrix[i + 1][j] - threshold) / (matrix[i + 1][j] - matrix[i + 1][j + 1]);
            f = f + 1 - .5 * (1 - a1) * a2;
            u = u + Math.sqrt((1 - a1) * (1 - a1) + a2 * a2);
            chi = chi - .25f;
´         break;

          case 14:
            a1 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i + 1][j]);
            a4 = (matrix[i][j] - threshold) / (matrix[i][j] - matrix[i][j + 1]);
            f = f + 1 - .5f * a1 * a4;
            u = u + Math.sqrt(a1 * a1 + a4 * a4);
            chi = chi - .25f;
          break;

          case 15:
            f ++;
          break;
        }
      }
    }
  }
}
