function [p] = perimetro(points)
n = length(points);
p = 0;
for i=1:n-1
    p = p + pdist2(points(i,:),points(i+1,:));
end
end