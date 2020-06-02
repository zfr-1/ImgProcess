% Copyright (C) misaka00251 & ZFR - All Rights Reserved
% Unauthorized copying of this file, via any medium is strictly prohibited
% Proprietary and confidential
% Written by misaka00251 <misaka00251@misakanet.cn>, June 2020

function varargout = window(varargin)
% WINDOW MATLAB code for window.fig
%      WINDOW, by itself, creates a new WINDOW or raises the existing
%      singleton*.
%
%      H = WINDOW returns the handle to a new WINDOW or the handle to
%      the existing singleton*.
%
%      WINDOW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in WINDOW.M with the given input arguments.
%
%      WINDOW('Property','Value',...) creates a new WINDOW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before window_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to window_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help window

% Last Modified by GUIDE v2.5 02-Jun-2020 10:58:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @window_OpeningFcn, ...
                   'gui_OutputFcn',  @window_OutputFcn, ...
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


% --- Executes just before window is made visible.
function window_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to window (see VARARGIN)

% Choose default command line output for window
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes window wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = window_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in radiobutton1.
function radiobutton1_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton1

% --- Executes on button press in radiobutton1.
function radiobutton2_Callback(hObject, eventdata, handles)
% hObject    handle to radiobutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of radiobutton2

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename,Pathname] = uigetfile({'*.jpg';'*.png';'*.bmp';'*.tif';},'ѡ��ͼ��');
str = [Pathname filename];
if Pathname ~= 0
    OrginImage_O = imread(str);
    OrginImage_O = OrginImage_O(:,:,1:3);
    OrginImage=OrginImage_O;
    OrginImage = imresize(OrginImage,[256,256]);
    axes(handles.axes1);
    imshow(OrginImage_O);
    setappdata(handles.pushbutton1,'OrginImage',OrginImage);
end



% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hOject, eventdata, handles)
OrginImage=getappdata(handles.pushbutton1,'OrginImage');
 load('./data/data.mat');
 [m,~]=size(hist_features);
 IndexOfPoint=[];
if get(handles.radiobutton1,'value')
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  OrginImage_Gray=rgb2gray(OrginImage);
  [Count1,~]=imhist(OrginImage_Gray);
    
    for index = 1:m
        Count2 = hist_features{index,2};
        PathData = hist_features{index,1};
        Sum1=sum(Count1);
        Sum2=sum(Count2);
        Sumup=sqrt(Count1.*Count2);
        SumDown=sqrt(Sum1*Sum2);
        Sumup=sum(Sumup);
        IndexOfBashi=1-sqrt(1-Sumup/SumDown);
        IndexOfPoint{index,1}=IndexOfBashi;
        IndexOfPoint{index,2}=PathData;
        
    end
    IndexOfPoint=sortrows(IndexOfPoint);


elseif get(handles.radiobutton2,'value')
StatxtureData= Istatxture;
ColorData=IcolorMom;
sc=colorMom(OrginImage)';
sl=lbp(OrginImage)';
 for i=1:m
     PathData = hist_features{i,1};
     IndexOfPoint{i,1}=CalDis(sc,ColorData(:,i))*0.5+CalDis(sl,StatxtureData(:,i))/1000000*0.5;
     IndexOfPoint{i,2}=PathData;
end
        IndexOfPoint=sortrows(IndexOfPoint,-1);
end

axes(handles.axes2); 
Serch = imread(IndexOfPoint{m,2});
Serch = Serch(:,:,1:3);
imshow(Serch);

axes(handles.axes3); 
Serch = imread(IndexOfPoint{(m-1),2});
Serch = Serch(:,:,1:3);
imshow(Serch);

axes(handles.axes4); 
Serch = imread(IndexOfPoint{(m-2),2});
Serch = Serch(:,:,1:3);
imshow(Serch);
axes(handles.axes5); 
Serch = imread(IndexOfPoint{(m-3),2});
Serch = Serch(:,:,1:3);
imshow(Serch);

axes(handles.axes6); 
Serch = imread(IndexOfPoint{(m-4),2});
Serch = Serch(:,:,1:3);
imshow(Serch);

axes(handles.axes7); 
Serch = imread(IndexOfPoint{(m-5),2});
Serch = Serch(:,:,1:3);
imshow(Serch);

axes(handles.axes8); 
Serch = imread(IndexOfPoint{(m-6),2});
Serch = Serch(:,:,1:3);
imshow(Serch);

axes(handles.axes9); 
Serch = imread(IndexOfPoint{(m-7),2});
Serch = Serch(:,:,1:3);
imshow(Serch);

axes(handles.axes10); 
Serch = imread(IndexOfPoint{(m-8),2});
Serch = Serch(:,:,1:3);
imshow(Serch);


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
matname = 'data/data.mat';

path = './img/';
filename = [dir([path, '*.jpg']);dir([path, '*.png'])];
pic_filename = {filename.name};
num=length(pic_filename);
Istatxture = zeros(256,num);
IcolorMom = zeros(225,num);

%pictures = zeros(length(pic_filename),90,90,3);
for i = 1 :num
    path_data=char(strcat(path,pic_filename(i)));
    picture = imread(path_data);
    Istatxture(:,i)=lbp(picture);
    IcolorMom(:,i)=colorMom(picture);

   % pictures(i,:,:,:)=picture;
   img=rgb2gray(picture);
   count=imhist(img);
   hist_features{i,1}=path_data;
   hist_features{i,2}=count;
end
 save(matname, 'hist_features', 'Istatxture', 'IcolorMom');
