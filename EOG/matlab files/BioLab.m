function varargout = BioLab(varargin)
% BIOLAB MATLAB code for BioLab.fig
%      BIOLAB, by itself, creates a new BIOLAB or raises the existing
%      singleton*.
%
%      H = BIOLAB returns the handle to a new BIOLAB or the handle to
%      the existing singleton*.
%
%      BIOLAB('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BIOLAB.M with the given input arguments.
%
%      BIOLAB('Property','Value',...) creates a new BIOLAB or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before BioLab_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to BioLab_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help BioLab

% Last Modified by GUIDE v2.5 23-Oct-2019 20:24:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @BioLab_OpeningFcn, ...
                   'gui_OutputFcn',  @BioLab_OutputFcn, ...
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


% --- Executes just before BioLab is made visible.
function BioLab_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to BioLab (see VARARGIN)

% Choose default command line output for BioLab
handles.output = hObject;
subj = [];
subj.Subject1 = [];
subj.Subject1.Data = struct();
subj.Subject1.Info = struct();
handles.subj = subj;
handles.c_subj = 'Subject1';
handles.c_exp = [];
% Update handles structure
handles = update_subjects(handles);
handles = update_experiment(handles);
handles.plot_fig = figure;
delete(handles.plot_fig);
set(handles.info_table, 'Data', {});

MYNAME=uicontrol('Style','text',...
    'Units','normalized',...
    'Position',[0.25 0.005 0.5 0.04],...
    'String','Biological Signal Lab at UT');
% Author: Ali Asghar Pourostad
guidata(hObject, handles);

% UIWAIT makes BioLab wait for user response (see UIRESUME)
% uiwait(handles.figure1);
function out = update_subjects(handles)
set(handles.subj_list, 'String', fieldnames(handles.subj));
out = handles;

function out = update_experiment(handles)
set(handles.exp_list, 'String', fieldnames(handles.subj.(handles.c_subj).Data));
set(handles.exp_subj_name, 'String', handles.c_subj);
contents = cellstr(get(handles.exp_list,'String'));
s = size(contents);
if(s(1) > 0)
    handles.c_exp = contents{1};
    set(handles.exp_list,'Value',1)
end
out = handles;

function out = init_panel(handles)
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
set(handles.channels_list, 'String', c_exp.titles_block1);
set(handles.panel_subj_name, 'String', handles.c_subj);
set(handles.panel_exp_name, 'String', handles.c_exp);
set(handles.panel_file_name, 'String', handles.subj.(handles.c_subj).Data.(handles.c_exp).filename);
set(handles.panel_title_edit, 'String', c_exp.titles_block1(c_exp.c_channel(1), :));
set(handles.panel_ylabel_edit, 'String', c_exp.units_block1(c_exp.c_channel(1), :));
get(handles.graph_color, 'BackgroundColor');
set(handles.graph_color, 'BackgroundColor', c_exp.graph_color(c_exp.c_channel(1),:));
set(handles.comment_color, 'BackgroundColor', c_exp.comment_color(c_exp.c_channel(1),:));
com_size = size(c_exp.comtick_block1);
comment_table = cell(com_size(1), 2);
comment_table(:,1) = num2cell(c_exp.ticktimes_block1(c_exp.comtick_block1));
comment_table(:,2) = cellstr(c_exp.comtext_block1);
set(handles.panel_comment_table,  'Data', comment_table);

%crop part
set(handles.panel_cropfrom_edit, 'String', num2str(c_exp.ticktimes_block1(1)));
set(handles.panel_cropto_edit, 'String', num2str(c_exp.ticktimes_block1(end)));
out = handles;

function out = update_info(handles)
set(handles.info_subj_name, 'String', handles.c_subj);

info_values = ('');
info_fields = fieldnames(handles.subj.(handles.c_subj).Info);
for i = info_fields'
    info_values(end + 1, :) = handles.subj.(handles.c_subj).Info.(char(i));
end
siz = size(info_values);
info_table = cell(siz(1), 2);
for i = 1:siz(1)
    info_table{i,1} = char(info_fields(i,:));
    info_table{i,2} = info_values(i,:);
end
set(handles.info_table, 'Data', info_table);
out = handles;

% --- Outputs from this function are returned to the command line.
function varargout = BioLab_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in add_exp.
function add_exp_Callback(hObject, eventdata, handles)
% hObject    handle to add_exp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%try

%     set(handles.axes1, 'YTickLabel', file_struct.units_block1);
%     set(handles.axes1, 'XTickLabel', 't(s)');
    
    guidata(hObject, handles);
%catch
%    error('can''t open file. invalid file');
%end


function save_plot(handles)
fignew = figure('Visible','off'); % Invisible figure
newAxes = copyobj(handles.axes2,fignew); % Copy the appropriate axes
set(newAxes,'Position',get(groot,'DefaultAxesPosition')); % The original position is copied too, so adjust it.
set(fignew,'CreateFcn','set(gcbf,''Visible'',''on'')'); % Make it visible upon loading
savefig(fignew,'test.fig');
delete(fignew);



function sub_num_edit_Callback(hObject, eventdata, handles)
% hObject    handle to sub_num_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.sub_num = str2num(get(hObject,'String'));
% Hints: get(hObject,'String') returns contents of sub_num_edit as text
%        str2double(get(hObject,'String')) returns contents of sub_num_edit as a double


% --- Executes during object creation, after setting all properties.
function sub_num_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sub_num_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function info_field_edit_Callback(hObject, eventdata, handles)
% hObject    handle to info_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of info_field_edit as text
%        str2double(get(hObject,'String')) returns contents of info_field_edit as a double


% --- Executes during object creation, after setting all properties.
function info_field_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to info_field_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function info_value_edit_Callback(hObject, eventdata, handles)
% hObject    handle to info_value_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of info_value_edit as text
%        str2double(get(hObject,'String')) returns contents of info_value_edit as a double


% --- Executes during object creation, after setting all properties.
function info_value_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to info_value_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in info_add_btn.
function info_add_btn_Callback(hObject, eventdata, handles)
% hObject    handle to info_add_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
info_table = get(handles.info_table, 'Data');
info_table(end+1,:) = cell(2,1);
set(handles.info_table, 'Data', info_table);
guidata(hObject, handles);

% --- Executes on selection change in exp_list.
function exp_list_Callback(hObject, eventdata, handles)
% hObject    handle to exp_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns exp_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from exp_list
contents = cellstr(get(hObject,'String'));
handles.c_exp = contents{get(hObject,'Value')};
if(~strcmp(handles.subj.(handles.c_subj).Data.(handles.c_exp).filename, ''))
    init_panel(handles);
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function exp_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exp_add_btn.
function exp_add_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exp_add_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exp_name = get(handles.exp_name_edit, 'String');
if(isempty(find(strcmp(fieldnames(handles.subj.(handles.c_subj).Data), exp_name) == 1, 1)))
    handles.subj.(handles.c_subj).Data.(exp_name).filename = '';
end
handles = update_experiment(handles);
guidata(hObject, handles);

% --- Executes on button press in exp_del_btn.
function exp_del_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exp_del_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.exp_list,'String'));
s = size(contents);
if(s(1) > 1)
    handles.subj.(handles.c_subj).Data = ...
        rmfield(handles.subj.(handles.c_subj).Data, handles.c_exp);
    set(handles.exp_list,'Value', 1);
    handles.c_exp = contents{1};
    handles = update_experiment(handles);
    guidata(hObject, handles);
end


function exp_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to exp_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of exp_name_edit as text
%        str2double(get(hObject,'String')) returns contents of exp_name_edit as a double


% --- Executes during object creation, after setting all properties.
function exp_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to exp_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in exp_rename_btn.
function exp_rename_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exp_rename_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
exp_name = get(handles.exp_name_edit, 'String');
c_subj = handles.subj.(handles.c_subj);
if(isempty(find(strcmp(fieldnames(c_subj.Data), exp_name) == 1, 1)))
    k = c_subj.Data.(handles.c_exp);
    c_subj.Data.(exp_name) = ...
        c_subj.Data.(handles.c_exp);
    handles.subj.(handles.c_subj).Data = rmfield(c_subj.Data, handles.c_exp);
end
handles = update_experiment(handles);
guidata(hObject, handles);

% --- Executes on button press in exp_load_btn.
function exp_load_btn_Callback(hObject, eventdata, handles)
% hObject    handle to exp_load_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name, file_path] = uigetfile('.mat');
a = load([file_path file_name]);

i = 0;
h = [];
while(true)
    try
        i = i+1;
        h = [h, {eval(['a.comchan_block' num2str(i)])}];
    catch e
        break;
    end
end
i=i-1;
i = 0;
h = [];
while(true)
    try
        i = i+1;
        h = [h, {eval(['a.comchan_block' num2str(i)])}];
    catch e
        break;
    end
end
block_size=i-1;


name = 'comtext_block';
output = {};
for j = (1:block_size)
    temp = eval(['a.' name num2str(j)]);
    if size(temp) > 0
        temp = cellstr(temp);
    end
    if(j ~= i)
        temp{end + 1,1} = ['datablock ' num2str(j+1)];
    end
    output = vertcat(output, temp);
end
max_size = 0;
for i = 1:size(output)
    s = size(cell2mat(output(i)));
   if(max_size < s(2))
       max_size = s(2);
   end
end
for i = 1:size(output)
    output(i) = pad(output(i), max_size);
end
output = cell2mat(output);
a.comtext_block1 = output;
if(block_size > 1)
for i = (2:block_size)
    name = 'a.comtick_block';
    temp = eval([name num2str(i)]);
    s = size(a.ticktimes_block1);
    a.comtick_block1 = [a.comtick_block1; s(2);temp + s(2) + 1];
    name = 'a.ticktimes_block';
    temp = eval([name num2str(i)]);
    a.ticktimes_block1 = [a.ticktimes_block1, temp + a.ticktimes_block1(end) + 0.001];
    name = 'a.data_block';
    temp = eval([name num2str(i)]);
    a.data_block1 = [a.data_block1, temp];
    clear(['a.data_block' num2str(i)], ['a.ticktimes' num2str(i)]);
end
end
a.comtext_block1(end, :) = [];
a.c_channel = 1;
tbsize = size(a.titles_block1);
a.graph_color = zeros(tbsize(1), 3);
a.graph_color(:, 3) = 1;
a.comment_color = zeros(tbsize(1), 3);
a.comment_color(:, 1) = 0.49;
a.comment_color(:, 2) = 0.18;
a.comment_color(:, 3) = 0.561;
handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise = a;
handles.subj.(handles.c_subj).Data.(handles.c_exp).filename = file_name;
handles = init_panel(handles);
guidata(hObject, handles);


% --- Executes on button press in subj_add_btn.
function subj_add_btn_Callback(hObject, eventdata, handles)
% hObject    handle to subj_add_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
subj_name = get(handles.subj_name_edit, 'String');
if(isempty(find(strcmp(fieldnames(handles.subj), subj_name) == 1, 1)))
    handles.subj.(subj_name).Data = struct();
    handles.subj.(subj_name).Info = struct();
end
handles = update_subjects(handles);
guidata(hObject, handles);

% --- Executes on button press in subj_del_btn.
function subj_del_btn_Callback(hObject, eventdata, handles)
% hObject    handle to subj_del_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
contents = cellstr(get(handles.subj_list,'String'));
s = size(contents);
if(s(1) > 1)
    c_subj = contents{get(handles.subj_list,'Value')};
    handles.subj = rmfield(handles.subj, c_subj);
    set(handles.subj_list,'Value', 1);
    handles.c_subj = contents{1};
    handles = update_subjects(handles);
    guidata(hObject, handles);
end

% --- Executes on selection change in subj_list.
function subj_list_Callback(hObject, eventdata, handles)
% hObject    handle to subj_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns subj_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from subj_list
contents = cellstr(get(hObject,'String'));
handles.c_subj = contents{get(hObject,'Value')};
handles = update_experiment(handles);
update_info(handles);
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function subj_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subj_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function subj_name_edit_Callback(hObject, eventdata, handles)
% hObject    handle to subj_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of subj_name_edit as text
%        str2double(get(hObject,'String')) returns contents of subj_name_edit as a double


% --- Executes during object creation, after setting all properties.
function subj_name_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subj_name_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in subj_rename_btn.
function subj_rename_btn_Callback(hObject, eventdata, handles)
% hObject    handle to subj_rename_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

subj_name = get(handles.subj_name_edit, 'String');
if(isempty(find(strcmp(fieldnames(handles.subj), subj_name) == 1, 1)))
    handles.subj.(subj_name) = handles.subj.(handles.c_subj);
    handles.subj = rmfield(handles.subj, handles.c_subj);
end
handles = update_subjects(handles);
guidata(hObject, handles);



function panel_title_edit_Callback(hObject, eventdata, handles)
% hObject    handle to panel_title_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
size_title = size(c_exp.titles_block1(c_exp.c_channel(1), :));
input = get(hObject,'String');
in_size = size(input);
if(in_size(2) > size_title(2))
    warning(['length should be less than: ' num2str(size_title)]);
else
    a = pad(input, size_title(2));
    c_exp.titles_block1(c_exp.c_channel(1), :) = a;
end
handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise = c_exp;
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of panel_title_edit as text
%        str2double(get(hObject,'String')) returns contents of panel_title_edit as a double


% --- Executes during object creation, after setting all properties.
function panel_title_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panel_title_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function panel_xlabel_edit_Callback(hObject, eventdata, handles)
% hObject    handle to panel_xlabel_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of panel_xlabel_edit as text
%        str2double(get(hObject,'String')) returns contents of panel_xlabel_edit as a double


% --- Executes during object creation, after setting all properties.
function panel_xlabel_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panel_xlabel_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function panel_ylabel_edit_Callback(hObject, eventdata, handles)
% hObject    handle to panel_ylabel_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
size_units = size(c_exp.units_block1(c_exp.c_channel(1), :));
input = get(hObject,'String');
in_size = size(input);
if(in_size(2) > size_units(2))
    warning(['length should be less than: ' num2str(size_units)]);
else
    a = pad(input, size_units(2));
    c_exp.units_block1(c_exp.c_channel(1), :) = a;
end
handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise = c_exp;
guidata(hObject, handles);
% Hints: get(hObject,'String') returns contents of panel_ylabel_edit as text
%        str2double(get(hObject,'String')) returns contents of panel_ylabel_edit as a double


% --- Executes during object creation, after setting all properties.
function panel_ylabel_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panel_ylabel_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in panel_graphcolor_btn.
function panel_graphcolor_btn_Callback(hObject, eventdata, handles)
% hObject    handle to panel_graphcolor_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
set(handles.graph_color, 'BackgroundColor', uisetcolor());
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
c_exp.graph_color(c_exp.c_channel, :) = get(handles.graph_color, 'BackgroundColor');
handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise = c_exp;
guidata(hObject, handles);
% --- Executes on button press in panel_commentcolor_btn.
function panel_commentcolor_btn_Callback(hObject, eventdata, handles)
% hObject    handle to panel_commentcolor_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
color = uisetcolor();
set(handles.comment_color, 'BackgroundColor', color);
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
c_exp.comment_color(c_exp.c_channel, :) = color;
handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise = c_exp;
guidata(hObject, handles);

% --- Executes on button press in panel_delcomment_btn.
function panel_delcomment_btn_Callback(hObject, eventdata, handles)
% hObject    handle to panel_delcomment_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    comment_table = get(handles.panel_comment_table, 'Data');
    comment_table(handles.com_selected_row,:) = [];
    set(handles.panel_comment_table, 'Data', comment_table);
    guidata(hObject, handles);
catch
end

function panel_cropfrom_edit_Callback(hObject, eventdata, handles)
% hObject    handle to panel_cropfrom_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of panel_cropfrom_edit as text
%        str2double(get(hObject,'String')) returns contents of panel_cropfrom_edit as a double


% --- Executes during object creation, after setting all properties.
function panel_cropfrom_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panel_cropfrom_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function panel_cropto_edit_Callback(hObject, eventdata, handles)
% hObject    handle to panel_cropto_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of panel_cropto_edit as text
%        str2double(get(hObject,'String')) returns contents of panel_cropto_edit as a double


% --- Executes during object creation, after setting all properties.
function panel_cropto_edit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to panel_cropto_edit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in panel_plot_btn.
function panel_plot_btn_Callback(hObject, eventdata, handles)
global comment_on_plot line_on_plot;
% hObject    handle to panel_plot_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
if(~isvalid(handles.plot_fig))
    handles.plot_fig = figure;
end
figure(handles.plot_fig);
subplots = size(get(handles.channels_list, 'Value'));
vals = get(handles.channels_list, 'Value');
for j = 1:subplots(2)
    to_plot = c_exp.data_block1(vals(1), :);

subplot(subplots(2), 1, j);
plot(c_exp.ticktimes_block1, to_plot, 'Color', c_exp.graph_color(vals(1), :));
hold on;
xlabel(get(handles.panel_xlabel_edit,'String'));
ylabel(c_exp.units_block1(vals(1), :));
title([c_exp.titles_block1(vals(1), :) ' - ' get(handles.panel_exp_name,'String')]);
vals(1)=[];

%plot comments
comment_table = get(handles.panel_comment_table, 'Data');
for i=1:size(comment_table)
try
    xline(cell2mat(comment_table(i,1)),'--', char(comment_table(i,2)),...
        'LineWidth', 1 , 'Color', c_exp.comment_color(j, :)); 
catch
    line_on_plot(i) = line(cell2mat([comment_table(i,1), comment_table(i,1)]), ylim(gca), 'LineStyle', '--', ...
        'LineWidth', 1, 'Color', c_exp.comment_color(j, :));
    ylimit = ylim(gca);
    comment_on_plot(i) = text(cell2mat(comment_table(i,1)), ylimit(1), char(comment_table(i,2)),...
        'Color', c_exp.comment_color(j, :));
    set(comment_on_plot(i), 'Rotation', 90);
    set(comment_on_plot(i), 'Clipping', 'on');
end
end
end
hold off;
guidata(hObject, handles);

% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name, file_path] = uiputfile('.mat', 'Save Struct', 'Experiment');
to_save.Experiment = handles.subj;
save([file_path file_name], '-struct', 'to_save');

% --- Executes on button press in info_del_btn.
function info_del_btn_Callback(hObject, eventdata, handles)
% hObject    handle to info_del_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
try
    info_table = get(handles.info_table, 'Data');
    info_table(handles.info_selected_row,:) = [];
    set(handles.info_table, 'Data', info_table);
    guidata(hObject, handles);
catch
end

% --- Executes during object creation, after setting all properties.
function subj_rename_btn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to subj_rename_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes when entered data in editable cell(s) in panel_comment_table.
function panel_comment_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to panel_comment_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
comment_table = get(handles.panel_comment_table, 'Data');
c_exp.comtext_block1 = char(comment_table(:,2));
t = cell2mat(comment_table(:,1));
m = [];
for i = t'
m(end+1,1) = find(abs(c_exp.ticktimes_block1-i) < 0.0005);
end
c_exp.comtick_block1 = m;
handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise = c_exp;
guidata(hObject, handles);

% --- Executes when selected cell(s) is changed in panel_comment_table.
function panel_comment_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to panel_comment_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
try
    handles.com_selected_row = eventdata.Indices(1);
    guidata(hObject, handles);
catch
end



% --- Executes on button press in panel_add_btn.
function panel_add_btn_Callback(hObject, eventdata, handles)
% hObject    handle to panel_add_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
comment_table = get(handles.panel_comment_table, 'Data');
comment_table(end+1,:) = cell(2,1);
set(handles.panel_comment_table, 'Data', comment_table);
guidata(hObject, handles);


% --- Executes when selected cell(s) is changed in info_table.
function info_table_CellSelectionCallback(hObject, eventdata, handles)
% hObject    handle to info_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) currently selecteds
% handles    structure with handles and user data (see GUIDATA)
try
    handles.info_selected_row = eventdata.Indices(1);
    guidata(hObject, handles);
catch
end


% --- Executes on button press in panel_crop_btn.
function panel_crop_btn_Callback(hObject, eventdata, handles)
% hObject    handle to panel_crop_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
start_point = str2num(get(handles.panel_cropfrom_edit, 'String'));
end_point = str2num(get(handles.panel_cropto_edit, 'String'));
start_point = find(abs(c_exp.ticktimes_block1-start_point) < 0.0005);
end_point = find(abs(c_exp.ticktimes_block1-end_point) < 0.0005);
c_exp.ticktimes_block1 = c_exp.ticktimes_block1(start_point:end_point);
if(get(handles.panel_movezero, 'Value'))
    c_exp.ticktimes_block1 = c_exp.ticktimes_block1 - c_exp.ticktimes_block1(1);
    c_exp.comtick_block1 = c_exp.comtick_block1 - start_point;
end
c_exp.data_block1 = c_exp.data_block1(:,start_point:end_point);

%remove comments
i = 1;
s = size(c_exp.comtick_block1);
while i < s(1)
    s = size(c_exp.comtick_block1);
    try
        c_exp.ticktimes_block1(c_exp.comtick_block1(i));
        i = i + 1;
    catch
        condition = i<size(c_exp.comtick_block1);
        if(condition(1))
            c_exp.comtick_block1(i) = [];
            c_exp.comtext_block1(i,:) = [];
        else
            c_exp.comtick_block1(end) = [];
            c_exp.comtext_block1(end,:) = [];
        end
    end
end
handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise = c_exp;
init_panel(handles);
guidata(hObject, handles);


% --- Executes on button press in panel_movezero.
function panel_movezero_Callback(hObject, eventdata, handles)
% hObject    handle to panel_movezero (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of panel_movezero


% --- Executes when entered data in editable cell(s) in info_table.
function info_table_CellEditCallback(hObject, eventdata, handles)
% hObject    handle to info_table (see GCBO)
% eventdata  structure with the following fields (see MATLAB.UI.CONTROL.TABLE)
%	Indices: row and column indices of the cell(s) edited
%	PreviousData: previous data for the cell(s) edited
%	EditData: string(s) entered by the user
%	NewData: EditData or its converted form set on the Data property. Empty if Data was not changed
%	Error: error string when failed to convert EditData to appropriate value for Data
% handles    structure with handles and user data (see GUIDATA)
c_subj = handles.subj.(handles.c_subj);
info_table = get(hObject, 'Data');
info_fields = char(info_table(:,1));
info_values = [];
try
    info_values = char(info_table(:,2));
catch
    info_values(end+1) = ' ';
end
c_subj.Info = struct();
for i = 1:size(info_fields)
    try
        temp = info_fields(i,:);
        temp = temp(~isspace(temp));
        c_subj.Info.(temp) = info_values(i,:);
    catch
    end
end
handles.subj.(handles.c_subj) = c_subj;
%update_info(handles);
guidata(hObject, handles);


% --- Executes on button press in panel_fit_btn.
function panel_fit_btn_Callback(hObject, eventdata, handles)
global comment_on_plot line_on_plot;
% hObject    handle to panel_fit_btn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
c_exp = handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise;
if(~isvalid(handles.plot_fig))
    handles.plot_fig = figure;
end
figure(handles.plot_fig);
subplots = size(get(handles.channels_list, 'Value'));
for j=1:subplots(2)
% to_plot = c_exp.data_block1(j, :);
subplot(subplots(2), 1, j);
% plot(c_exp.ticktimes_block1, to_plot, 'Color', c_exp.graph_color(j, :));
hold on;
xlabel(get(handles.panel_xlabel_edit,'String'));
ylabel(c_exp.units_block1(j, :));
title([c_exp.titles_block1(j, :) ' - ' get(handles.panel_exp_name,'String')]);


%plot comments
comment_table = get(handles.panel_comment_table, 'Data');
for i=1:size(comment_table)
try
    xline(cell2mat(comment_table(i,1)),'--', char(comment_table(i,2)),...
        'LineWidth', 1 , 'Color', c_exp.comment_color(j, :)); 
catch
    line_on_plot(i) = line(cell2mat([comment_table(i,1), comment_table(i,1)]), ylim(gca), 'LineStyle', '--', ...
        'LineWidth', 1, 'Color', c_exp.comment_color(j, :));
    ylimit = ylim(gca);
    comment_on_plot(i) = text(cell2mat(comment_table(i,1)), ylimit(1), char(comment_table(i,2)),...
        'Color', c_exp.comment_color(j, :));
    set(comment_on_plot(i), 'Rotation', 90);
    set(comment_on_plot(i), 'Clipping', 'on');
end
end
end
hold off;
guidata(hObject, handles);


% --- Executes on button press in load_struct.
function load_struct_Callback(hObject, eventdata, handles)
% hObject    handle to load_struct (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[file_name, file_path] = uigetfile('.mat');
handles.subj = load([file_path file_name]);
handles.subj = handles.subj.Experiment;
update_subjects(handles);
update_info(handles);
update_experiment(handles);


% --- Executes on selection change in channels_list.
function channels_list_Callback(hObject, eventdata, handles)
% hObject    handle to channels_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.subj.(handles.c_subj).Data.(handles.c_exp).Exercise.c_channel = get(hObject,'Value');
init_panel(handles);
guidata(hObject, handles);
% Hints: contents = cellstr(get(hObject,'String')) returns channels_list contents as cell array
%        contents{get(hObject,'Value')} returns selected item from channels_list


% --- Executes during object creation, after setting all properties.
function channels_list_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channels_list (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: listbox controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in panel_holdon.
function panel_holdon_Callback(hObject, eventdata, handles)
% hObject    handle to panel_holdon (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of panel_holdon
