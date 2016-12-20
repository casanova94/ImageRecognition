function [] = test(Image)
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
prop=regionprops(nueva,{'Centroid','MajorAxisLength','MinorAxisLength','Orientation','BoundingBox'});
imshow(nueva)
hold on
plot(prop.Centroid(1),prop.Centroid(2),'*');
hold on
[B,L,N] = bwboundaries(nueva);
boundary = B{N};
plot(boundary(:,2), boundary(:,1), 'g','LineWidth',2);
hold on
r =  rectangle('Position',[prop.BoundingBox(1),prop.BoundingBox(2),prop.BoundingBox(3),prop.BoundingBox(4)],'EdgeColor','r','LineWidth',2 );
r
 % 
% lineLength = prop.MajorAxisLength/2;
% angle = prop.Orientation;
% x(1) = prop.Centroid(1);
% y(1) = prop.Centroid(2);
% x(2) = x(1) + lineLength * cosd(angle);
% y(2) = y(1) + lineLength * sind(angle);
% plot(x,y,'*r');

end