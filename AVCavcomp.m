function varargout = AVCavcomp(varargin)
% AVCAVCOMP MATLAB code for AVCavcomp.fig
%      AVCAVCOMP, by itself, creates a new AVCAVCOMP or raises the existing
%      singleton*.
%
%      H = AVCAVCOMP returns the handle to a new AVCAVCOMP or the handle to
%      the existing singleton*.
%
%      AVCAVCOMP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in AVCAVCOMP.M with the given input arguments.
%
%      AVCAVCOMP('Property','Value',...) creates a new AVCAVCOMP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before AVCavcomp_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to AVCavcomp_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help AVCavcomp

% Last Modified by GUIDE v2.5 13-Nov-2018 18:16:03

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @AVCavcomp_OpeningFcn, ...
                   'gui_OutputFcn',  @AVCavcomp_OutputFcn, ...
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


% --- Executes just before AVCavcomp is made visible.
function AVCavcomp_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to AVCavcomp (see VARARGIN)

% Choose default command line output for AVCavcomp
handles.output = hObject;
global MAVavc
global Ty
global Pp
global Vlsc
global Vgsc
archivo=importdata('comAVCav.txt');
yij=archivo.data';
compo=archivo.rowheaders';
reng=length(yij(:,1));
col=length(yij(1,:));
ngrk=zeros(reng,1);
ngek=zeros(reng,1);
delngek=zeros(reng,1);
nlrk=zeros(reng,1);
Vt=Vlsc+Vgsc;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes AVCavcomp wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = AVCavcomp_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
