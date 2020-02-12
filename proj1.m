function varargout = proj1(varargin)
% PROJ1 MATLAB code for proj1.fig
%      PROJ1, by itself, creates a new PROJ1 or raises the existing
%      singleton*.
%
%      H = PROJ1 returns the handle to a new PROJ1 or the handle to
%      the existing singleton*.
%
%      PROJ1('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PROJ1.M with the given input arguments.
%
%      PROJ1('Property','Value',...) creates a new PROJ1 or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before proj1_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to proj1_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help proj1

% Last Modified by GUIDE v2.5 30-Nov-2019 13:57:58

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @proj1_OpeningFcn, ...
                   'gui_OutputFcn',  @proj1_OutputFcn, ...
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


% --- Executes just before proj1 is made visible.
function proj1_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no uitable args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to proj1 (see VARARGIN)

% Choose default command line uitable for proj1
handles.output = hObject;
handles.method.String = {'Bisection', 'False Position', 'Fixed Point', 'Newton Raphson', 'Secant'};
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes proj1 wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = proj1_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning uitable args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line uitable from handles structure
varargout{1} = handles.output;



function fn_Callback(hObject, eventdata, handles)
% hObject    handle to fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fn as text
%        str2double(get(hObject,'String')) returns contents of fn as a double


% --- Executes during object creation, after setting all properties.
function fn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in method.
function method_Callback(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns method contents as cell array
%        contents{get(hObject,'Value')} returns selected item from method


% --- Executes during object creation, after setting all properties.
function method_CreateFcn(hObject, eventdata, handles)
% hObject    handle to method (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in getRootsBtn.
function getRootsBtn_Callback(hObject, eventdata, handles)
% hObject    handle to getRootsBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.graph);
start = str2double(get(handles.xl, 'String'));
stop = str2double(get(handles.xu, 'String'));
maxi = str2double(get(handles.maxIter, 'String'));
es = str2double(get(handles.epsilon, 'String'));
xvals=start:0.1:stop;
str_y=strcat('@(x)',get(handles.fn, 'String'));
y=str2func(str_y);
plot(xvals,y(xvals));
hold on;
plot(xvals,zeros(length(xvals)));
grid on;
hold off;
rootMethod = get(handles.method,'Value');
ans_vec = [];
switch(rootMethod)
    case 1
        set(handles.uitable,'ColumnName',{'i' 'xl' 'f(xl)' 'xu' 'f(xu)' 'xr' 'f(xr)' 'ea'});
        if(y(start)*y(stop)>0)
            set(handles.msg,'String','no roots in this interval');
            ext = 0;
        else
            tic;
            ans_vec = bisection(start,stop,es,y,maxi);
            ext = toc;
            set(handles.msg,'String','successfully completed');
        end
    case 2
        set(handles.uitable,'ColumnName',{'i' 'xl' 'f(xl)' 'xu' 'f(xu)' 'xr' 'f(xr)' 'ea'});
        if(y(start)*y(stop)>0)
            set(handles.msg,'String','no roots in this interval');
            ext = 0;
        else
            tic;
            ans_vec = false_position(start,stop,es,y,maxi);
            ext = toc;
            set(handles.msg,'String','successfully completed');
        end
    case 3
        set(handles.uitable,'ColumnName',{'i' 'xr_old' 'g(xr_old)' 'xr_new' 'g(xr_new)' 'ea'});
        syms x;
        diff_f = matlabFunction(diff(y(x)));
        if(abs(diff_f(start))<1)
            set(handles.msg,'String','converges');
        else
            set(handles.msg,'String','diverges');
        end
        tic;
        ans_vec = fixed_point(start,es,y,maxi);
        ext = toc;
    case 4
        set(handles.uitable,'ColumnName',{'i' 'xr_old' 'f(xr_old)' 'xr_new' 'f(xr_new)' 'ea'});
        tic;
        [ans_vec,converged] = newton_raphson(start,es,y,maxi);
        ext = toc;
        if(converged)
            set(handles.msg,'String','converges');
        else
            set(handles.msg,'String','diverges');
        end
    case 5
        set(handles.uitable,'ColumnName',{'i' 'xi-2' 'f(xi-2)' 'xi-1' 'f(xi-1)' 'xi' 'f(xi)' 'ea'});
        tic;
        [ans_vec,converged] = secant(start,stop,es,y,maxi);
        ext = toc;
        if(converged)
            set(handles.msg,'String','converges');
        else
            set(handles.msg,'String','diverges');
        end
end
set(handles.uitable, 'Data', ans_vec);
set(handles.executiontimetxt,'String',strcat('execution time = ', sprintf(" %f", ext), ' seconds'));

% --- Executes on button press in chooseFromFileBtn.
function chooseFromFileBtn_Callback(hObject, eventdata, handles)
% hObject    handle to chooseFromFileBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file,path] = uigetfile('*.txt');
fname=strcat(path,file);
fileID = fopen(fname,'r');
f = fscanf(fileID,'%s');
fprintf('%s\n',f);
set(handles.fn, 'String', f);



function maxIter_Callback(hObject, eventdata, handles)
% hObject    handle to maxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxIter as text
%        str2double(get(hObject,'String')) returns contents of maxIter as a double


% --- Executes during object creation, after setting all properties.
function maxIter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxIter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function epsilon_Callback(hObject, eventdata, handles)
% hObject    handle to epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of epsilon as text
%        str2double(get(hObject,'String')) returns contents of epsilon as a double


% --- Executes during object creation, after setting all properties.
function epsilon_CreateFcn(hObject, eventdata, handles)
% hObject    handle to epsilon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xl_Callback(hObject, eventdata, handles)
% hObject    handle to xl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xl as text
%        str2double(get(hObject,'String')) returns contents of xl as a double


% --- Executes during object creation, after setting all properties.
function xl_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function xu_Callback(hObject, eventdata, handles)
% hObject    handle to xu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xu as text
%        str2double(get(hObject,'String')) returns contents of xu as a double


% --- Executes during object creation, after setting all properties.
function xu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function uitable_CreateFcn(hObject, eventdata, handles)
% hObject    handle to uitable (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
handles.uitable = hObject;
set(handles.uitable,'Data',[]);
% --- Executes when entered data in editable cell(s) in uitable.
function uitable_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to uitable (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function executiontimetxt_CreateFcn(hObject, eventdata, handles)
% hObject    handle to executiontimetxt (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes during object creation, after setting all properties.
function msg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to msg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
