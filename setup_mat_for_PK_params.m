%% Setup PK parameters for PK-PD model of ACE inhibitor dose impact on Ang II plasma concentration
% Take advantage of MATLAB's matfiles for accessing and changing variables
% directly in MAT-files without loading into memory. This should reduce
% read-write latency and prevent repetitive execution of code to generate
% the variables for each simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intended use:
%   Run once for each combination of drugname and renalfunction to generate
%   corresponding .mat file of data for the model. This function only needs 
%   to be run again if data needs to be modified or if a new drug is added.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To add a new drug:
%   Add PK parameters and new 
%       elseif strcmp(drugname,'newdrug')
%   filling in the data in the two existing cases. 
%   Impaired renal function may be skipped by not including 
%       if/else strcmp(renalfunction,'normal')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Input:
%   drugname string 'benazepril' or 'cilazapril'
%   renalfunction string 'normal' or 'impaired'
% Output:
%   generates MATFILE by
%       save(strcat('PK_params_'drugname,renalfunction,'.mat'))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Data sources for ACE inhibitor drugs:
%    H. Shionoiri, S. Ueda, K. Minamisawa, Pharmacokinetics and 
%    Pharmacodynamics of Benazepril in Hypertensive Patients with Normal 
%    and Impaired Renal-Function, Journal of Cardiovascular Pharmacology 
%    20 (3) (1992) 348ñ57.
% 
%    H. Shionoiri, E. Gotoh, N. Takagi, Antihypertensive Effects and 
%    Pharmacokinetics of Single and Consecutive Doses of Cilazapril in 
%    Hypertensive Patients with Normal and Impaired Renal-Function, 
%    Journal of Cardiovascular Pharmacology 11 (2) (1988) 242ñ9.
%
%    H.Shionoiri, G. Yasuda, A. Ikeda, T. Ohta, E. Miyajima, and
%    Y. Kaneko, Pharmacokinetics and depressor effect of delapril
%    in patients with essential hypertension, Clinical Pharmacology & 
%    Therapeutics 41 (1) (1987) 74ñ79.
%
%    M. Neubeck, D. Fliser, M. Pritsch, K. Weiﬂer, M. Fliser, J.
%    Nussberger, E. Ritz, E. Mutschler, Pharmacokinetics and
%    pharmacodynamics of lisinopril in advanced renal failure, European
%    Journal of Clinical Pharmacology 46 (6) (1994) 537-43.
%
%    A. Zanchi, J. Nussberger, M. Criscuoli, P. Capone, H. R. Brunner,
%    Angiotensin-Converting Enzyme Inhibitionn by Hydroxamic Zinc-Binding
%    Idrapril in Humans, Journal of Cardiovascular Pharmacology 24 (2)
%    (1994) 317-22
%
%    ER. Debusmann, J. Ocon-Pujadas, W. Lahn, et al, Influence of renal
%    function on the pharmacokinetics of ramipril (HOE 498), American Journal Cardiology  59 (1987) D70-D78.
%    
%    J. Ocon-Pujadas, E. R. Debusmann, F. Jane, W. Lahn, R. Irmisch, J.
%    Mora, and H. Grotsch, Pharmacodynamic effects of a single 10-mg dose
%    of the angiotensin converting enzyme-inhibitor ramipril in patients
%    with impaired renal-function, Journal of Cardiovascular Pharmacology
%    13 (3) (1989) S45-S48.
%    
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function setup_mat_for_PK_params(drugname,renalfunction)
format long e
paramsfile = strcat('params_',drugname,renalfunction,'.mat');    
params = matfile(paramsfile);
%% PK-PD parameters not specific to any drug
drug_conc_t0 = 0; % ng/ml, drug concentration at t0
diacid_conc_t0 = 0; %ng/ml, drug concentration at t0
Mw_AngI = 1.3e3; % ng/nmol % Mw refs: see Claasen
Mw_AngII = 1.05e3; % ng/nmol
Mw_Renin = 48000; % ng/nmol 
k_degr_Renin = log(2)/0.25;%hr^-1 half life of Renin degradation is 15 mins or 0.25 hr, Oates:1974
k_degr_AngI = log(2)/(.5/60);%hr^-1 half life of ANGI and ANGII degradation is 0.5 mins or 0.5/60 hr Schalekamp:1989
AngIIvaluet0 = params.AngIIvalue(1,1);
PRAvaluet0 = params.PRAvalue(1,1);
if strcmp(drugname,'delapril')
    AngI_conc_t0 = 7.91e-6; % nmol/ml = micromol/L, from Claasen 2013
elseif strcmp (drugname, 'ramipril')
    AngI_conc_t0 = 7.91e-6; % nmol/ml = micromol/L, from Claasen 2013
else
    AngIvaluet0 = params.AngIvalue(1,1);
    AngI_conc_t0 = AngIvaluet0/1000/Mw_AngI; % nmol/ml, Ang I concentration at t0, from Shionoiri Benazepril fig. 8
end
    AngII_conc_t0 = AngIIvaluet0/1000/Mw_AngII; % nmol/ml, Ang II concentration at t0, from Shionoiri Benazepril fig. 8
PRA_t0 = PRAvaluet0;
if strcmp(drugname,'benazepril')
    Reninvaluet0 = params.Reninvalue(1,1);
    Renin_conc_t0 = Reninvaluet0/1000/Mw_Renin; % nmol/ml, Plasma Active Renin Concentration (ARC) at t0, from Shionoiri Benazepril fig. 7
end
%% Pharmacokinetic parameters specific to drug & kidney (renal) function combinations
% all data used for single dosing NOT consecutive
if strcmp(drugname,'benazepril')
    nominal_dose = 5e6; %ng, dose at which PK values measured
    n_Hill = 0.99; % 1.075388;
    C50 = 2.2; % 4.691571;
    if strcmp(renalfunction,'normal') % normal renal function
        % drug
        AUC_drug = 131.4; % ng h/ml, area under curve
        tmax_drug = 0.6; % h
        thalf_drug = 0.4; % h
        ka_guess_drug = 1.6; % h^-1
        % diacid
        AUC_diacid = 528.6; % ng h/ml, area under curve
        tmax_diacid = 1.5; % h
        thalf_diacid = 5.2; % h
        ka_guess_diacid = 2.2; % h^-1
    else % impaired renal function
        % drug
        AUC_drug = 198.2; % ng h/ml, area under curve
        tmax_drug = 0.7; % h
        thalf_drug = 0.8; % h
        ka_guess_drug = 1.9; % h^-1
        % diacid
        AUC_diacid = 1358; % ng h/ml, area under curve
        tmax_diacid = 2.4; % h
        thalf_diacid = 20.1; % h
        ka_guess_diacid = 1.6; % h^-1
    end
%% Cilazapril data
elseif strcmp(drugname,'cilazapril')% 
    nominal_dose = 1.25e6; %ng, dose at which PK values measured
    n_Hill = 1.19;
    C50 = 3.61;
    if strcmp(renalfunction,'normal') % normal renal function
        % drug
        AUC_drug = 408.4; % ng h/ml, area under curve
        tmax_drug = 1.8; % h
        thalf_drug = 2.9; % h
        ka_guess_drug = 1.1; % h^-1
        % diacid
        AUC_diacid = 226.8; % ng h/ml, area under curve
        tmax_diacid = 3.2; % h
        thalf_diacid = 8.4; % h
        ka_guess_diacid = 0.79; % h^-1
    else % impaired renal function
        % diacid
        AUC_diacid = 583.4; % ng h/ml, area under curve
        tmax_diacid = 4.3; % h
        thalf_diacid = 7.3; % h
        ka_guess_diacid = 0.46; % h^-1
        % drug
        AUC_drug = 704; % ng h/ml, area under curve
        tmax_drug = 1.1; % h
        thalf_drug = 3.0; % h
        ka_guess_drug = 2.3; % h^-1
    end
    Renin_conc_t0 = (PRA_t0-.696)/0.045/1000/Mw_Renin; % from linear fit to Ben NRF data

%% Delapril Data
elseif strcmp(drugname,'delapril')% 
    nominal_dose = 30e6; %ng, dose at which PK values measured
    n_Hill = .78; %guess
    C50 = 1.12; % check and see, guess
    if strcmp(renalfunction,'normal') % normal renal function
        % drug
        AUC_drug = 572; % ng h/ml, area under curve
        tmax_drug = 1.1; % h
        thalf_drug = .30; % h
        ka_guess_drug = .2358; % h^-1 %Cilaxapril Data
        % diacid
        AUC_diacid = 1859; % ng h/ml, area under curve
        tmax_diacid = 1.2; % h
        thalf_diacid = 1.21; % h
        ka_guess_diacid = 1.16; % h^-1 %Cilazapril Data
        % 5-Hydroxyl Delapril Diacid
        AUC_hydroxyl = 948; % ng h/ml, area under curve
        tmax_hydroxyl = 1.9; % h
        thalf_hydroxyl = 1.40; % h
  
    end
    Renin_conc_t0 = (PRA_t0-.696)/0.045/1000/Mw_Renin; % from linear fit to Ben NRF data
%% Lisinopril Data
elseif strcmp(drugname,'lisinopril')% 
    nominal_dose = 1.25e6; %ng, dose at which PK values measured
    if strcmp(renalfunction,'normal') % normal renal function
        n_Hill = 2.27;
        C50 = 33.47; 
        nominal_dose = 1e7; %ng, dose at which PK values measured
        % drug
        AUC_drug = 347; % ng h/ml, area under curve
        tmax_drug = 6.7; % h
        thalf_drug = 11.95; % h
        ka_guess_drug = 1.1; % h^-1
        % diacid % Lisinopril does not convert to a diacid
        AUC_diacid = 347; % ng h/ml, area under curve
        tmax_diacid = 6.7; % h
        thalf_diacid = 11.95; % h
        ka_guess_diacid = 0.79; % h^-1
    else % impaired renal function
        n_Hill = 1.85;
        C50 = 31.03;
        nominal_dose = 1.5e6; %ng, dose at which PK values measured
        % diacid %lisinopril does not convert into a diacid 
        AUC_diacid = 75; % ng h/ml, area under curve
        tmax_diacid = 12.1; % h
        thalf_diacid = 115.52; % h
        ka_guess_diacid = 0.46; % h^-1
        % drug
        AUC_drug = 75; % ng h/ml, area under curve
        tmax_drug = 12.1; % h
        thalf_drug = 115.52; % h
        ka_guess_drug = 2.3; % h^-1
    end
    Renin_conc_t0 = (PRA_t0-.696)/0.045/1000/Mw_Renin; % from linear fit to Ben NRF data
%% Idrapril Data
elseif strcmp(drugname,'idrapril')% 
    nominal_dose = 1e8; %ng, dose at which PK values measured
    n_Hill = 1.12;
    C50 = 13.13;
    if strcmp(renalfunction,'normal') % normal renal function
        % drug
        AUC_drug = 2516.667; % ng h/ml, area under curve
        tmax_drug = 1; % h
        thalf_drug = 91/60; % h
        ka_guess_drug = 2; % h^-1
        % diacid % Idrapril does not convert to a diacid
        AUC_diacid = 2516.667; % ng h/ml, area under curve
        tmax_diacid = 1; % h
        thalf_diacid = 91/60; % h
        ka_guess_diacid = 2; % h^-1
    end
    Renin_conc_t0 = (PRA_t0-.696)/0.045/1000/Mw_Renin; % from linear fit to Ben NRF data
%% Ramipril Data
elseif strcmp(drugname,'ramipril')% 
    nominal_dose = 1e8; %ng, dose at which PK values measured
    n_Hill = 1.56;
    C50 = .99;
    if strcmp(renalfunction,'impaired') % normal renal function
        % drug
        AUC_drug = 267.375; % ng h/ml, area under curve
        tmax_drug = 1.125; % h
        thalf_drug = 2.025; % h
        ka_guess_drug = 1.1; % h^-1
        % diacid 
        AUC_diacid = 660.8; % ng h/ml, area under curve
        tmax_diacid = 3.95; % h
        thalf_diacid = 8.4; % h
        ka_guess_diacid = 0.79; % h^-1
  
    end
    Renin_conc_t0 = (PRA_t0-.696)/0.045/1000/Mw_Renin; % from linear fit to Ben NRF data
end
%% PK-PD calculated quantities dependendent on drug parameters
[ke_diacid,VF_diacid,ka_diacid] = PKparams(thalf_diacid,nominal_dose,AUC_diacid,tmax_diacid,ka_guess_diacid);
[ke_drug,VF_drug,ka_drug] = PKparams(thalf_drug,nominal_dose,AUC_drug,tmax_drug,ka_guess_drug);

AngI_conc_t0 = AngI_conc_t0*10^6;% from nmol/ml = micro M to pM
AngII_conc_t0 = AngII_conc_t0*10^6;% from nmol/ml = micro M to pM
Renin_conc_t0 = Renin_conc_t0*10^6;% from nmol/ml = micro M to pM

save(strcat('PK_params_',drugname,renalfunction,'.mat'),'-v7.3')

end

%% Calculate pharmacokinetic parameters
function [ke,VF,ka] = PKparams(thalf,nominal_dose,AUC,tmax,ka_guess)
    ke = log(2)/thalf; % hr^-1, elimination constant, ke=ln(2)/half life
    VF = nominal_dose/AUC/ke; % ml, V/F=D/AUC/ke
    ka = fzero(@(ka) root_ka(ka,ke,tmax),ka_guess); % hr^-1, absorption constant, tmax=ln(ka/ke)/(ka-ke) use fzero to find root for ka
end

%% Use fzero to find root for ka
% tmax=ln(ka/ke)/(ka-ke) 
function r = root_ka(ka,ke,tmax)
    r = log(ka/ke)/(ka-ke)-tmax;
end