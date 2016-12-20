%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Autor: Luis Angel Casanova Pech                       Fecha: 13/10/2016
%
% Descripción: Este programa calcula la dimensión fractal de una imagen
% binaria utilizando el método de box counting.El programa recibe como
% parametro una imagen binaria
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function boxCounting(binImage)
L = [10,50,100,500,1000];
G = [];
for k=1:length(L)
[m n] = size(binImage);
%Cuadrados totales en la imagen
xBoxes = floor(n/L(k));
yBoxes = floor(m/L(k));
nBoxes = xBoxes * yBoxes;
%Intervalos auxiliares que delimitan cada cuadro
xIni = 1;
yIni = 1;
cBoxes = 0;
%Se recorre toda la imagen con un cuadro de tamaño L
for j=1:yBoxes
    for i=1:xBoxes
     if(sum(sum(binImage(yIni:j*L(k),xIni:i*L(k))))>=1)
         cBoxes = cBoxes + 1;
     end
      xIni = xIni + L(k);
    end
    xIni = 1;
    yIni = yIni + L(k);
end
%D = log(cBoxes)/log(1/L(k));
G(k,:) = [log(1/L(k)),log(cBoxes)];
end
% Se calcula la pendiente aproximada de la linea generada
D = polyfit(G(:,1),G(:,2),1);
figure,plot(G(:,1),G(:,2),'-*');
title(['Dimension fractal aproximada: ',num2str(D(1))]);
xlabel('log(1/L)'),ylabel('log(N)');
end