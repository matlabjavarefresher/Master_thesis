
n=[1597;1639; 1569];
a=[100;  100;  100];
b=[500; 500; 500];
infile = 'C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\CT-2015-007.raw';

outfile = 'C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\CT-SMALL.raw';
reduce_file(infile, outfile, n, a, b)

outfile = 'C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\CT-SMALL_FLIPPED.raw';
reduce_file(infile, outfile, n, a, b, true)
b-a;


