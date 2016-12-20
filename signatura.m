function [th,r] = signatura(Image)
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
figure,subplot(1,2,1),imshow(nueva)
hold on;
% Obtenemos las propiedades de la imagen
[B,L,N] = bwboundaries(nueva,'noholes');
propiedades = regionprops(nueva,{'Centroid'});

%Imprimimos el contorno de la figura
for cnt = 1:N
boundary = B{cnt};
subplot(1,2,1),plot(boundary(1,2), boundary(1,1),'*'); 
subplot(1,2,1),plot(boundary(:,2), boundary(:,1),'r'); 
[centro] = propiedades(cnt).Centroid;
text(centro(1),centro(2),'+');
boundary2=[boundary(:,1)-centro(2),boundary(:,2)-centro(1)];
[th, r]=cart2pol(boundary2(:,2),boundary2(:,1));
r=r*pi/180;
subplot(1,2,2),plot(th,r,'.');
yLimit = max(r) + min(r);
axis([-pi pi 0 yLimit]);
end


end