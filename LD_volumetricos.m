function varargout = LD_volumetricos(varargin)
% LD_VOLUMETRICOS MATLAB code for LD_volumetricos.fig
%      LD_VOLUMETRICOS, by itself, creates a new LD_VOLUMETRICOS or raises the existing
%      singleton*.
%
%      H = LD_VOLUMETRICOS returns the handle to a new LD_VOLUMETRICOS or the handle to
%      the existing singleton*.
%
%      LD_VOLUMETRICOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LD_VOLUMETRICOS.M with the given input arguments.
%
%      LD_VOLUMETRICOS('Property','Value',...) creates a new LD_VOLUMETRICOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LD_volumetricos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LD_volumetricos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LD_volumetricos

% Last Modified by GUIDE v2.5 13-Nov-2018 15:42:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LD_volumetricos_OpeningFcn, ...
                   'gui_OutputFcn',  @LD_volumetricos_OutputFcn, ...
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


% --- Executes just before LD_volumetricos is made visible.
function LD_volumetricos_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to LD_volumetricos (see VARARGIN)

% Choose default command line output for LD_volumetricos
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LD_volumetricos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LD_volumetricos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbuttonp1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
op=get(handles.menu,'value');
global LL
global drl
global MML
a=get(handles.menuplot,'value');
n=length(LL(:,1));
m=8;
M=zeros(n,m);
AA=LL(1,3);
nt=(drl*62.4*AA/MML);
switch (op)
    case 1
        for i=1:n
            M(i,1)=LL(i,2); %Presion
            M(i,2)=LL(i,4)/LL(i,5); %Bg
            M(i,3)=520*M(i,2)*LL(i,2)/14.7/LL(i,1); %Z McCain
            M(i,5)=LL(i,3)/LL(end,3); %Bo
            M(i,8)=(LL(end,6)-LL(i,6))*5.615/LL(end,3);%Rs
            M(i,7)=M(i,5)+M(i,2)*(M(1,8)-M(i,8))/5.615; %Bt
        end
        for j=1:8
            for i=1:n-2
                MM(i,j)=M(i+1,j);
            end
        end
        zzzz=fit(MM(:,1),MM(:,3), 'exp2'); %ajuste a Z vs p
        bobo=fit(MM(:,1),MM(:,5), 'exp2'); %Ajuste a bo vs p
        rsrs=fit(MM(:,1),MM(:,8), 'exp2'); %Ajuste a Rs vs P
        for i=1:n-2
            %Sacando Cg
            dzzdp=zzzz.a*zzzz.b*exp(MM(i,1)*zzzz.b)+zzzz.c*zzzz.d*exp(MM(i,1)*zzzz.d);%Derivada de dz/dp
            M(i+1,4)=(1/MM(i,1))-dzzdp/MM(i,3);%Cg
            MM(i,4)=M(i+1,4);
            %Sacando Co
            dbodp=bobo.a*bobo.b*exp(MM(i,1)*bobo.b)+bobo.c*bobo.d*exp(MM(i,1)*bobo.d); %Derivada de dBo/dP
            drsdp=rsrs.a*rsrs.b*exp(MM(i,1)*rsrs.b)+rsrs.c*rsrs.d*exp(MM(i,1)*rsrs.d); %Derivada de dRs/dP
            M(i+1,6)=-(dbodp-MM(i,2)*drsdp)/MM(i,5); %Co
            MM(i,6)=M(i+1,6);
        end

         set(handles.ResVol_LD,'data',M); %Datos a la tabla de resultados de McCain
    case 2
        sumLL=0;% Inicial del acumulado
        for i=1:n
            sumLL=sumLL+LL(i,7)
        end
        for i=1:n
            M(i,1)=LL(i,2); %Presiones
            sumLL=sumLL-LL(i,7); %Nge acumulado
            M(i,8)=2131.45*sumLL*nt/LL(end,3);% Rs whitson
            M(i,3)=LL(i,2)*LL(i,4)/(LL(i,7)*nt*10.73*LL(i,1));%Zwhitson
            M(i,2)=14.7*M(i,3)*LL(i,1)/520/M(i,1); %Bg whitson
            M(i,5)=LL(i,3)/LL(end,3); %Bo
            M(i,7)=M(i,5)+M(i,2)*(M(1,8)-M(i,8))/5.615; %Bt
        end
        for j=1:8
            for i=1:n-2
                MM(i,j)=M(i+1,j);
            end
        end
        zzzz=fit(MM(:,1),MM(:,3), 'exp2'); %ajuste a Z vs p
        bobo=fit(MM(:,1),MM(:,5), 'exp2'); %Ajuste a bo vs p
        rsrs=fit(MM(:,1),MM(:,8), 'exp2'); %Ajuste a Rs vs P
        for i=1:n-2
            %Sacando Cg
            dzzdp=zzzz.a*zzzz.b*exp(MM(i,1)*zzzz.b)+zzzz.c*zzzz.d*exp(MM(i,1)*zzzz.d);%Derivada de dz/dp
            M(i+1,4)=(1/MM(i,1))-dzzdp/MM(i,3);%Cg
            MM(i,4)=M(i+1,4);
            %Sacando Co
            dbodp=bobo.a*bobo.b*exp(MM(i,1)*bobo.b)+bobo.c*bobo.d*exp(MM(i,1)*bobo.d); %Derivada de dBo/dP
            drsdp=rsrs.a*rsrs.b*exp(MM(i,1)*rsrs.b)+rsrs.c*rsrs.d*exp(MM(i,1)*rsrs.d); %Derivada de dRs/dP
            M(i+1,6)=-(dbodp-MM(i,2)*drsdp)/MM(i,5); %Co
            MM(i,6)=M(i+1,6);
        end
        set(handles.ResVol_LD,'data',M); %Datos a la tabla de resultados de McCain        
end
    switch a
        case 1
            plot(MM(:,1),MM(:,3),'g-');
            set(handles.ejey,'string','Z fracc');
        case 2
            plot(MM(:,1),MM(:,2),'c--');
            set(handles.ejey,'string','Bg [cf/scf]');
        case 3
            plot(MM(:,1),MM(:,4),'k--');
            set(handles.ejey,'string','Cg [1/psi]');
        case 4
            plot(MM(:,1),MM(:,5),'k-.');
            set(handles.ejey,'string','Bo [cf/scf]');
        case 5 
            plot(MM(:,1),MM(:,6),'b--');
            set(handles.ejey,'string','Co [1/psi]');
        case 6
            plot(MM(:,1),MM(:,7),'m--');
            set(handles.ejey,'string','Bt [cf/scf]');
        case 7
            plot(MM(:,1),MM(:,8),'cd');
            set(handles.ejey,'string','Rs [bl/scf]');
    end


% --- Executes on selection change in menu.
function menu_Callback(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu


% --- Executes during object creation, after setting all properties.
function menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in menuplot.
function menuplot_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function menuplot_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menuplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Composicional
