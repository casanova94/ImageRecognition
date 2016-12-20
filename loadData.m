filename = 'DataBaseGroup.xlsx';
files = [dir('C:\Users\luis\Documents\ProyectoAnalisisComputacional\OtolitosGroup\*.png');
        dir('C:\Users\luis\Documents\ProyectoAnalisisComputacional\OtolitosGroup\*.jpg');
        dir('C:\Users\luis\Documents\ProyectoAnalisisComputacional\OtolitosGroup\*.jpg')];
dataToBase = [];
bin = [];
disp('Cargando datos');
for k = 1:length(files) 
name = files(k).name;
path = 'C:\Users\luis\Documents\ProyectoAnalisisComputacional\OtolitosGroup\';
[bin,excentricidad] = segImage(strcat(path,name));
[triangularidad] = divim(bin);
dataToBase(k,1) = excentricidad;
dataToBase(k,2) = triangularidad;
end
if(~isempty(files))
xlswrite(filename,dataToBase,'Hoja1','A1');
end
clear filename files clear k name path im triangularidad excentricidad rectangularidad dataToBase bin;