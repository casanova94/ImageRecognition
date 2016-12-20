function [t] = tortuosity(points)
n = length(points);
dcurve = 0;
for i=1:n-1
    dcurve = dcurve + pdist2(points(i,:),points(i+1,:));
end
dstraight = pdist2(points(1,:),points(n,:));
%calculo de la tortuosidad
t = dcurve/dstraight;
end