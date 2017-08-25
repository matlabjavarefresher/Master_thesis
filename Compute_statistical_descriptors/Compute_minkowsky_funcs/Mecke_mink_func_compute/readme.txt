MarchingMinkowski
=================

For further information or assistance in compiling, contact:
Hubert Mantz, hubert.mantz@googlemail.com
January, 2008

1. Command line version for C
-----------------------------

1.1.	Copy the files
	- MarchingMinkowski.c
        - pixmap_io.c and pixmap.io_h
	  (from http://www.enseignement.polytechnique.fr/profs/informatique/Philippe.Chassignet/PGM/pgm_c.html)
        to one directory.

1.2.	For Unix / Linux systems: Compile and start by
	> gcc -lm -oMarchingMinkowski MarchingMinkowski.c pixmap_io.c
	> MarchingMinkowski image.pgm

1.3.	For Windows / DOS systems: Compile and start by
	> gcc -lm -oMarchingMinkowski.exe MarchingMinkowski.c pixmap_io.c
	> MarchingMinkowski image.pgm
	
2. Command line version for JAVA
--------------------------------

2.1.	Make sure you have installed a JDK (Java Development Kit).

2.2.	Copy the files
	- MarchingMinkowski.java
        - Measures.java 
	- Pixmap.java and ShortPixmap.java
	  (from http://www.enseignement.polytechnique.fr/profs/informatique/Philippe.Chassignet/PGM/ShortPixmap.java)
        to one directory.

2.3.	For all systems: Compile and start by
	> javac *.java
	> java Measures image.pgm

	or use the pre-compiled version by
	> java Measures image.pgm

3. Graphical User Interface (GUI) for JAVA
------------------------------------
(source code not included)

3.1.	Go to directory "JAVA (GUI)"

3.2.	Start the Graphical User Interface by
	> java Minkowski

3.3.	Load an .pgm (File/Open) image and select "Show/Greyscale Image". The analysis options are self-explanatory.


