infile = 'C:\Users\prem ratan\Documents\books\academic\UQ_HIWI_PROJECT\Voxel files\CT-SMALL';

fid = fopen(infile, 'rb');
a = fread(fid, 400*400*400, 'uint16');
fclose(fid);

body = reshape(a, [400 400 400]);
clear a;

imagesc(body(:,:,1));