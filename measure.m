function measure(CHACCI,MERO,CLASSES)
a = 0;
b = 0;
c = 0;
d = 0;

n = length(CLASSES(1:CHACCI));
m = length(CLASSES(CHACCI+1:CHACCI+MERO));
for i=1:n
    if(CLASSES(i)==2)d = d + 1;
    else
        b = b + 1;
    end
end
for i=1:m
    if(CLASSES(CHACCI + i)==1)a = a + 1;
    else
        c = c + 1;
    end
end
% Similitud de Jaccard
S = a / (a + b + c)
end

