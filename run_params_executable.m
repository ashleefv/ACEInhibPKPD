%% Run Specific Parameters
% Edit this file to make changes to parameters that can change run-to-run
% This file is the analog to using the GUI to adjust a limited number of
% parameters
function run_params_executable
    pill_mg = 1.25;%5 for benazepril and 1.25 for cilazapril
    drugdose=(pill_mg)*1e6; % ng, drug dose
    num_doses_per_day = 1;
drugname = 'cilazapril';
%  drugname = 'benazepril';
%  renalfunction = 'normal';
renalfunction = 'impaired';    
    tau = 24/num_doses_per_day; % hours, dosage interval with t = time after nth dose 
save('run_params.mat','-v7.3')    
    