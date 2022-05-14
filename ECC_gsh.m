function varargout = ECC_gsh(varargin)


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ECC_gsh_OpeningFcn, ...
                   'gui_OutputFcn',  @ECC_gsh_OutputFcn, ...
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


% --- Executes just before ECC_gsh is made visible.
function ECC_gsh_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ECC_gsh (see VARARGIN)
global F
archivo=importdata('datosECCgsh.txt');
F=archivo.data;
set(handles.TabECC,'data',F)
% Choose default command line output for ECC_gsh
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ECC_gsh wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = ECC_gsh_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
global F
F=get(handles.TabECC, 'data');
T=str2double(get(handles.Ty,'string'));
Vce=str2double(get(handles.Vg,'string'));
ng=14.7*Vce/10.73/520;
tam=length(F(:,1));
for i=1:tam
    Bg(i)=F(i,2)/Vce;
    Z(i)=520*Bg(i)*F(i,1)/14.7/T
end
Bg=Bg.';
Z=Z.';
 
 fBg=fit(F(:,1),Bg,'power1')
for i=1:tam
    df(i)=fBg.a*fBg.b*F(i,1)^(fBg.b-1);
    Cg(i)=-df(i)/Bg(i);
end
Cg=Cg.';

NN=[Bg Z Cg];
set(handles.TresECC,'data',NN)
opp=get(handles.menu1,'value');

switch (opp)
    case 1 
       plot(F(:,1),Bg)
       plot(fBg,F(:,1),Bg)
       set(handles.text7,'string','Bg[cf/scf]')
    case 2
       fZ=fit(F(:,1),Z,'poly3'); 
       plot(F(:,1),Z)
       plot(fZ,F(:,1),Z)
       set(handles.text7,'string','Z')
    case 3
       fCg=fit(F(:,1),Cg,'power1');  
       plot(F(:,1),Cg)
       plot(fCg,F(:,1),Cg)
       set(handles.text7,'string','Cg[1/psi]')
end



% --- Executes on key press with focus on TabECC and none of its controls.
function TabECC_KeyPressFcn(hObject, eventdata, handles)
% hObject    handle to TabECC (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Key: name of the key that was pressed, in lower case
%	Character: character interpretation of the key(s) that was pressed
%	Modifier: name(s) of the modifier key(s) (i.e., control, shift) pressed
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function TabECC_ButtonDownFcn(hObject, eventdata, handles)
% hObject    handle to TabECC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes when entered data in editable cell(s) in TabECC.
function TabECC_CellEditCallback(hObject, eventdata, handles)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in filas.
function filas_Callback(hObject, eventdata, handles)
% hObject    handle to filas (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
B=str2num(get(handles.edit1,'string'));
A=zeros(B,2);
set(handles.TabECC,'data',A);



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



function Vg_Callback(hObject, eventdata, handles)
% hObject    handle to Vg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vg as text
%        str2double(get(hObject,'String')) returns contents of Vg as a double


% --- Executes during object creation, after setting all properties.
function Vg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in menu1.
function menu1_Callback(hObject, eventdata, handles)
% hObject    handle to menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns menu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from menu1


% --- Executes during object creation, after setting all properties.
function menu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
