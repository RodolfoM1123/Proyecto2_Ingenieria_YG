function varargout = composi_AVCcyg(varargin)
% COMPOSI_AVCCYG MATLAB code for composi_AVCcyg.fig
%      COMPOSI_AVCCYG, by itself, creates a new COMPOSI_AVCCYG or raises the existing
%      singleton*.
%
%      H = COMPOSI_AVCCYG returns the handle to a new COMPOSI_AVCCYG or the handle to
%      the existing singleton*.
%
%      COMPOSI_AVCCYG('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPOSI_AVCCYG.M with the given input arguments.
%
%      COMPOSI_AVCCYG('Property','Value',...) creates a new COMPOSI_AVCCYG or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before composi_AVCcyg_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to composi_AVCcyg_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help composi_AVCcyg

% Last Modified by GUIDE v2.5 13-Nov-2018 13:28:28

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @composi_AVCcyg_OpeningFcn, ...
                   'gui_OutputFcn',  @composi_AVCcyg_OutputFcn, ...
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


% --- Executes just before composi_AVCcyg is made visible.
function composi_AVCcyg_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to composi_AVCcyg (see VARARGIN)

% Choose default command line output for composi_AVCcyg
global MAVCgyc
global Rr
global temp
global datos
global kij2
global xij2
format long; %16 decimales para un mejor cálculo.
compi=importdata('dat_comp_avcgyc.txt'); %importamos los datos del archivo txt
compo=compi.rowheaders';% la composición 
datos=compi.data'; %Los valores de yij
reng=length(datos(:,1)); %número de renglones
col=length(datos(1,:)); %Número de columnas
yij=zeros(reng,col-1); %Generamos una matriz yij sin la columna de presiones
for i=1:reng
    for j=2:col
        yij(i,j-1)=datos(i,j); %Pasamos los datos sin la columna de presiones
    end
end
set(handles.dat_comp_cyg,'data',datos);%imprimimos los datos en la primer tabla
set(handles.dat_comp_cyg,'ColumnName',compo); %imprimimos los datos en la segunda tabla
nt=MAVCgyc(1,1)./MAVCgyc(1,6)./10.73./temp; %total de moles cuando v=1
dng=zeros(reng,1); %Llenamos una matriz de 0 de tamaño definido para ahorro de memoria 
dngacum=zeros(reng,1);% ""
ngrk=zeros(reng,1); %""
nlrk=zeros(reng,1);%""
dng=nt.*Rr(:,9); %DElta de moles de gas
for i=2:reng
    dngacum(i,1)=dng(i,1)+dngacum(i-1,1); %El acumulado de los moles
end
ngrk=MAVCgyc(:,1).*MAVCgyc(:,2)./100./MAVCgyc(:,6)./10.73./temp; %Moles de gas remanentes
nlrk=nt-ngrk(:,1)-dngacum(:,1); %moles de líquido remanentes
for i=1:reng
    for j=1:col-1
        DDngj(i,j)=yij(i,j)*dng(i,1)/100; %Moles de gas extraido por componente
        DDngrj(i,j)=yij(i,j)*ngrk(i,1)/100; %Moles de gas remanente por componente   
    end
end
DDngacum(1,:)=DDngj(1,:); %La primer etapa había los mismos moles
for i=2:reng
    for j=1:col-1
        DDngacum(i,j)=DDngj(i,j)+DDngacum(i-1,j); %El acumulado por componente de gas extraído
    end
end
xij=zeros(reng,col-1); %Matriz de 0 para ahorro de memoria
xij(1,:)=yij(1,:)./100; 
for i=2:reng
    for j=1:col-1
        xij(i,j)=(nt*xij(1,j)-DDngrj(i,j)-DDngacum(i,j))/nlrk(i,1);  %Moles remanentes de líquido
    end
end
kij=zeros(reng,col-1); %Matriz de 0 para ahorro de memoria
kij2=zeros(reng,col); %Matriz de 0 para ahorro de memoria
xij2=zeros(reng,col);%Matriz de 0 para ahorro de memoria
kij=yij(:,:)./xij(:,:)/100; %Coeficientes de equilíbrio
for i=1:reng
    for j=1:col-1
        xij2(i,j+1)=xij(i,j); %Incluimos una matriz con xij y las presiones
        kij2(i,j+1)=kij(i,j); %Incluimos una matriz con kij y las presiones
    end
end
xij2(:,1)=datos(:,1);% la primer columna es de presiones
kij2(:,1)=datos(:,1);% la primer columna es de presiones.
set(handles.tabnlrk_avc, 'data', xij2); %Imprimimos los valores de xij
set(handles.tabnlrk_avc,'ColumnName',compo); %Imprimimos los componentes
set(handles.tabkij,'data',kij2); %Imprimimos los valores de kij
set(handles.tabkij,'ColumnName',compo); %Imprimimos los componentes

handles.output = hObject;
guidata(hObject, handles);

% UIWAIT makes composi_AVCcyg wait for user response (see UIRESUME)
% uiwait(handles.figure1);


%--- Outputs from this function are returned to the command line.
function varargout = composi_AVCcyg_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA
% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pagraficar.
function pagraficar_Callback(hObject, eventdata, handles)
% hObject    handle to pagraficar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
A=get(handles.menugraficar,'value');%Obtenemos qué quiere graficar el usuario
global datos
global kij2
global xij2
column=length(kij2(1,:)); %Número de componentes 
alf=datos(:,:)./100; %Nos dan en % y se requiere en decimal
switch A
    case 1
        hold off %Dejamos el hold off
        plot(0,0) %limpiamos la gráfica
        hold on %Para mantener la grafica todos los componentes
        for i=2:column
        plot(datos(:,1),datos(:,i));
        grid on
        xlabel('Presión [psia]')
        end
    case 2
        hold off
        plot(0,0)
        hold on
        for i=2:column
        plot(xij2(:,1),xij2(:,i));
        grid on
        xlabel('Presión [psia]')
        end
    case 3
        hold off
        plot(0,0)
        hold on
        for i=2:column
        plot(kij2(:,1),kij2(:,i));
        grid on
        xlabel('Presión [psia]')
        end
end

% --- Executes on selection change in menugraficar.
function menugraficar_Callback(hObject, eventdata, handles)
% hObject    handle to menugraficar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menugraficar contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menugraficar


% --- Executes during object creation, after setting all properties.
function menugraficar_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menugraficar (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
