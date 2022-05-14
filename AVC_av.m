function varargout = AVC_av(varargin)
% AVC_AV MATLAB code for AVC_av.fig
%      AVC_AV, by itself, creates a new AVC_AV or raises the existing
%      singleton*.
%
%      H = AVC_AV returns the handle to a new AVC_AV or the handle to
%      the existing singleton*.
%
%      AVC_AV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AVC_AV.M with the given input arguments.
%
%      AVC_AV('Property','Value',...) creates a new AVC_AV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AVC_av_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AVC_av_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AVC_av

% Last Modified by GUIDE v2.5 11-Nov-2018 16:44:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AVC_av_OpeningFcn, ...
                   'gui_OutputFcn',  @AVC_av_OutputFcn, ...
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


% --- Executes just before AVC_av is made visible.
function AVC_av_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AVC_av (see VARARGIN)
global MAVavc
format long
archivo=importdata('datosAVCav.txt');
MAVavc=archivo.data;
set(handles.datAVC_av,'data',MAVavc);

% Choose default command line output for AVC_av
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AVC_av wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AVC_av_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global MAVavc
global Ty
global Pp
global Vlsc
global Vgsc
Vlsc=str2double(get(handles.Vlmax,'string'));
Vgsc=str2double(get(handles.Vgmax,'string'));
Ty=str2double(get(handles.Ty,'string'));
tam=length(MAVavc(:,1));
PP=zeros(tam,7);
PPa=zeros(tam-1,8);
PP(1,4)=Vgsc*5.615/Vlsc; %Rsi
for i=1:tam
    PP(i,1)=MAVavc(i,2)/Vlsc; %Bo
    PP(i,2)=MAVavc(i,5)/MAVavc(i,6); %Bg
    PP(i,3)=520*PP(i,2)*MAVavc(i,1)/Ty/14.7; %Z
    if i>1
    PP(i,4)=(Vgsc-MAVavc(i,4)/PP(i,2)-MAVavc(i,7))*5.615/Vlsc; %Rs 
    PP(i,7)=PP(i,1)+PP(i,2)*(PP(1,4)-PP(i,4))/5.615; %Bt
    end
end
PP(1,7)=PP(1,1);
for j=1:7
    for i=1:tam-1%PPa no cuenta el primer renglón.
        PPa(i,j)=PP(i+1,j); %Matriz PPa es matriz PP sin valores N/A
        PPa(i,8)=MAVavc(i+1,1);%Columna de presiones en 8
    end
end

fBg=fit(PPa(:,8),PPa(:,2),'power1');%Ocupamos ppa ya que fit no acepta
fBo=fit(PPa(:,8),PPa(:,1),'power1');%valores tipo N/A
fRs=fit(MAVavc(:,1),PP(:,1),'poly3');%No se emplea pues Rs si está definido

dfBg=(fBg.a*fBg.b).*MAVavc(:,1).^(fBg.b-1); %derivada Bg/P
dfBo=(fBo.a*fBo.b).*MAVavc(:,1).^(fBo.b-1); %derivada Bo/P
dfRs=(3*fRs.p1).*MAVavc(:,1).^2+(2*fRs.p2).*MAVavc(:,1)+fRs.p3; %derivada Rs/P

PP(:,5)=-(1./PP(:,2)).*dfBg; %cg
PP(:,6)=(1./PP(:,1)).*(dfBo-PP(:,2).*dfRs); %co

set(handles.RTab,'data',PP); %valores en tabla de resultados
graf=get(handles.grafAVC,'value');
switch graf
    case 1
        plot(MAVavc(:,1),PP(:,graf),'c')
        ylabel('Bo [cf/scf]')
        grid on
        xlabel('P [psia]')
    case 2
        plot(MAVavc(:,1),PP(:,graf),'g')
        ylabel('Bg [cf/scf]')
        grid on
        xlabel('P [psia]')
    case 3
        plot(MAVavc(:,1),PP(:,graf),'k')
        ylabel('z [adim]')
        grid on
        xlabel('P [psia]')
    case 4
        plot(MAVavc(:,1),PP(:,graf),'b')
        ylabel('Rs [scf/sbl]')
        grid on
        xlabel('P [psia]')
    case 5
        plot(MAVavc(:,1),PP(:,graf),'r')
        ylabel('Cg [1/psi]')
        grid on
        xlabel('P [psia]')
    case 6
        plot(MAVavc(:,1),PP(:,graf),'g')
        ylabel('Co [1/psi]')
        grid on
        xlabel('P [psia]')
    case 7
        plot(MAVavc(:,1),PP(:,graf),'c')
        ylabel('Bt [cf/scf]')
        grid on
        xlabel('P [psia]')
end
function Vlmax_Callback(hObject, eventdata, handles)
% hObject    handle to Vlmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vlmax as text
%        str2double(get(hObject,'String')) returns contents of Vlmax as a double


% --- Executes during object creation, after setting all properties.
function Vlmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vlmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vgmax_Callback(hObject, eventdata, handles)
% hObject    handle to Vgmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vgmax as text
%        str2double(get(hObject,'String')) returns contents of Vgmax as a double


% --- Executes during object creation, after setting all properties.
function Vgmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vgmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Ty_Callback(hObject, eventdata, handles)
% hObject    handle to Ty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Ty as text
%        str2double(get(hObject,'String')) returns contents of Ty as a double


% --- Executes during object creation, after setting all properties.
function Ty_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Ty (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in grafAVC.
function grafAVC_Callback(hObject, eventdata, handles)
% hObject    handle to grafAVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns grafAVC contents as cell array
%        contents{get(hObject,'Value')} returns selected item from grafAVC


% --- Executes during object creation, after setting all properties.
function grafAVC_CreateFcn(hObject, eventdata, handles)
% hObject    handle to grafAVC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
