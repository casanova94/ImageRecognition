function varargout = interfaz(varargin)
% Autor: Luis Angel Casanova Pech
%
% Para ejecutar el clasificador se debe llamar al script interfaz.m desde
% la ventana de comandos de matlab.
%
% Pasos para clasificar:
% *Clasificación de una imagen simple
% 1 - Una vez abierta la interfaz se debe de presionar el botón 'Cargar',
% se mostrará una ventana de selección, seleccionar la imagen a clasificar.
% 2 - Presionar el botón clasificar, se despliegará el resultado de la
% clasificación en un cuadro de texto.
%
% *Clasificar un conjunto de imagenes:
% 1 - En el directorio del programa se encuentra una carpeta llamada
% OtolitosGroup, las imagenes contenidas en esta carpeta serán
% clasificadas por lo que antes de iniciar la clasificación debe almacenar
% las imagenes en esta carpeta.
% 2 - Presionar el botón Cargar Datos,los datos dentro de la carpeta
% OtolitosGroup serán procesados y se obtendrán los descriptores. Nota: se
% mostrará un cuadro de texto indicando que se han terminado de cargar los
% datos a clasificar.
% 3 - Presionar el botón clasificar, se desplegará la lista del comjunto
% de imagenes con el resultado de la clasificación.
%
%
% Observación: El botón 'Entrenar Red' lee los datos almacenados en
% DataBase.xlsx, genera una red neruronal SOM y la entrena. Sin embargo  el
% software trabaja con una red neuronal entrenada previamente, la cual se
% importa al ejecutar el programa de manera automática. No es necesario presionar 
%'Entrenar Red'.
%
% Nota: Para la ejecución del software en otro computador es necesario
% reescribir los directorios donde se encuentra el proyecto. El código
% reescribir se encuentra en los scripts clasSet.m (lineas 3,4 y 5) y
% loadData.m (lineas 2,3 y 4). Se debe actualizar estos directorios con el
% nuevo directorio donde está almacenado el proyecto.
%
% INTERFAZ MATLAB code for interfaz.fig
%      INTERFAZ, by itself, creates a new INTERFAZ or raises the existing
%      singleton*.
%
%      H = INTERFAZ returns the handle to a new INTERFAZ or the handle to
%      the existing singleton*.
%
%      INTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFAZ.M with the given input arguments.
%
%      INTERFAZ('Property','Value',...) creates a new INTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before interfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to interfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help interfaz

% Last Modified by GUIDE v2.5 28-Nov-2016 12:09:36

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @interfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @interfaz_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before interfaz is made visible.
function interfaz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to interfaz (see VARARGIN)

% Choose default command line output for interfaz
handles.output = hObject;

%Add variable to hold images (Agregar variable para almacenar imgenes) 
handles.myImage = [];
handles.currentOption = 1;
handles.myImageMod = [];
handles.myBinImage = [];
handles.FileName = [];
handles.X = [];
setNet;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes interfaz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = interfaz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in botonCargar.
function botonCargar_Callback(hObject, eventdata, handles)
% hObject    handle to botonCargar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
startingFolder = 'C:\Program Files\MATLAB';
if ~exist(startingFolder, 'dir')
	% If that folder doesn't exist, just start in the current folder.
	startingFolder = pwd;
end
defaultFileName = fullfile(startingFolder, '*.tif;*.jpg;*.jpeg;*.bmp;*.gif;*.dcm;*.png');
[baseFileName, folder] = uigetfile(defaultFileName, 'Select a file');
if baseFileName == 0
	% User clicked the Cancel button.
	return;
end
fullFileName = fullfile(folder, baseFileName);
[pathstr,name,ext] = fileparts(fullFileName);
handles.FileName = fullFileName;
handles.myImage = imread(fullFileName);
handles.myImageMod = handles.myImage;
imshow(handles.myImage,'Parent', handles.axes1);
imshow(handles.myImage,'Parent', handles.axes2);
guidata(hObject, handles); 
 


% --- Executes on button press in botonHist.
function botonHist_Callback(hObject, eventdata, handles)
% hObject    handle to botonHist (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(1),imhist(rgb2gray(handles.myImage));


% --- Executes on button press in botonEq.
function botonEq_Callback(hObject, eventdata, handles)
% hObject    handle to botonEq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.myImageMod = histeq(rgb2gray(handles.myImage));
imshow(handles.myImageMod,'Parent', handles.axes2);
guidata(hObject, handles); 


% --- Executes on button press in botonSeg.
function botonSeg_Callback(hObject, eventdata, handles)
% hObject    handle to botonSeg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[bin,excentricidad] = segImage(handles.FileName);
handles.myImageMod = bin;
handles.myBinImage = bin;
imshow(handles.myImageMod,'Parent', handles.axes2);
guidata(hObject, handles); 



% --- Executes on button press in botonFirma.
function botonFirma_Callback(hObject, eventdata, handles)
% hObject    handle to botonFirma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[th,r] = signatura(handles.FileName);





% --- Executes on selection change in menuFiltro.
function menuFiltro_Callback(hObject, eventdata, handles)
% hObject    handle to menuFiltro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menuFiltro contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menuFiltro
handles.currentOption = get(handles.menuFiltro,'value');
guidata(hObject, handles);


% --- Executes during object creation, after setting all properties.
function menuFiltro_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuFiltro (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in botonClasificar.
function botonClasificar_Callback(hObject, eventdata, handles)
% hObject    handle to botonClasificar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[str]= clasObject(handles.FileName);
handles.X = str;
h = msgbox(handles.X);


% --- Executes on button press in buttonEntrenar.
function buttonEntrenar_Callback(hObject, eventdata, handles)
% hObject    handle to buttonEntrenar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%handles.X =
processData;
%h = msgbox(handles.X);


% --- Executes on button press in bottonClasificar.
function bottonClasificar_Callback(hObject, eventdata, handles)
% hObject    handle to bottonClasificar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.X = clasSet();
h = msgbox(handles.X);





% --- Executes on button press in botonCargarGrupo.
function botonCargarGrupo_Callback(hObject, eventdata, handles)
% hObject    handle to botonCargarGrupo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox('Cargando datos');
loadData
h = msgbox('Los datos han sido cargados');

% --- Executes on button press in botonFiltrar.
function botonFiltrar_Callback(hObject, eventdata, handles)
% hObject    handle to botonFiltrar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (handles.currentOption==1)
    handles.myImageMod = sobelFilter(rgb2gray(handles.myImage));
    imshow(handles.myImageMod,'Parent', handles.axes2);
elseif(handles.currentOption==2)
   handles.myImageMod = meanFilter(rgb2gray(handles.myImage));
   imshow(handles.myImageMod,'Parent', handles.axes2);
end
h = msgbox('Imagen filtrada');
guidata(hObject, handles); 


% --- Executes on button press in fractalButton.
function fractalButton_Callback(hObject, eventdata, handles)
% hObject    handle to fractalButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[bin,excentricidad] = segImage(handles.FileName);
handles.myBinImage = bin;
boxCounting(handles.myBinImage);


% --- Executes on button press in saveImage.
function saveImage_Callback(hObject, eventdata, handles)
% hObject    handle to saveImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imwrite(handles.myImageMod,'newImage.jpg');
h = msgbox('Imagen guardada');


% --- Executes on slider movement.
function contrastSlider_Callback(hObject, eventdata, handles)
% hObject    handle to contrastSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
C = get(hObject,'Value');
handles.myImageMod = handles.myImage + C;
imshow(handles.myImageMod,'Parent', handles.axes2);
guidata(hObject, handles); 



% --- Executes during object creation, after setting all properties.
function contrastSlider_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contrastSlider (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on button press in textureButton.
function textureButton_Callback(hObject, eventdata, handles)
% hObject    handle to textureButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.X = descriptores(handles.FileName);
h = msgbox(handles.X);


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(1),imhist(rgb2gray(handles.myImageMod));


% --- Executes on button press in HistMod.
function HistMod_Callback(hObject, eventdata, handles)
% hObject    handle to HistMod (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
figure(1),imhist(rgb2gray(handles.myImageMod));


% --- Executes on slider movement.
function contraste_Callback(hObject, eventdata, handles)
% hObject    handle to contraste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
k = get(hObject,'Value');
handles.myImageMod = ((handles.myImage - 127)*k)+127;
imshow(handles.myImageMod,'Parent', handles.axes2);
guidata(hObject, handles); 



% --- Executes during object creation, after setting all properties.
function contraste_CreateFcn(hObject, eventdata, handles)
% hObject    handle to contraste (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function Zoom_Callback(hObject, eventdata, handles)
% hObject    handle to Zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
k = get(hObject,'Value');
axes(handles.axes2);
zoom('out');
zoom(k);
guidata(hObject, handles); 



% --- Executes during object creation, after setting all properties.
function Zoom_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Zoom (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end
