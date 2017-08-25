/* MarchingMinkowski.c   
 * ----------------------------------------------
 * Calculates the Minkowski Measures F, U, Chi of an image. 
 * 2008, Hubert Mantz, hubert.mantz@googlemail.com
 *
 * For PGM (portable greymap) images, the files pixmap_io.c and pixmap.io_h
 * (from http://www.enseignement.polytechnique.fr/profs/informatique/Philippe.Chassignet/PGM/pgm_c.html)
 * must be in the same directory as MarchingMinkowski.c.
 *
 * If you use the GnuC - Compiler e.g., use (Unix / Linux)
 * > gcc -lm -oMarchingMinkowski MarchingMinkowski.c pixmap_io.c
 * > MarchingMinkowski image.pgm
 * for calculation of the Minkowski Measures.
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include "pixmap_io.h"                           // for PGM image import (see above)

unsigned char *image_data;                       // image data (color values)
int width, height;                               // image width and height

int threshold;                                   // threshold to be used

// ----------------------------------------------
/* CMM: subroutine that calculates MinkowskiMeasures
 * - of image stored in "data"
 * - using the value "threshold"
 * and sends them to standard output 
 * (find the for source code below)
 */
void CMM(unsigned char *data, int threshold);
// ----------------------------------------------

// ----------------------------------------------
/* main routine
 * (can be adjusted to other image formats easily)
 */ 
int main(int argc, char **argv)
{
  // main routine: this software must have exactly (!) 
  // _one_ command line parameter: the filename (.pgm)
  if (argc != 2) {
    printf("usage: %s pgm-File\n", argv[0]);
    exit(1);
  }

  // calculate all Minkowski Measures (256 in this case) of image stored in Image_data
  if ((image_data = load_pixmap(argv[1], &width, &height)) != NULL)
    for (threshold = 0; threshold < 256; threshold++)
      CMM(image_data, threshold);
}
// ----------------------------------------------

// ----------------------------------------------
/* CMM: subroutine that calculates MinkowskiMeasures and writes them to standard output 
 * - of image stored in "data"
 * - using the value "threshold"
 */
void CMM(unsigned char *data, int threshold)
{
  int i, j;      // counting variables
  
  double a1, a2, a3, a4;                         // axis with weighted side lengths
  int pattern = 0;                               // number of configuration (0...15)

  double f = 0;                                  // MinkowskiMeasures
  double u = 0; 
  double chi = 0;

  // loops to consider all pixels of the image
  for (i = 0; i < (width - 1); i = i + 1) {
    for (j = 0; j < (height - 1); j = j + 1) {

      // determine configuration of the pixel
      pattern = 0;
      if (data[(j*width+i)] > threshold) pattern++;             // is pixel 1 set ?
      if (data[(j*width+i+1)] > threshold) pattern += 2;        // is pixel 2 set ?
      if (data[((j+1)*width+i+1)] > threshold) pattern += 4;    // is pixel 4 set ?
      if (data[((j+1)*width+i)] > threshold) pattern += 8;      // is pixel 8 set ?

      // do the calculation according to the configuration
      switch (pattern) {
      
        case 0:
        break;

        case 1:
          a1 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[(j*width+i+1)]);
          a4 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[((j+1)*width+i)]);
          f = f + 0.5 * a1 * a4;
          u = u + sqrt(a1 * a1 + a4 * a4);
          chi = chi + 0.25;
        break;

        case 2:
          a1 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[(j*width+i+1)]);
          a2 = (data[(j*width+i+1)] - (float)threshold) / (data[(j*width+i+1)] - data[((j+1)*width+i+1)]);
          f = f + 0.5 * (1 - a1) * (a2);
          u = u + sqrt((1 - a1) * (1 - a1) + a2 * a2);
          chi = chi + 0.25;
        break;

        case 3:
          a2 = (data[(j*width+i+1)] - (float)threshold) / (data[(j*width+i+1)] - data[((j+1)*width+i+1)]);
          a4 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[((j+1)*width+i)]);
          f = f + a2 + 0.5 * (a4 - a2);
          u = u + sqrt(1 + (a4 - a2) * (a4 - a2));
        break;

        case 4:
          a2 = (data[(j*width+i+1)] - (float)threshold) / (data[(j*width+i+1)] - data[((j+1)*width+i+1)]);
          a3 = (data[((j+1)*width+i)] - (float)threshold) / (data[((j+1)*width+i)] - data[((j+1)*width+i+1)]);
          f = f + 0.5 * (1 - a2) * (1 - a3);
          u = u + sqrt((1 - a2) * (1 - a2) + (1 - a3) * (1 - a3));
          chi = chi + 0.25;
        break;

        case 5:
          a1 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[(j*width+i+1)]);
          a2 = (data[(j*width+i+1)] - (float)threshold) / (data[(j*width+i+1)] - data[((j+1)*width+i+1)]);
          a3 = (data[((j+1)*width+i)] - (float)threshold) / (data[((j+1)*width+i)] - data[((j+1)*width+i+1)]);
          a4 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[((j+1)*width+i)]);
          f = f + 1 - 0.5 * (1 - a1) * a2 - 0.5 * a3 * (1 - a4);
          u = u + sqrt((1 - a1) * (1 - a1) + a2 * a2) + sqrt(a3 * a3 + (1 - a4) * (1 - a4));
          chi = chi + 0.5;
        break;

        case 6:
          a1 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[(j*width+i+1)]);
          a3 = (data[((j+1)*width+i)] - (float)threshold) / (data[((j+1)*width+i)] - data[((j+1)*width+i+1)]);
          f = f + (1 - a3) + 0.5 * (a3 - a1);
          u = u + sqrt(1 + (a3 - a1) * (a3 - a1));
        break;

        case 7:
          a3 = (data[((j+1)*width+i)] - (float)threshold) / (data[((j+1)*width+i)] - data[((j+1)*width+i+1)]);
          a4 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[((j+1)*width+i)]);
          f = f + 1 - 0.5 * a3 * (1 - a4);
          u = u + sqrt(a3 * a3 + (1 - a4) * (1 - a4));
          chi = chi - 0.25;
        break;

        case 8:
          a3 = (data[((j+1)*width+i)] - (float)threshold) / (data[((j+1)*width+i)] - data[((j+1)*width+i+1)]);
          a4 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[((j+1)*width+i)]);
          f = f + 0.5 * a3 * (1 - a4);
          u = u + sqrt(a3 * a3 + (1 - a4) * (1 - a4));
          chi = chi + 0.25;
        break;

        case 9:
          a1 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[(j*width+i+1)]);
          a3 = (data[((j+1)*width+i)] - (float)threshold) / (data[((j+1)*width+i)] - data[((j+1)*width+i+1)]);
          f = f + a1 + 0.5 * (a3 - a1);
          u = u + sqrt(1 + (a3 - a1) * (a3 - a1));
        break;

        case 10:
          a1 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[(j*width+i+1)]);
          a2 = (data[(j*width+i+1)] - (float)threshold) / (data[(j*width+i+1)] - data[((j+1)*width+i+1)]);
          a3 = (data[((j+1)*width+i)] - (float)threshold) / (data[((j+1)*width+i)] - data[((j+1)*width+i+1)]);
          a4 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[((j+1)*width+i)]);
          f = f + 1 - 0.5 * a1 * a4 + 0.5 * (1 - a2) * (1 - a3);
          u = u + sqrt(a1 * a1 + a4 * a4) + sqrt((1 - a2) * (1 - a2) + (1 - a3) * (1 - a3));
          chi = chi + 0.5;
        break;

        case 11:
          a2 = (data[(j*width+i+1)] - (float)threshold) / (data[(j*width+i+1)] - data[((j+1)*width+i+1)]);
          a3 = (data[((j+1)*width+i)] - (float)threshold) / (data[((j+1)*width+i)] - data[((j+1)*width+i+1)]);
          f = f + 1 - 0.5 * (1 - a2) * (1 - a3);
          u = u + sqrt((1 - a2) * (1 - a2) + (1 - a3) * (1 - a3));
          chi = chi - 0.25;
        break;

        case 12:
          a2 = (data[(j*width+i+1)] - (float)threshold) / (data[(j*width+i+1)] - data[((j+1)*width+i+1)]);
          a4 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[((j+1)*width+i)]);
          f = f + (1 - a2) + 0.5 * (a2 - a4);
          u = u + sqrt(1 + (a2 - a4) * (a2 - a4));
        break;

        case 13:
          a1 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[(j*width+i+1)]);
          a2 = (data[(j*width+i+1)] - (float)threshold) / (data[(j*width+i+1)] - data[((j+1)*width+i+1)]);
          f = f + 1 - .5 * (1 - a1) * a2;
          u = u + sqrt((1 - a1) * (1 - a1) + a2 * a2);
          chi = chi - 0.25;
        break;

        case 14:
          a1 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[(j*width+i+1)]);
          a4 = (data[(j*width+i)] - (float)threshold) / (data[(j*width+i)] - data[((j+1)*width+i)]);
          f = f + 1 - 0.5 * a1 * a4;
          u = u + sqrt(a1 * a1 + a4 * a4);
          chi = chi - 0.25;
        break;

        case 15:
          f ++;
        break;

      } // switch
    } // j - loop
  } // i - loop
  
  printf("%d  %.3f  %.3f  %.2f\n", threshold, f, u, chi);
}
// ----------------------------------------------
