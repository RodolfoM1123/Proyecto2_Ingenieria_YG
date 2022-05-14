function varargout = Tabla(varargin)


% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Tabla_OpeningFcn, ...
                   'gui_OutputFcn',  @Tabla_OutputFcn, ...
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


% --- Executes just before Tabla is made visible.
function Tabla_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Tabla (see VARARGIN)

% Choose default command line output for Tabla
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Tabla wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Tabla_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
F=get(handles.TabECC, 'data');
plot(F(:,2),F(:,1));
tam=length(F(:,1));
for i=1:tam
    r(i)=sqrt(F(i,1)^2+F(i,2)^2)
end
f=fit(F(:,2),F(:,1),'exp2')
plot(f,F(:,2),F(:,1));
aa=min(r)
for i=1:tam
    bb(i)=r(i);
    dif=aa-bb(i)
    if dif==0
       Pb=F(i,1) 
       Vb=F(i,2)
    break
    end
end
% B=size(F(:,1));
% m(1)=0;
% i=2;
% while B>i
% dP(i)=F(i,1)-F(i-1,1);
% dV(i)=F(i,2)-F(i-1,2);
% m(i)=dP(i)/dV(i)
% m(1)=m(2);
% jj=abs((m(i)-m(i-1))/m(i))
% if jj>1
%   Pb=F(i,1)
%   Vb=F(i,2)
%   i=B;
% end
% i=i+1;
% end


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
