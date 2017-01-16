function varargout = GUI_ACE_Inhib_PKPD(varargin)
% ************************************************************************
% **RESEARCH & EDUCATIONAL USE ONLY--NOT FOR MEDICINAL OR INDUSTRIAL USE**
% ************************************************************************
% GUI_ACE_Inhib_PKPD MATLAB code for GUI_ACE_Inhib_PKPD.fig
%      GUI_ACE_Inhib_PKPD, by itself, creates a new 
%      GUI_ACE_Inhib_PKPD or raises the existing singleton*.
%
%      H = GUI_ACE_Inhib_PKPD returns the handle to a new 
%      GUI_ACE_Inhib_PKPD or the handle to the existing singleton*.
%
%      GUI_ACE_Inhib_PKPD('CALLBACK',hObject,eventData,handles,...)  
%      calls the local function named CALLBACK in 
%      GUI_ACE_Inhib_PKPD.m with the given input arguments.
%
%      GUI_ACE_Inhib_PKPD('Property','Value',...) creates a new 
%      GUI_ACE_Inhib_PKPD or raises the existing singleton*. 
%      Starting from the left, property value pairs are applied to the GUI  
%      before GUI_ACE_Inhib_PKPD_OpeningFcn gets called. An
%      unrecognized property name or invalid value makes property 
%      application stop. All inputs are passed to 
%      GUI_ACE_Inhib_PKPD_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu. Choose "GUI allows only one
%      instance to run (singleton)".
%
% GUI app description: This app is an interactive computer simulation that 
% can be used to design the best dosage of ACE inhibitor pharmaceuticals 
% for reducing high blood pressure.  The app uses tools from mathematics,
% chemical engineering, pharmaceutical science, and computational science 
% to describe chemical reactions in the human body involved in the
% absorption, metabolism, and excretion of the drug and how the blood 
% pressure-regulating hormone Angiotensin II is affected by the drug
% concentration as a function of time using a PKPD model. 
%
% Begin by entering dose size and frequency values and select the ACE 
% inhibitor drug and the patient kidney function. Run the simulation to 
% generate the plots. Use the plots to analyze the behavior of the tested 
% dose. Determine what dose size and frequency will be the most effective 
% in lowering the blood pressure of the individual to a normal level while 
% managing tradeoffs like efficacy, inconvience, price, and side effects.
%
% See also: GUIDE, GUIDATA, GUIHANDLES
% ************************************************************************
% **RESEARCH & EDUCATIONAL USE ONLY--NOT FOR MEDICINAL OR INDUSTRIAL USE**
% ************************************************************************

% Edit the above text to modify the response to help GUI_ACE_Inhib_PKPD

% Last Modified by GUIDE v2.5 13-Jun-2016 10:45:33

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_ACE_Inhib_PKPD_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_ACE_Inhib_PKPD_OutputFcn, ...
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


% --- Executes just before GUI_ACE_Inhib_PKPD is made visible.
function GUI_ACE_Inhib_PKPD_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments tNormo GUI_ACE_Inhib_PKPD (see VARARGIN)

% set default manipulated variables
handles.pill_mg = 1;
% ng, drug dose
handles.drugdose = (handles.pill_mg)*1e6; 
handles.num_doses_per_day = 1;
% hours, dosage interval with t = time after nth dose 
handles.tau = 24/handles.num_doses_per_day; 
handles.drugname = 'benazepril';
handles.renalfunction = 'normal';
handles.tfinal_dosing = 24;
handles.baseline = 70; % 30% reduction in ANGII as desired threshold
handles.checked = 'no';
guidata(hObject, handles);

% set simulation coefficients from parameter estimation cases
handles = update_coefficients(hObject,handles);

% run the model for the default conditions
handles = run_drug_dose_to_AngII(hObject,handles);
guidata(hObject, handles);
set(0,'DefaultAxesLineStyleOrder',{'-'})
set(0,'DefaultAxesColorOrder',[0 0.447 0.741; 0.85 0.325 0.098; 0.929 ...
    0.694 0.125; 0.494 0.184 0.556; 0.466 0.674 0.188; 0.301 0.745 0.933; ...
    0.635 0.078 0.184])
handles.ColOrd = get(handles.Drugvstime,'ColorOrder');
handles.row_index = 0;
% update_gui_plot(hObject,handles);
plot_baseline(hObject,handles)

% Choose default command line output for GUI_ACE_Inhib_PKPD
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI_ACE_Inhib_PKPD wait for user response (see UIRESUME)
% uiwait(handles.figure1);

function handles = update_coefficients(hObject,handles);
% set simulation coefficients from parameter estimation cases
paramsfile = strcat('params_',handles.drugname,handles.renalfunction,'.mat');
params = matfile(paramsfile);
VmaxoverKm= params.VmaxoverKm;
k_cat_Renin= params.k_cat_Renin;
k_feedback=  params.k_feedback;
feedback_capacity = params.feedback_capacity;
k_cons_AngII= params.k_cons_AngII;
handles.coefficients = zeros(1,5);
handles.coefficients(1) = VmaxoverKm;
handles.coefficients(2) = k_cat_Renin;
handles.coefficients(3) = k_feedback;
handles.coefficients(4) = feedback_capacity;
handles.coefficients(5) = k_cons_AngII;
guidata(hObject, handles);

function handles = run_drug_dose_to_AngII(hObject,handles)
drugoutput = call_PKPD_model_scalar(handles.coefficients,...
    handles.tfinal_dosing,24*7,'','',handles.drugdose,...
    handles.tau,handles.drugname,handles.renalfunction,'-');
handles.t = drugoutput(:,1);
% Drug is diacid concentration since the inhibition depends on the PK of the diacid
handles.drug_conc = drugoutput(:,2); 
handles.AngII_conc = drugoutput(:,3);
handles.clear = 'no';
guidata(hObject, handles);

function update_gui_plot(hObject,handles)
if strcmp(handles.checked,'yes')
   handles.row_index = handles.row_index+1;
end
axes(handles.Drugvstime);

if strcmp(handles.drugname,'benazepril')
    drugnum = 1;
else
    drugnum = 2;
end
row_index = mod(handles.row_index,7)+1;
if handles.num_doses_per_day == 1
    plot(handles.t/24,handles.drug_conc,'linewidth',5,'DisplayName',...
        [num2str(handles.num_doses_per_day) ' dose of ' ...
        num2str(handles.pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' handles.renalfunction],'Color',handles.ColOrd(row_index,:))
else
    plot(handles.t/24,handles.drug_conc,'linewidth',5,'DisplayName',...
        [num2str(handles.num_doses_per_day) ' doses of '...
        num2str(handles.pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' handles.renalfunction],'Color',handles.ColOrd(row_index,:))
end  

legend('-Dynamiclegend','Location','Best')
xlabel('t (days)'), ylabel('Drug Concentration in the Body (ng/mL)')
% if strcmp(handles.checked,'no')
%     plot_baseline(hObject,handles)
% end
axes(handles.AngIIvstime);

if handles.num_doses_per_day == 1
    plot(handles.t/24,handles.AngII_conc./handles.AngII_conc(1,1)*100,'linewidth',5,'DisplayName',...
        [num2str(handles.num_doses_per_day) ' dose of '...
        num2str(handles.pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' handles.renalfunction],'Color',handles.ColOrd(row_index,:))
else
   plot(handles.t/24,handles.AngII_conc./handles.AngII_conc(1,1)*100,'linewidth',5,'DisplayName',...
       [num2str(handles.num_doses_per_day) ' doses of '...
       num2str(handles.pill_mg) ' mg daily of Drug ' num2str(drugnum)...
       '; KF: ' handles.renalfunction],'Color',handles.ColOrd(row_index,:))
end 
legend('-Dynamiclegend','Location','Best')
xlabel('t (days)'), ylabel('% of Initial Hormone Concentration')
if strcmp(handles.checked,'no')
   hold(handles.Drugvstime,'off') 
   hold(handles.AngIIvstime,'off') 
elseif strcmp(handles.checked,'yes')
   hold(handles.Drugvstime,'on')
   hold(handles.AngIIvstime,'on')
end
guidata(hObject, handles);

% --- Executes on button press in clearplots_button.
function clearplots_button_Callback(hObject, eventdata, handles)
% hObject    handle to clearplots_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clearplots(hObject,handles)
% if strcmp(handles.checked,'yes');
    plot_baseline(hObject,handles);
% end


function plot_baseline(hObject,handles)
axes(handles.AngIIvstime);
plot(0:7,ones(size(0:7)).*handles.baseline,'k','linewidth',5,'DisplayName',...
    'Target Max: [hormone] reduced by 30%')
% hold(handles.AngIIvstime,'on')
% plot(0:7,zeros(size(0:7)),'r','linewidth',5,'DisplayName',...
%     'Target Min: [hormone] > 0%')
% axis([0 7 0 100])
legend('-Dynamiclegend','Location','Best')
hold(handles.AngIIvstime,'on')
guidata(hObject, handles);

function clearplots(hObject,handles)
cla(handles.Drugvstime)
legend(handles.Drugvstime, 'off');
cla(handles.AngIIvstime)
legend(handles.AngIIvstime, 'off');
hold(handles.Drugvstime,'off')
hold(handles.AngIIvstime,'off')
handles_row_index = 0;
guidata(hObject, handles);

% --- Executes on button press in layerplots_check.
function layerplots_check_Callback(hObject, eventdata, handles)
% hObject    handle to layerplots_check (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if (get(hObject,'Value') == get(hObject,'Max'))
    hold(handles.Drugvstime,'on')
    hold(handles.AngIIvstime,'on')
    handles.checked = 'yes';
    guidata(hObject, handles);
else
    clearplots(hObject,handles);
    plot_baseline(hObject,handles);
    handles.checked = 'no';
    hold(handles.Drugvstime,'off')
    hold(handles.AngIIvstime,'off')
    guidata(hObject, handles);
end
guidata(hObject, handles);
% Hint: get(hObject,'Value') returns toggle state of layerplots_check

% --- Outputs from this function are returned to the command line.
function varargout = GUI_ACE_Inhib_PKPD_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in run_sim_button.
function run_sim_button_Callback(hObject, eventdata, handles)
% hObject    handle to run_sim_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

handles = run_drug_dose_to_AngII(hObject,handles);
guidata(hObject, handles);
if strcmp(handles.checked,'no')
    clearplots(hObject,handles);
    plot_baseline(hObject,handles);
end
update_gui_plot(hObject,handles);


function dosesize_Callback(hObject, eventdata, handles)
% hObject    handle to dosesize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dosesize as text
%        str2double(get(hObject,'String')) returns contents of dosesize as a double
if str2double(get(hObject,'String'))<0
    h = msgbox('Dose size cannot be below zero.', 'Negative Dose');
    set(hObject,'String',0);
elseif str2double(get(hObject,'String'))>20 && strcmp(handles.drugname,'benazepril')
    h = msgbox('Potentially toxic dose. Reduce value to <20.',...
        'POTENTIALLY TOXIC DOSE!');
    set(hObject,'String',20);
elseif str2double(get(hObject,'String'))>20 && strcmp(handles.drugname,'cilazapril')
    h = msgbox('Potentially toxic dose. Reduce value to <20.',...
        'POTENTIALLY TOXIC DOSE!');
    set(hObject,'String',20);
end
handles.pill_mg = str2double(get(hObject,'String'));
handles.drugdose = (handles.pill_mg)*1e6; % ng, drug dose
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dosesize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dosesize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'String',1)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function dosefreq_Callback(hObject, eventdata, handles)
% hObject    handle to dosefreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dosefreq as text
%        str2double(get(hObject,'String')) returns contents of dosefreq as a double
if str2double(get(hObject,'String')) > 24
    h = msgbox('Maximum dose frequency is 24 doses/day.',...
        'Entered Value Exceeds Max Dose Frequency');
    set(hObject,'String',24);
elseif str2double(get(hObject,'String')) < 1
    h = msgbox('Minimum dose frequency is 1 dose/day.',...
        'Entered Value Is Below Min Dose Frequency');
    set(hObject,'String',1);
elseif mod(str2double(get(hObject,'String')),1)~=0
h = msgbox(...
'Doses must be integer values (1, 2, 3, ...). Dose frequency rounded down to nearest integer.',...
'Entered Value Is Not an Integer');
    num = floor(str2double(get(hObject,'String')));
    set(hObject,'String',num);
end
handles.num_doses_per_day = str2double(get(hObject,'String'));
% hours, dosage interval with t = time after nth dose 
handles.tau = 24/handles.num_doses_per_day; 
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function dosefreq_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dosefreq (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
set(hObject,'String',1)
% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), ...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in savetop_button.
function savetop_button_Callback(hObject, eventdata, handles)
% hObject    handle to savetop_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('Drug_vs_time.png', 'file') == 2
    beep
h = msgbox(...
'Drug_vs_time.png already exists. Please rename or delete the existing Drug_vs_time.png file before trying to save again.',...
'Top Plot NOT Saved');
else
    ax = handles.Drugvstime;
    figure_handle = isolate_axes(ax);
    export_fig Drug_vs_time.png
h = msgbox(...
'The top plot was successfully saved as Drug_vs_time.png. Be careful to rename it if you want to save multiple versions of the top plot.',...
'Top Plot Saved');
end
% --- Executes on button press in savebottom_button.
function savebottom_button_Callback(hObject, eventdata, handles)
% hObject    handle to savebottom_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if exist('BPhormone_vs_time.png', 'file') == 2
    beep
h = msgbox(...
'BPhormone_vs_time.png already exists. Please rename or delete the existing BPhormone_vs_time.png file before trying to save again.',...
'Bottom Plot NOT Saved');
else
    ax = handles.AngIIvstime;
    figure_handle = isolate_axes(ax);
    export_fig BPhormone_vs_time.png
h = msgbox(...
'The bottom plot was successfully saved as BPhormone_vs_time.png. Be careful to rename it if you want to save multiple versions of the bottom plot.',...
'Bottom Plot Saved');
end

% --- Executes on button press in goal_button.
function goal_button_Callback(hObject, eventdata, handles)
% hObject    handle to goal_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox(...
'In this project, your team will utilize tools from tools from mathematics, chemical engineering, pharmaceutical science, and computational science to describe chemical reactions in the human body in this interactive computer simulation to design the best dosage of pharmaceuticals for reducing high blood pressure. Begin by entering dose size and frequency values and select the ACE inhibitor drug and the patient kidney function assigned to your group. Run the simulation to generate the plots and use these as tools to determine what dosage and frequency will be the most effective in lowering the blood pressure of the individual to a normal level.',...
'Goal of the Project');
%code to change font size below. Not sure how to make window bigger yet.
%ah = get( h, 'CurrentAxes' );
%ch = get( ah, 'Children' );
%set(ch, 'FontSize', 12);

% --- Executes on button press in aboutdrugs_button.
function aboutdrugs_button_Callback(hObject, eventdata, handles)
% hObject    handle to aboutdrugs_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox(...
{'Benazepril, under the brand name Lotensin, is an ACE inhibitor used for treating high blood pressure. This drug may also be used to treat heart failure and chronic renal failure or to prevent kidney damage in patients with diabetes.' 'Cilazapril is an ACE inhibitor used to treat mild-to-moderate high blood pressure and congestive heart failure. The usual recommended dose depends on the condition being treated as well as kidney and liver function.'},...
'About the Pharmaceutical Drugs');
% Benazepril is available in tablet form in 5, 10, 20, and 40 milligrams (mg).
% The dose range for treatment of high blood pressure is 1 mg to 5 mg once daily. Cilazapril is available in tablet form in 1, 2.5, and 5 mg doses.
% --- Executes on button press in ace_button.
function ace_button_Callback(hObject, eventdata, handles)
% hObject    handle to ace_button (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
h = msgbox(...
'Angiotensin converting enzyme (ACE) inhibitors are drugs that block the production of angiotensin II in the body. Angiotensin II is a hormone that constricts blood vessels, which can lead to high blood pressure and increase the work required for the heart to pump blood into the main arteries of the body. Blocking angiotensin II production with an ACE inhibitor can reverse these symptoms. ACE inhibitors have also been proven to aid patients with heart failure, coronary artery disease, adult onset diabetes, "diabetic tendency," and high blood pressure, as well as mild kidney disease. There are a wide range of ACE inhibitors on the market today in which the generic names all end with the letters "pril". ACE inhibitors have been shown to be very safe. Side effects may include lightheadedness and dizziness if blood pressure becomes too low and a mild cough.',...
'What is an ACE Inhibitor?');


% --- Executes on selection change in drug_menu.
function drug_menu_Callback(hObject, eventdata, handles)
% hObject    handle to drug_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns drug_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from drug_menu
items = get(hObject,'String');
index_selected = get(hObject,'Value');
if index_selected == 1
    handles.drugname = 'benazepril';
else
   handles.drugname = 'cilazapril';
end
guidata(hObject, handles);
handles = update_coefficients(hObject,handles);

% --- Executes during object creation, after setting all properties.
function drug_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to drug_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in renalfunction_menu.
function renalfunction_menu_Callback(hObject, eventdata, handles)
% hObject    handle to renalfunction_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
items = get(hObject,'String');
index_selected = get(hObject,'Value');
if index_selected == 1
    handles.renalfunction = 'normal';
else
    handles.renalfunction = 'impaired';
end
guidata(hObject, handles);
handles = update_coefficients(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns renalfunction_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from renalfunction_menu


% --- Executes during object creation, after setting all properties.
function renalfunction_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to renalfunction_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on selection change in duration_menu.
function duration_menu_Callback(hObject, eventdata, handles)
% hObject    handle to duration_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns duration_menu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from duration_menu
a = get(hObject,'Value');
if a == 1
    handles.tfinal_dosing = 24;
elseif a == 2
    handles.tfinal_dosing = 7*24;
end
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function duration_menu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to duration_menu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'),...
        get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


