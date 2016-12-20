function [str] = clasObject(imageName)
global net;
type = '';
[bin,excentricidad] = segImage(imageName);
[triangularidad] = divim(bin);
X = [excentricidad triangularidad];
%Clasificar de datos con red entrenada
y = net(X');
classes = vec2ind(y);
if(classes == 1)type = char('Mero derecho');end
if(classes == 2)type = char('Chacci izquierdo');end
if(classes == 3)type = char('Mero izquierdo');end
if(classes == 4)type = char('Chacci derecho');end
str = sprintf('La imagen es %s',type);
clear X y classes;
end