%% Call the PK-PD model for parameter estimation with vector tfinal_dosing input and output of Ycalc subset of PKPD results at each tfinal_dosing value
% Input: 
%   coefficients are adjustable model parameters, estimated from data
%   tfinal_dosing is final time for the simulation; a vector is used for parameter
%   estimation & scalar used for evaluating Ycalc with known coefficients 
% Output:
%   output is a matrix of the three calculated vectors at each input tfinal_dosing 
%   used for parameter estimation: AngII_conc, AngI_conc, and PRA
% Parameters:
%   Run-specific parameters that aren't likely to change for each 
%   simulation should be set in run_params.m to create the .mat file. 
%   These parameters are those that are adjustable in the GUI. 
function output = call_PKPD_model_vector_param_est(varargin)
coefficients = varargin{1};
tfinal_dosing = varargin{2};
sigma = varargin{3};
noAngIdata = varargin{4};
format long e
run_params = matfile('run_params.mat');
PK_paramsfile = strcat('PK_params_',run_params.drugname,run_params.renalfunction,'.mat');
PK_params = matfile(PK_paramsfile);
ka_drug=PK_params.ka_drug;
VF_drug=PK_params.VF_drug;
ke_drug=PK_params.ke_drug;
ke_diacid=PK_params.ke_diacid;
VF_diacid = PK_params.VF_diacid;
ka_diacid = PK_params.ka_diacid; 
C50 = PK_params.C50;
n_Hill = PK_params.n_Hill; 
k_degr_Renin = PK_params.k_degr_Renin;
k_degr_AngI =PK_params.k_degr_AngI; 
diacid_conc_t0= PK_params.diacid_conc_t0;
drug_conc_t0 = PK_params.drug_conc_t0;
Mw_AngI = PK_params.Mw_AngI;   
Mw_AngII = PK_params.Mw_AngII;
Mw_Renin = PK_params.Mw_Renin;

if nargin>4
    validation = varargin{5};
    drugdose = validation.drugdose;
    AngI_conc_t0 = validation.AngI(1)./1000./Mw_AngI*10^6;  %% CE AngI Value
    AngII_conc_t0 = validation.AngII(1)./1000./Mw_AngII*10^6;
    PRA_t0 = validation.PRA(1);
    Renin_conc_t0 = (PRA_t0-.696)/0.045/1000/Mw_Renin*10^6;
%     AngI_conc_t0 = validation.AngI(1);
%     AngII_conc_t0 = validation.AngII(1);
%     Renin_conc_t0 = validation.Renin(1)/1000/Mw_Renin;%convert to nmol/mL
%     PRA_t0 = validation.PRA(1);
else
    drugdose = run_params.drugdose;
    AngI_conc_t0 = PK_params.AngI_conc_t0;  %% CE AngI Value
    AngII_conc_t0 = PK_params.AngII_conc_t0;
    Renin_conc_t0 = PK_params.Renin_conc_t0;
    PRA_t0 = 0.696+0.045.*Renin_conc_t0*1000*Mw_Renin/10^6;
end %% CE AngI Value
drugoutput = PKPD_ACE_Inhibition_AngII(coefficients,...
    drugdose,run_params.tau,tfinal_dosing,ka_drug,VF_drug,...
    ke_drug,ke_diacid,VF_diacid,ka_diacid,C50,n_Hill,AngI_conc_t0,...
    AngII_conc_t0,Renin_conc_t0,diacid_conc_t0,drug_conc_t0,...
    k_degr_Renin,k_degr_AngI,Mw_AngI,Mw_AngII, Mw_Renin,tfinal_dosing);
AngII_conc = drugoutput(:,3)';
AngI_conc = drugoutput(:,4)';    
Renin_conc = drugoutput(:,6)';

PRA_end = 0.696+0.045.*Renin_conc; % linear fit to ben NRF data
AngII_conc_out = AngII_conc./sigma(1,:);
if  noAngIdata == 0
    PRA_out = PRA_end./sigma(3,:);
    AngI_conc_out = AngI_conc./sigma(2,:);
    output = [AngII_conc_out; AngI_conc_out; PRA_out];%Renin_conc_out'];
else
    PRA_out = PRA_end./sigma(2,:);
    % AngI_conc_out = AngI_conc./sigma(2,:); %% CE AngI Value
    output = [AngII_conc_out; PRA_out];
end


