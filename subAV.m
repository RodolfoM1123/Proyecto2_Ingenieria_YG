function varargout = subAV(varargin)
% SUBAV MATLAB code for subAV.fig
%      SUBAV, by itself, creates a new SUBAV or raises the existing
%      singleton*.
%
%      H = SUBAV returns the handle to a new SUBAV or the handle to
%      the existing singleton*.
%
%      SUBAV('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUBAV.M with the given input arguments.
%
%      SUBAV('Property','Value',...) creates a new SUBAV or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before subAV_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to subAV_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help subAV

% Last Modified by GUIDE v2.5 13-Nov-2018 16:35:15

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @subAV_OpeningFcn, ...
                   'gui_OutputFcn',  @subAV_OutputFcn, ...
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


% --- Executes just before subAV is made visible.
function subAV_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to subAV (see VARARGIN)

% Choose default command line output for subAV
handles.output = hObject;
global zez
zez='eccav';
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes subAV wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = subAV_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
% --- Executes when selected object is changed in seleccionav.
function seleccionav_SelectionChangedFcn(hObject, eventdata, handles)
global zez
zez=get(hObject,'tag');

% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
global zez
if isequal(zez,'eccav')
    close
    LD_datos
else
switch zez
    case 'eccav'
        close
        Tabla
    case 'ldav'
        close
        LD_datos
    case 'avcav'
        close
        AVC_av 
end
end
