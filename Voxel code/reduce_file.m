function reduce_file(in_file, out_file, n, a, b, flip)


fidin = fopen(in_file, 'r', 'l');
fidout = fopen(out_file, 'w+', 'l');

if nargin>=6 && flip
    n=flipud(n(:));
    a=flipud(a(:));
    b=flipud(b(:));
end

for i1=a(1):b(1)-1
    for i2=a(2):b(2)-1
        n0 = i1 * n(2) * n(3) + i2 * n(3) + a(3);
        fseek(
        fidin, n0, 'bof');
        data = fread(fidin, b(3) - a(3), 'uint16')
        fwrite(fidout, data, 'uint16');
    end
end

fclose(fidin);
fclose(fidout);


% reduce_file( 'mouse.raw', 'mouse_detail.raw', [200, 300, 400], [1, 10,
% 10], [30, 100, 120])