clear;close all;clc;
I = imread('lena_gray.bmp');
D = dir('lena_gray.bmp');
sizeofD = D.bytes;
fprintf('The size of orignal image is %d\n',sizeofD);
imwrite(I,'compressed_image1.jpg');
D1 = dir('compressed_image1.jpg');
sizeofD1 = D1.bytes;
a = sizeofD1/sizeofD;
fprintf('The size of compressed_image1 is %d bytes\n',sizeofD1);
fprintf('The compression rate of MATLAB is %.2f',a);

I = double(I);
T=dctmtx(8);
FUN = @(block_struct)T*block_struct.data*T'; %2D-DCT function
F = blockproc(I,[8,8],FUN); %2D-DCT

QT = [16 11 10 16 24 40 51 61;
     12 12 14 19 26 58 60 55;
     14 13 16 24 40 57 69 56;
     14 17 22 29 51 87 80 62; 
     18 22 37 56 68 109 103 77;
     24 35 55 64 81 104 113 92;
     49 64 78 87 103 121 120 101;
     72 92 95 98 112 100 103 99]; %quantization table
 
%quantization
FUN1 = @(block_struct)block_struct.data./QT;
F_QT = blockproc(F,[8,8],FUN1);
F_QT = round(F_QT);

FUN2 = @(block_struct)block_struct.data.*QT;
G=blockproc(F_QT,[8,8],FUN2);
G = round(G);
FUN3 = @(block_struct)T'*block_struct.data*T; %inverse DCT function (2D-IDCT)
G = blockproc(G,[8,8],FUN3); %2D-IDCT
ERROR = I-G;
I = uint8(I);
G = uint8(G);
ERROR = uint8(ERROR);
figure;imshow(I),title('compressed_image1');
figure;imshow(ERROR),title('ERROR');
figure;imshow(G),title('compressed image');

imwrite(G,'compressed_image2.jpg');
D2 = dir('compressed_image2.jpg');
sizeofD2 = D2.bytes;
b = sizeofD2/sizeofD;
fprintf('The size of compressed_image2 is %d bytes\n',sizeofD2);
fprintf('The compression rate of this compressor is %.2f\n',b);
fprintf('In comparison, we lost %d bytes of image data in this compression\n',sizeofD1-sizeofD2);
fprintf('We improve %.2f',b-a);