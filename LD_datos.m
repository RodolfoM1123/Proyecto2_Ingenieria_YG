function varargout = LD_datos(varargin)
% LD_DATOS MATLAB code for LD_datos.fig
%      LD_DATOS, by itself, creates a new LD_DATOS or raises the existing
%      singleton*.
%
%      H = LD_DATOS returns the handle to a new LD_DATOS or the handle to
%      the existing singleton*.
%
%      LD_DATOS('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in LD_DATOS.M with the given input arguments.
%
%      LD_DATOS('Property','Value',...) creates a new LD_DATOS or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before LD_datos_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to LD_datos_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help LD_datos

% Last Modified by GUIDE v2.5 10-Nov-2018 13:57:22

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @LD_datos_OpeningFcn, ...
                   'gui_OutputFcn',  @LD_datos_OutputFcn, ...
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


% --- Executes just before LD_datos is made visible.
function LD_datos_OpeningFcn(hObject, eventdata, handles, varargin)
global LL
format longe;
archivo=importdata('datos.txt');
LL=archivo.data;
set(handles.LD_dat_volumetrico,'data', LL);
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes LD_datos wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = LD_datos_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in boton1LD.
function boton1LD_Callback(hObject, eventdata, handles)
% hObject    handle to boton1LD (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LL
global drl
global MML
drl=str2double(get(handles.derell,'string'));
MML=str2double(get(handles.mamoll,'string'));
LD_volumetricos



function derell_Callback(hObject, eventdata, handles)
% hObject    handle to derell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of derell as text
%        str2double(get(hObject,'String')) returns contents of derell as a double


% --- Executes during object creation, after setting all properties.
function derell_CreateFcn(hObject, eventdata, handles)
% hObject    handle to derell (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function mamoll_Callback(hObject, eventdata, handles)
% hObject    handle to mamoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mamoll as text
%        str2double(get(hObject,'String')) returns contents of mamoll as a double


% --- Executes during object creation, after setting all properties.
function mamoll_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mamoll (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in importdata.
function importdata_Callback(hObject, eventdata, handles)
% hObject    handle to importdata (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
