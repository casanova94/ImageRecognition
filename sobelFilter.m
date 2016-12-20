function SB = sobelFilter(grayImage)
A=double(grayImage);
kernel1 = [-1 -2 -1;0 0 0;1 2 1];%para el eje x
kernel2 = [-1 0 1;-2 0 2;-1 0 1];%para el eje y
%calculo de la convolución
ImeanX=conv2(A,kernel1);
ImeanY=conv2(A,kernel2);
ImeanX=uint8(ImeanX);
ImeanY=uint8(ImeanY);
SB = ImeanX + ImeanY;
end