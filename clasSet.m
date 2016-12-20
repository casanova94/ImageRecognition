function [list] = clasSet()
list = cell(30,1);
files = [dir('C:\Users\luis\Documents\ProyectoAnalisisComputacional\OtolitosGroup\*.png');
        dir('C:\Users\luis\Documents\ProyectoAnalisisComputacional\OtolitosGroup\*.jpg');
        dir('C:\Users\luis\Documents\ProyectoAnalisisComputacional\OtolitosGroup\*.bmp')];
global net;
X = xlsread('DataBaseGroup','A1:B30');
%Clasificar de datos con red entrenada
y = net(X');
classes = vec2ind(y);
for k = 1:length(files) 
name = files(k).name;
if(classes(k)==4)
type = char('Chacci derecho');
str = sprintf('La imagen %s es %s' ,name,type);
else
    if(classes(k)==2)
    type = char('Chacci izquierdo');
    str = sprintf('La imagen %s es %s' ,name,type);
    else
        if(classes(k)==1)
       type = char('Mero derecho');
       str = sprintf('La imagen %s es %s' ,name,type);
        else
       type = char('Mero izquierdo');
       str = sprintf('La imagen %s es %s' ,name,type);
        end
    end
end
list{k} = [str];
end
end