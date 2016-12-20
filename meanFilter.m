function [M] = meanFilter(grayImage)
[m,n]= size(grayImage);
A = grayImage;
B = ones(m-2,n-2);
H = ones(3); 

%Algoritmo filtro de la mediana
for j=1:1:n-2
    for i=1:1:m-2
        H = A(i:i+2,j:j+2); 
        E = reshape(H,[1,9]);%presentamos la submatriz en forma de arreglo
        E = sort(E);
        B(i,j) = E(5);
    end 
end
%desplegamos los resultados
M = uint8(B);
end