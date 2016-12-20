function [t] = divim(Image)
nueva = Image;
prop=regionprops(nueva,{'Centroid','BoundingBox'});
%obtenemos las esquinas de la caja
x = prop.BoundingBox(1);
y = prop.BoundingBox(2);
x_width = prop.BoundingBox(3);
y_width = prop.BoundingBox(4);
%nueva imagen con la mitad derecha
li = [];
li = nueva(y:y+y_width,prop.Centroid(1):x+x_width);
%obtenemos propiedades de la nueva imagen
leftprop = regionprops(li,{'Area','ConvexImage'});
regArea = leftprop.Area;
%r2 = leftprop.Eccentricity;
[B,L,N] = bwboundaries(li,'noholes');
boundary = B{N};
%figure,plot(boundary(:,2), boundary(:,1),'r');
%hold on
[trix,triy] = minboundtri(boundary(:,2), boundary(:,1));
%plot(trix,triy);
ci = leftprop.ConvexImage;
cip =  regionprops(ci,{'Perimeter'});
ta = polyarea(trix,triy);
t = regArea / ta;
%figure, imshow(li)
end