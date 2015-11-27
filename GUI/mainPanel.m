function varargout = mainPanel(varargin)
% MAINPANEL MATLAB code for mainPanel.fig
%      MAINPANEL, by itself, creates a new MAINPANEL or raises the existing
%      singleton*.
%
%      H = MAINPANEL returns the handle to a new MAINPANEL or the handle to
%      the existing singleton*.
%
%      MAINPANEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAINPANEL.M with the given input arguments.
%
%      MAINPANEL('Property','Value',...) creates a new MAINPANEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before mainPanel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to mainPanel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help mainPanel

% Last Modified by GUIDE v2.5 27-Nov-2015 18:34:59

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @mainPanel_OpeningFcn, ...
                   'gui_OutputFcn',  @mainPanel_OutputFcn, ...
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


% --- Executes just before mainPanel is made visible.
function mainPanel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to mainPanel (see VARARGIN)

% Choose default command line output for mainPanel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes mainPanel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = mainPanel_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function TradingCodeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to TradingCodeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TradingCodeEdit as text
%        str2double(get(hObject,'String')) returns contents of TradingCodeEdit as a double


% --- Executes during object creation, after setting all properties.
function TradingCodeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TradingCodeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TradingPriceEdit_Callback(hObject, eventdata, handles)
% hObject    handle to TradingPriceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TradingPriceEdit as text
%        str2double(get(hObject,'String')) returns contents of TradingPriceEdit as a double


% --- Executes during object creation, after setting all properties.
function TradingPriceEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TradingPriceEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function TradingVolumeEdit_Callback(hObject, eventdata, handles)
% hObject    handle to TradingVolumeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of TradingVolumeEdit as text
%        str2double(get(hObject,'String')) returns contents of TradingVolumeEdit as a double


% --- Executes during object creation, after setting all properties.
function TradingVolumeEdit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to TradingVolumeEdit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in TradingCodeBtn.
function TradingCodeBtn_Callback(hObject, eventdata, handles)
% hObject    handle to TradingCodeBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TradingPriceBtn.
function TradingPriceBtn_Callback(hObject, eventdata, handles)
% hObject    handle to TradingPriceBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TradingVolumeBtn.
function TradingVolumeBtn_Callback(hObject, eventdata, handles)
% hObject    handle to TradingVolumeBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in TradingBtn.
function TradingBtn_Callback(hObject, eventdata, handles)
% hObject    handle to TradingBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
