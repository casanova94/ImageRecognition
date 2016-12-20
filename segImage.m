function [bin,excentricidad] = segImage(Image)
im = imread(Image);
grayImage = rgb2gray(im);
[y,x] = size(grayImage);
nueva =zeros(y,x);
% Binarización(Otsu)
uOtsu = graythresh(grayImage);
imBin = im2bw(grayImage,uOtsu);
imBin=uint8(imBin);
% Etiquetar elementos
[etq,~]= bwlabel(imBin,8);
% Elegir el objeto mas grande
prop=regionprops(etq,{'Area'});
[~, indice]=max([prop.Area]);
ind_s = find(etq == indice);
nueva(ind_s)=255;
% Preparar la imagen segmentada
nueva = im2bw(nueva);
nueva= imfill(nueva,'holes');
bin = nueva;
%imshow(nueva)
% Obtenemos las propiedades de la imagen
prop=regionprops(nueva,{'Eccentricity'});
excentricidad = prop.Eccentricity;
end