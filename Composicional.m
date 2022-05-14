function varargout = Composicional(varargin)
% COMPOSICIONAL MATLAB code for Composicional.fig
%      COMPOSICIONAL, by itself, creates a new COMPOSICIONAL or raises the existing
%      singleton*.
%
%      H = COMPOSICIONAL returns the handle to a new COMPOSICIONAL or the handle to
%      the existing singleton*.
%
%      COMPOSICIONAL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in COMPOSICIONAL.M with the given input arguments.
%
%      COMPOSICIONAL('Property','Value',...) creates a new COMPOSICIONAL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Composicional_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Composicional_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Composicional

% Last Modified by GUIDE v2.5 12-Nov-2018 16:20:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Composicional_OpeningFcn, ...
                   'gui_OutputFcn',  @Composicional_OutputFcn, ...
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


% --- Executes just before Composicional is made visible.
function Composicional_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Composicional (see VARARGIN)
 format long
global CC
global zi
archivo=importdata('datosComp.txt');
CC=archivo.data;
set(handles.datComLD,'data',CC);
set(handles.xi,'ColumnName',CC(:,1));
set(handles.ki,'ColumnName',CC(:,1));
arch=importdata('zi.txt');
zi=arch.data;
set(handles.TabZi,'data',zi);
% Choose default command line output for Composicional
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Composicional wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Composicional_OutputFcn(hObject, eventdata, handles) 
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
global CC
global zi
etapa=length(CC(:,1));
componente=length(zi(:,1));
nt=CC(1,3)*62.4/CC(1,4);
ZN=nt.*zi(:,1);
ngacum=0;

for i=1:etapa
    ng(i)=nt*CC(i,6);
    nl(i)=nt*CC(i,5);
    for j=1:componente
       ngi(i,j)=ng(i)*CC(i,j+6); 
    end
end

for j=1:componente
    for i=1:etapa
        ngacum=ngacum+ngi(i,j);
        ngiacum(i,j)=ngacum;
    end
    ngacum=0;
end

for i=1:etapa
    for j=1:componente
        x(j,i)=(ZN(j,1)-ngiacum(i,j))/nl(i);
        k(j,i)=CC(i,j+6)/x(j,i);
    end
end
set(handles.ki,'data',k);
set(handles.xi,'data',x);
op=get(handles.menu,'value');
xlabel('P[psia]')
switch (op)
    case 1
         cla
         hold on
        for j=1:componente
            plot(CC(:,1),CC(:,j+6))
        end
        ylabel('yi')
    case 2
        cla
        hold on
        for j=1:componente
            plot(CC(:,1),x(j,:))
        end
       ylabel('xi')
    case 3
      cla
      hold on
        for j=1:componente
            plot(CC(:,1),k(j,:))
        end
        ylabel('kij')
end


% --- Executes when entered data in editable cell(s) in xi.
function xi_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to xi (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


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
