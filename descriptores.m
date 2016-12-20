function [list]=descriptores(imageName)
I=imread(imageName);
Ing=rgb2gray(I);
[pixelByLevel levels] = imhist(Ing);
%imhist(Ing)
numOfPixel=sum(pixelByLevel);
%Calculamos la probabilidad de ocurrencia de cada nivel
P=pixelByLevel./numOfPixel;
%Calculamos el primer momento (Media de la intensidad) del histograma
M=sum(levels.*P);
%Calculamos el segundo momento (Varianza de la intensidad)
V=sum(((levels-M).^2).*P);
%Varianza normalizada
VN=V/((levels(length(levels))-1).^2);
DE=sqrt(V);
%Suavidad de la textura
R=1-(1/1+VN);
%Calculamos el tercer momento (skewness de la imagen) normalizado
S=sum(((levels-M).^3).*P);
%Calculo del tercer momento (curtosis)
C=sum(((levels-M).^4).*P);
%Calculo de la uniformidad
U=sum(P.^2);
%Datos a string
list = cell(1,1);
str = sprintf('Intensidad media = %f' ,M);
list{1} = str;
str = sprintf('Varianza = %f' ,V);
list{2} = str;
str = sprintf('Regularidad = %f' ,R);
list{3} = str;
str = sprintf('Sesgo = %f' ,S);
list{4} = str;
str = sprintf('Curtosis = %f' ,C);
list{5} = str;
str = sprintf('Uniformidad = %f' ,U);
list{6} = str;
end