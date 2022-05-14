function varargout = AVC_GyC(varargin)
% AVC_GYC MATLAB code for AVC_GyC.fig
%      AVC_GYC, by itself, creates a new AVC_GYC or raises the existing
%      singleton*.
%
%      H = AVC_GYC returns the handle to a new AVC_GYC or the handle to
%      the existing singleton*.
%
%      AVC_GYC('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AVC_GYC.M with the given input arguments.
%
%      AVC_GYC('Property','Value',...) creates a new AVC_GYC or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AVC_GyC_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AVC_GyC_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AVC_GyC

% Last Modified by GUIDE v2.5 12-Nov-2018 16:17:32

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AVC_GyC_OpeningFcn, ...
                   'gui_OutputFcn',  @AVC_GyC_OutputFcn, ...
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


% --- Executes just before AVC_GyC is made visible.
function AVC_GyC_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AVC_GyC (see VARARGIN)

% Choose default command line output for AVC_GyC
global MAVCgyc
archivo=importdata('datosavcgyc.txt');
MAVCgyc=archivo.data;
MAVCgyc(:,2)=MAVCgyc(:,2)./100;
set(handles.tab_dat_avcgyc,'data',MAVCgyc);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AVC_GyC wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AVC_GyC_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function vil_Callback(hObject, eventdata, handles)
% hObject    handle to vil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vil as text
%        str2double(get(hObject,'String')) returns contents of vil as a double


% --- Executes during object creation, after setting all properties.
function vil_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vil (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vlmc_Callback(hObject, eventdata, handles)
% hObject    handle to vlmc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vlmc as text
%        str2double(get(hObject,'String')) returns contents of vlmc as a double


% --- Executes during object creation, after setting all properties.
function vlmc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vlmc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function temp_Callback(hObject, eventdata, handles)
% hObject    handle to temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function temp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to temp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in elchido.
function elchido_Callback(hObject, eventdata, handles)
global MAVCgyc
global Rr
global temp
    vci=5.615.*str2num(get(handles.vil,'string'));
    vlmc=5.615.*str2num(get(handles.vlmc, 'string'));
    temp=str2num(get(handles.temp,'string'));
    tama=length(MAVCgyc(:,1));
    prop=21;
    %Iniciales
    Rr=zeros(tama,prop);
    Rr(:,1)=MAVCgyc(:,1); %Presiones psia
    Rr(:,2)=vci.*MAVCgyc(:,2)/5.615; %Volumen de líquido remanente rbl
    Bgi=14.7*MAVCgyc(1,5)*temp/520/Rr(1,1);
    Rr(1,3)=1;
    Rr(1,4)=vci/5.615;
    Rr(1,5)=Rr(1,4)-Rr(1,2);
    Rr(1,6)=Rr(1,4)-vci/5.615;
    Rr(1,7)=Rr(1,1)*Rr(1,5)*MAVCgyc(1,5)/Rr(1,1)/(vci/5.615)/MAVCgyc(1,6);
    Rr(1,8)=Rr(1,6)/Rr(1,5);%Para el calculo Gas extraido [1]
    Rr(1,9)=Rr(1,8)*Rr(1,7); %Relacion de moles de gas extraido 
    Rr(1,10)=0; %Delta Gp mcft
    Rr(1,11)=0; %Delta Np brls
    Rr(1,12)=vci/Bgi/1000;
    Rr(1,13)=vlmc/5.615;
    Rr(1,14)=Rr(1,12); %Gas producido del gas (Gas seco) mscf 
    Rr(1,15)=Rr(1,13);% Líquido producido del gas. (Condensados) blls
    Rr(1,16)=Rr(1,12)-Rr(1,14); %Gas producido del líquido (Vapor) mscf 
    Rr(1,17)=Rr(1,13)-Rr(1,15); %Líquido muerto. blls
    Rr(1,18)=Rr(1,2)/Rr(1,17); %Bo [rbl/rbL]
    Rr(1,19)=Bgi/5.615*1000; %Bg [scft/rcft] 
    Rr(1,20)=Rr(1,16)/Rr(1,17);%Rs mscf/bll
    Rr(1,21)=Rr(1,15)/Rr(1,14);%Rv bll/mscf
    %/////////////////////////////////////////////////////////
    for i=2:tama
        j=i-1; 
        Rr(i,3)=Rr(j,1)*MAVCgyc(1,5)/Rr(1,1)/MAVCgyc(j,5); %Relacion mol(etapa)
        Rr(i,4)=Rr(1,1)*MAVCgyc(i,5)*Rr(i,3)*vci/Rr(i,1)/MAVCgyc(1,5)/5.615; %Volumen total en la celda. rbl
        Rr(i,5)=Rr(i,4)-Rr(i,2); %Volumen de gas remanente bls
        Rr(i,6)=Rr(i,4)-vci/5.615; %Delta de gas extraido.  blls
        Rr(i,7)=Rr(i,1)*Rr(i,5)*MAVCgyc(1,5)/Rr(1,1)/vci*5.615/MAVCgyc(i,6); %Moles de gas remanente.
        Rr(i,8)=Rr(i,6)/Rr(i,5);%Para el calculo Gas extraido [1]
        Rr(i,9)=Rr(i,8)*Rr(i,7); %Relacion de moles de gas extraido 
        Rr(i,10)=MAVCgyc(i,3)-MAVCgyc(j,3); %Delta Gp mcft
        Rr(i,11)=MAVCgyc(i,4)-MAVCgyc(j,4); %Delta Np brls
        Rr(i,12)=Rr(j,12)-Rr(j,10); %Volumen original de gas en la etapa mscf
        Rr(i,13)=Rr(j,13)-Rr(j,11); %Volumen de aceite en la etapa. blls
        Rr(i,14)=Rr(i,10)*Rr(i,5)/Rr(i,6); %Gas producido del gas (Gas seco) mscf 
        Rr(i,15)=Rr(i,11)*Rr(i,5)/Rr(i,6);% Líquido producido del gas. (Condensados) blls
        Rr(i,16)=Rr(i,12)-Rr(i,14); %Gas producido del líquido (Vapor) mscf 
        Rr(i,17)=Rr(i,13)-Rr(i,15); %Líquido muerto. blls
        Rr(i,18)=Rr(i,2)/Rr(i,17); %Bo [rbl/rbL]
        Rr(i,19)=Rr(i,5)/Rr(i,14); %Bg [scft/rcft] 
        Rr(i,20)=Rr(i,16)/Rr(i,17);%Rs mscf/bll
        Rr(i,21)=Rr(i,15)/Rr(i,14);%Rv bll/mscf         
    end
set(handles.tab_res_avcgyc,'data',Rr);



% --- Executes on selection change in graf_avc.
function graf_avc_Callback(hObject, eventdata, handles)
% hObject    handle to graf_avc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns graf_avc contents as cell array
%        contents{get(hObject,'Value')} returns selected item from graf_avc


% --- Executes during object creation, after setting all properties.
function graf_avc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to graf_avc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in graficadora_boton.
function graficadora_boton_Callback(hObject, eventdata, handles)
% hObject    handle to graficadora_boton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
var=get(handles.graf_avc,'value');
global Rr
switch var
    case 1
        plot(Rr(:,1),Rr(:,17+var),'c--');
        ylabel('Bo [rbl/stb]');
        xlabel('Presión [psia]');
    case 2
        plot(Rr(:,1),Rr(:,17+var),'c--');
        ylabel('Bg [rbl/Mscf]');
        xlabel('Presión [psia]');
    case 3
        plot(Rr(:,1),Rr(:,17+var),'c--');
        ylabel('Rs [Mscf/stb]');
        xlabel('Presión [psia]');
    case 4
        plot(Rr(:,1),Rr(:,17+var),'c--');
        ylabel('Rv [stb/Mscf]');
        xlabel('Presión [psia]');
end


% --- Executes on button press in compo.
function compo_Callback(hObject, eventdata, handles)
% hObject    handle to compo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
composi_AVCcyg;
