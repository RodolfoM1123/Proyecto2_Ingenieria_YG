function varargout = Proyecto2_P(varargin)
% PROYECTO2_P MATLAB code for Proyecto2_P.fig
%      PROYECTO2_P, by itself, creates a new PROYECTO2_P or raises the existing
%      singleton*.
%
%      H = PROYECTO2_P returns the handle to a new PROYECTO2_P or the handle to
%      the existing singleton*.
%
%      PROYECTO2_P('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROYECTO2_P.M with the given input arguments.
%
%      PROYECTO2_P('Property','Value',...) creates a new PROYECTO2_P or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Proyecto2_P_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Proyecto2_P_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Proyecto2_P

% Last Modified by GUIDE v2.5 13-Nov-2018 16:23:29

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Proyecto2_P_OpeningFcn, ...
                   'gui_OutputFcn',  @Proyecto2_P_OutputFcn, ...
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


% --- Executes just before Proyecto2_P is made visible.
function Proyecto2_P_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Proyecto2_P (see VARARGIN)

% Choose default command line output for Proyecto2_P
global zaz
zaz= 'gsh';
handles.output = hObject;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Proyecto2_P wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Proyecto2_P_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes when selected object is changed in seleccion.
function seleccion_SelectionChangedFcn(hObject, eventdata, handles)
global zaz
zaz=get(hObject,'tag');


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
global zaz
if isequal(zaz,'gsh')
    close
    ECC_gsh
else
        switch zaz
    case 'gsh'
        close
        ECC_gsh
    case 'gyc'
        close
        subGYC
    case 'av'
        close
        subAV
        end 
end
