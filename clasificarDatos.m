function [] = clasificarDatos(net)
%Debemos de leer los nuevos datos en una base y de ahi analizamos
X = xlsread('OtoDataBase','A1:C30');
w = net(X');
classes = vec2ind(w);
X = sprintf('Se identificaron %d peces CHACCI.',length(find(classes == 2)));
disp(X)
X = sprintf('Se identificaron %d peces MERO.',length(find(classes == 1)));
disp(X)
end