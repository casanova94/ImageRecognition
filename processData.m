function [s] = processData
X = xlsread('DataBase','A1:B30');
%Definición SOM
global net;
net = selforgmap([2 2]);
net = configure(net,X');
net.trainParam.epochs =200;
net.trainParam.showWindow=1;
%Entrenamiento
net = train(net,X');
%Clasificar de datos con red entrenada
y = net(X');
classes = vec2ind(y)
clear otolitos test;
end