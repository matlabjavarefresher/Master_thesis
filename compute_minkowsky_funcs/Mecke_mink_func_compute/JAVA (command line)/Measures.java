/*
 * @(#)Measures.java
 *
 * Calculates the Minkowski Measures F, U, Chi of an image. 
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

import java.io.*;
import java.text.*;
import java.util.*;

public class Measures {
    
  public static void main(String[] args) {
        
    String filename = args[0];           /* first command line argument is filename */
    ShortPixmap shortPixmap;             /* as image data, use short variables */
		
    /* Open image file */
    try {
      shortPixmap = new ShortPixmap(filename);
    } catch (IOException e) {
      shortPixmap = null; 
      System.err.println("Error: Open File");
      System.exit(1);
    }

    /* transform image data to matrix */
    short[][] matrix = new short[shortPixmap.width][shortPixmap.height];
    for (int i = 0; i < shortPixmap.width; i++)
      for (int j = 0; j < shortPixmap.height; j++)
        matrix[i][j] = shortPixmap.data[j * shortPixmap.width + i];	
  	
    /* Set decimal separator: "." and format */
    NumberFormat df = NumberFormat.getInstance(Locale.US);
    df.setMinimumFractionDigits(0);
    df.setMaximumFractionDigits(3);
    df.setGroupingUsed(false);

    for (int i = 0; i < 256; i++) {
      /* do the analysis */		
      MarchingMinkowski mm = new MarchingMinkowski(matrix, i);

      /* use standard output
       * format: 1st column: threshold
       *         2nd to 4th column: Minkowski Measures
       */
            
      System.out.print(df.format(i));
      System.out.print("   ");
      System.out.print(df.format(mm.f));
      System.out.print("   ");
      System.out.print("   ");
      System.out.print(df.format(mm.u));
      System.out.print("   ");
      System.out.print(df.format(mm.chi));
      System.out.println();	
    }
  }
} 	

