%% Run PK/PD model for ACE inhibition without GUI to produce plots of all output
% This code is used to bypass the GUI to manually change input parameters
% and produce a larger suite of output plots than those displayed in the
% GUI. These plots were used in the development stages and in the
% publication: A. N. Ford Versypt, G. K. Harrell, A. N. McPeak, 
% A pharmacokinetic/pharmacodynamic model of ACE inhibition of the 
% renin-angiotensin system for normal and impaired renal function, 
% Computers & Chemical Engineering, 104 (2017) 311–322. 
% https://doi.org/10.1016/j.compchemeng.2017.03.027
%
% Input:
%   nargin == 0: no arguments specified at the command line
%       All the input parameters have default hard-coded values. These may
%       be adjusted directly in this code or changed through calling the
%       function in the command window with 6 or more arguments.
%   required parameters: 
%   run_PKPD_without_GUI(drugname,renalfunction,pill_mg,num_doses_per_day,tfinal_dosing,sim_time_end)
%       drugname is a string with acceptable values: 'benazepril' or 'cilazapril'
%       renalfunction is a string with acceptable values: 'normal' or
%           'impaired'
%       pill_mg is a floating point number for the dosage size in units of 
%           milligrams. Typical values are between 0 and 20.
%       num_doses_per_day is an integer between 0 and 24 for the number of
%           doses administered orally per day
%       tfinal_dosing is a floating point number for the time in hours 
%           after which no more doses are allowed to be administered. Any
%           value greater than zero is allowable. Typical values are 24 for 
%           one day and 24*7 for one week of treatment.
%       sim_time_end is a floating point number for the time in hours at
%           which the simulation concludes. Any value greater than zero is
%           allowable. The typical value is 24*7 for one week of
%           simulation, even if the drug is only administered over a one
%           day period.
%   optional properties for displaying the output plots
%       plot_mode is a string with accetable values: 'show_plots' or
%           'pub_plots'
%       layer_plots is  string with acceptable values: 'yes' or 'no'
%       linestylestring is a string that denotes the MATLAB symbols for the
%           selected line style. E.g., '-' as the default
% Output:
%   Figures are produced by this simulation with the required parameters
%       provided. The default options of plot_mode = 'show_plots' simply 
%       creates all the plots. The alternative option of 'pub_plots' saves 
%       publication quality images from those plots. The default option of
%       layer_plots = 'yes' will hold on and layer curves from subsequent
%       simulations as in the GUI if the figure window remains open between 
%       simulations. The plots can be reset by closing the figure window
%       after asimulation. Alternatively, layer_plots may be set to 'no' to
%       prevent hold on from being activated. The linestylestring may be
%       used to vary the line styles between successive simulations.
%
function run_PKPD_without_GUI(varargin)
%run_PKPD_without_GUI(drugname,renalfunction,pill_mg,num_doses_per_day,tfinal_dosing,sim_time_end)
if nargin==0
    pill_mg = 5; %5 is nominal dose for benazepril and 1.25 for cilazapril
    num_doses_per_day = 1;
  % drugname = 'cilazapril';
    drugname = 'benazepril';
  renalfunction = 'normal';
  %renalfunction = 'impaired';    
    tfinal_dosing = 24*7;
    sim_time_end = 24*7;
else
    drugname = varargin{1}; %'benazepril' or 'cilazapril'
    renalfunction = varargin{2};
    pill_mg = varargin{3};
    num_doses_per_day = varargin{4};
    tfinal_dosing = varargin{5};
    sim_time_end = varargin{6};
end

% The last three arguments are optional
if nargin < 7
    plot_mode = 'show_plots';
else
    plot_mode = varargin{7};
end
if nargin < 8
    layer_plots = 'yes'; %change to 'yes' to layer plots as in GUI. change to 'no' to turn this feature off
else
    layer_plots = varargin{8};
end
if nargin<9
    linestylestring = '-';
else
    linestylestring = varargin{9};
end
% ng, drug dose
drugdose=(pill_mg)*1e6; 
% hours, dosage interval with t = time after nth dose
tau = 24/num_doses_per_day; 

% set simulation coefficients from parameter estimation cases
paramsfile = strcat('params_',drugname,renalfunction,'.mat');
params = matfile(paramsfile);
% Km = params.Km;
% Vmax = params.Vmax;
VmaxoverKm = params.VmaxoverKm;
k_cat_Renin = params.k_cat_Renin;
k_feedback =  params.k_feedback;
feedback_capacity = params.feedback_capacity;
k_cons_AngII = params.k_cons_AngII;
coefficients = zeros(1,5);
coefficients(1) = VmaxoverKm;
coefficients(2) = k_cat_Renin;
coefficients(3) = k_feedback;
coefficients(4) = feedback_capacity;
coefficients(5) = k_cons_AngII;

% edit call_PKPD_model_scalar to modify plots
% run it to call PKPD_ACE_Inhibition_AngII.m for one value of tfinal_dosing
% and create plots
call_PKPD_model_scalar(coefficients,tfinal_dosing,sim_time_end,plot_mode,...
    layer_plots,drugdose,tau,drugname,renalfunction,linestylestring);
