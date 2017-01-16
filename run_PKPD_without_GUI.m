%% Run PK/PD model for ACE inhibition without GUI to produce plots of all output
function run_PKPD_without_GUI(varargin)
%run_PKPD_without_GUI(drugname,renalfunction,pill_mg,num_doses_per_day,tfinal_dosing,sim_time_end)
% input parameters
% chose plot_mode = 'show_plots' to use fitted parameters to plot images 
% chose plot_mode = 'pub_plots' to use fitted parameters to plot and save 
% publication quality images
if nargin==0
    pill_mg = 5; %5 is nominal dose for benazepril and 1.25 for cilazapril
    num_doses_per_day = 1;
  % drugname = 'cilazapril';
    drugname = 'benazepril';
  renalfunction = 'normal';
  %renalfunction = 'impaired';    
    tfinal_dosing = 24*7;
    sim_time_end = 24*7;
    plot_mode = 'show_plots';
    layer_plots = 'yes'; %change to 'yes' to layer plots as in GUI. change to 'no' to turn this feature off
    linestylestring = '-';
else
    drugname = varargin{1}; %'benazepril' or 'cilazapril'
    renalfunction = varargin{2};
    pill_mg = varargin{3};
    num_doses_per_day = varargin{4};
    tfinal_dosing = varargin{5};
    sim_time_end = varargin{6};
    plot_mode = varargin{7};
    layer_plots = varargin{8};
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
