%% Setup data & estimated parameters for PK-PD model of ACE inhibitor dose impact on Ang II plasma concentration
% Take advantage of MATLAB's matfiles for accessing and changing variables
% directly in MAT-files without loading into memory. This should reduce
% read-write latency and prevent repetitive execution of code to generate
% the variables for each simulation
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Intended use:
%   Run once for each combination of drugname and renalfunction to generate
%   corresponding .mat file of data for the model. This function only needs 
%   to be run again if parameter estimation needs to be modified
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% To add a new drug:
%   Add PK data and new 
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
%       save(strcat('params_',drugname,renalfunction,'.mat'))
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
%    function on the pharmacokinetics of ramipril (HOE 498), American
%    
%    J. Ocon-Pujadas, E. R. Debusmann, F. Jane, W. Lahn, R. Irmisch, J.
%    Mora, and H. Grotsch, Pharmacodynamic effects of a single 10-mg dose
%    of the angiotensin converting enzyme-inhibitor ramipril in patients
%    with impaired renal-function, Journal of Cardiovascular Pharmacology
%    13 (3) (1989) S45-8Journal Cardiology  59 (1987) 70-8D.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function setup_mat_for_data_estimated_params(drugname,renalfunction)
% Best fit parameters determined by multistart with at least 100 random
% starting points and PKPD model ODE AbsTol = RelTol = 1e-12. Weighted
% least squares by sigma. Cilazapril errors: mean(ratioAngI).*mean(AngIvalue)
%
% Digitized data stored in Shionoiri-Plot-Digitizer Benazepril Cilazapril
% Data.xlsx
format long e
if strcmp(drugname,'benazepril')
    Xdata = [0, 2, 4, 8, 24];
    if strcmp(renalfunction,'normal') % normal renal function
        % Benazepril Single Dose NRF
        AngIvalue = [480.237, 640.836, 617.99, 601.573, 517.555];% pg/mL
        AngIerror = [91.495,102.442,91.465,102.442,84.177];
        AngIIvalue = [17.351, 11.891, 8.9199, 8.5659, 14.497];% pg/mL
        AngIIerror = [1.0887, 0.6653, 0.60483, 0.60483, 0.8468];
        Reninvalue = [9.877852, 15.149642, 22.539648,22.480429,12.003228];
        Reninerror = [4.32419,7.21423,7.2115,7.9327,6.49041];
        PRAvalue = [1.15921,1.42918,1.9766,1.46433,1.04941]; %ng/ml/h
        PRAerror = [0.6655348, 0.65170184, 0.7604859, 0.6789919, 0.5022961];
        % Benazepril normal renal function best fit parameters for PRA 
        % instead of Renin
%% 'estimate' with  TolX TolFun = 1e-12
%     VmaxoverKm = 1.444773664694845e-02;
%     k_cat_Renin = 6.646687821956104e+04;
%     k_feedback = 6.103119831356866e-02 ;
%     feedback_capacity =  2.500000005873727e+02;
%     k_cons_AngII =   6.116831328288424e-01;
% resnorm =
%      1.075997943013592e+04
% resnorm_weighted =
%      1.085783919139972e+01
% RMSE =
%      1.046701257798167e+00     4.637703783630433e+01     2.658270755666271e-01
%% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart
%     VmaxoverKm = 1.445e-02;
%     k_cat_Renin = 6.647e+04;
%     k_feedback = 6.103e-02;
%     feedback_capacity = 2.5e+02;
%     k_cons_AngII = 6.117e-01;
% resnorm =
%      1.076426960191294e+04
% resnorm_weighted =
%       1.085784815863251e+01
% RMSE =
%      1.046805210610612e+00     4.638628526069432e+01     2.658175071730364e-01
%% coef_median from confidence_intevals after multistart topResults = 75
% coef_median =
%   Columns 1 through 4
%      1.440000000000000e-02     6.440000000000000e+04     6.250000000000000e-02     3.970000000000000e+02
%   Column 5
%      6.110000000000000e-01
% coef_min =
%   Columns 1 through 4
%      1.420000000000000e-02     4.700000000000000e+04     4.300000000000000e-02     2.500000000000000e+02
%   Column 5
%      6.010000000000000e-01
% coef_max =
%   Columns 1 through 4
%      1.470000000000000e-02     9.440000000000000e+04     8.200000000000000e-02     2.460000000000000e+03
%   Column 5
%      6.230000000000000e-01
% error_median =
%      1.087118529904956e+01
% error_fitted(index(best),1) =
%     1.085781627680420e+01
%% final values: coef_median
    VmaxoverKm = 1.44e-02;
    k_cat_Renin = 6.44e+04;
    k_feedback = 6.25e-02;
    feedback_capacity = 3.97e+02;
    k_cons_AngII = 6.11e-01;
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%       1.079671334966387e+04
% resnorm_weighted =
%      1.087118529904956e+01
% RMSE =
%       1.045017913634304e+00     4.645622872165681e+01     2.634776158719798e-01
    else % impaired renal function
        % Benazepril Single Dose IRF
        AngIvalue = [571.815, 548.969, 562.82, 542.733, 543.161];% pg/mL
        AngIerror = [73.201, 106.1, 91.495, 95.125, 80.461];
        AngIIvalue = [21.4813, 15.0492, 11.3498, 9.90264, 16.1371];% pg/mL
        AngIIerror = [0.9072, 0.5446, 0.6048, 0.54412, 0.6653];
        PRAvalue = [1.57412, 1.98188, 1.94736, 1.79558, 1.76852];
        PRAerror = [0.3803056, 0.4347603, 0.4753819, 0.5299619, 0.4211779];
        Reninvalue = [15.52643, 28.218811, 27.128792, 24.241379, 26.13183];
        Reninerror = [5.7692, 6.4904, 7.2116, 5.7719, 10.0989];
        % Benazepril impaired renal function best fit parameters for PRA 
        % instead of Renin
%% 'estimate' with  TolX TolFun = 1e-12      
% resnorm =
%      2.308280868169460e+03
% resnorm_weighted =
%     5.360389179948916e+01
% RMSE =
%      2.034344177188889e+00     2.138906977744936e+01     1.590957511443158e-01
%     VmaxoverKm = 1.533037659031592e-02;
%     k_cat_Renin = 2.691360026796050e-01;
%     k_feedback = 7.663296557348501e-02;
%     feedback_capacity = 2.500000000000086e+02;
%     k_cons_AngII = 6.999089226551134e-01;      
     %% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart (10 mins)
% resnorm =
%      2.308280184530884e+03
% resnorm_weighted =
%       5.360389211313486e+01
% RMSE =
%      2.034333373009617e+00     2.138906760767243e+01     1.590959083512215e-01
%     VmaxoverKm = 1.533e-02;
%     k_cat_Renin = 2.691e-01;
%     k_feedback = 7.663e-02;
%     feedback_capacity = 2.5e+02;
%     k_cons_AngII = 6.999e-01;  
%% coef_median from confidence_intevals after multistart topResults =93
% coef_median =
%   Columns 1 through 4
%      1.530000000000000e-02     1.270000000000000e+00     7.660000000000000e-02     2.500000000000000e+02
%   Column 5
%      7.000000000000000e-01
% coef_min =
%   Columns 1 through 4
%      1.520000000000000e-02     1.130000000000000e-10     7.500000000000000e-02     2.500000000000000e+02
%   Column 5
%      6.940000000000000e-01
% coef_max =
%   Columns 1 through 4
%      1.560000000000000e-02     2.320000000000000e+02     7.750000000000000e-02     9.720000000000000e+02
%   Column 5
%      7.140000000000000e-01
% error_median =
%      5.360782261064551e+01
% error_fitted(index(best),1) =
%      5.360388268541242e+01
%% final values: coef_median
    VmaxoverKm = 1.530e-02;
    k_cat_Renin = 1.27e+00;
    k_feedback = 7.66e-02;
    feedback_capacity = 2.5e+02;
    k_cons_AngII = 7.0e-01;  
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%      2.308812317117025e+03
% resnorm_weighted =
%      5.360782261064551e+01
% RMSE =
%      2.032395387911439e+00     2.139173980758745e+01     1.590610419927256e-01
    end
%% Cilazapril data
elseif strcmp(drugname,'cilazapril')% 
    ben = matfile(strcat('params_benazepril',renalfunction,'.mat'));
    Xdata = [0, 2, 4, 12, 24];
    benAngIIerror=ben.AngIIerror;
    benAngIerror=ben.AngIerror;
    benPRAerror=ben.PRAerror;
    benAngIIvalue=ben.AngIIvalue;
    benAngIvalue=ben.AngIvalue;
    benPRAvalue=ben.PRAvalue;
    ratioAngII = benAngIIerror./benAngIIvalue;
    ratioAngI = benAngIerror./benAngIvalue;
    ratioPRA = benPRAerror./benPRAvalue;
    if strcmp(renalfunction,'normal') % normal renal function
        % Cilazapril Single Dose NRF
        AngIvalue = [29.545, 161.364, 63.636, 38.636, 61.364];% pg/mL
        AngIIvalue = [11.778, 5.111, 4.667, 4.889, 11.556];% pg/mL
        PRAvalue = [1.387, 4.473, 2.746, 1.785, 1.954];
        
        % Cilazapril normal renal function best fit parameters for PRA 
        % instead of Renin
%% 'estimate' with  TolX TolFun = 1e-12
% resnorm =
%      1.037968319890554e+04
% resnorm_weighted =
%      1.112235726173563e+02
% RMSE =
%      1.229072603159143e+00     4.553455791379736e+01     1.014916702151540e+00
%     VmaxoverKm = 8.560902163752947e+01;
%     k_cat_Renin = 7.548141327017796e+02;
%     k_feedback = 5.249241478337204e-01;
%     feedback_capacity = 6.180320565691274e+03;
%     k_cons_AngII = 1.838411675788261e+02;
%% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart
% resnorm =
%      1.037931760210031e+04
% resnorm_weighted =
%      1.112197600646295e+02
% RMSE =
%     1.229021175745292e+00     4.553375170454945e+01     1.015127124093917e+00
%     VmaxoverKm = 8.561e+01;
%     k_cat_Renin = 7.548e+02;
%     k_feedback = 5.249e-01;
%     feedback_capacity = 6.180e+03;
%     k_cons_AngII = 1.838e+02;
%% coef_median from confidence_intevals after multistart topResults =7
% coef_median =
%   Columns 1 through 4
%      1.750000000000000e+02     2.540000000000000e+03     3.380000000000000e-01     2.790000000000000e+04
%   Column 5
%      2.650000000000000e+02
% coef_min =
%   Columns 1 through 4
%      1.540000000000000e+02     6.430000000000000e+02     2.350000000000000e-01     2.720000000000000e+03
%   Column 5
%      2.210000000000000e+02
% coef_max =
%   Columns 1 through 4
%      4.550000000000000e+02     4.060000000000000e+03     4.180000000000000e-01     5.720000000000000e+04
%   Column 5
%      6.300000000000000e+02
% error_median =
%      8.723493831530374e+01
% error_fitted(index(best),1) =
%      8.664525844043152e+01
%% final values: coef_median
    VmaxoverKm = 1.75e+02;
    k_cat_Renin = 2.54e+03;
    k_feedback = 3.38e-01;
    feedback_capacity = 2.79e+04;
    k_cons_AngII = 2.65e+02;
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%      7.240870280113037e+03
% resnorm_weighted =
%      8.723493831530374e+01
% RMSE =
%      1.235095092739609e+00     3.802750913857528e+01     7.464213622822803e-01
    else % impaired renal function
        % Cilazapril Single Dose IRF
        AngIvalue = [227.273, 352.273, 418.182, 286.364, 231.818];% pg/mL
        AngIIvalue = [30.444, 7.111, 4.667, 5.111, 9.778];% pg/mL
        PRAvalue = [4.500, 7.303, 8.122, 8.009, 5.350];   
        % Cilazapril impaired renal function best fit parameters for PRA 
        % instead of Renin
%% 'estimate' with  TolX TolFun = 1e-12
% resnorm =
%      3.182123641346346e+04
% resnorm_weighted =
%      2.288727106839739e+01
% RMSE =
%      6.822736075865357e-01     7.976983839568960e+01     7.447601913684778e-01
%     VmaxoverKm =  1.954267202240330e-01;
%     k_cat_Renin = 1.804656793110626e+03 ;
%     k_feedback = 1.616194471801753e-01  ;
%     feedback_capacity = 8.334166443840887e+04;
%     k_cons_AngII =   1.238009355301998e+00; 
%% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart
% resnorm =
%      3.182235155923784e+04
% resnorm_weighted =
%       2.288741036342448e+01
% RMSE =
%      6.822602595810399e-01     7.977123641805612e+01     7.447638017274246e-01
%     VmaxoverKm =  1.954e-01;
%     k_cat_Renin = 1.805e+03 ;
%     k_feedback = 1.616e-01  ;
%     feedback_capacity = 8.334e+04;
%     k_cons_AngII =   1.238e+00; 
%% coef_median from confidence_intevals after multistart
% coef_median =
%   Columns 1 through 4
%      1.950000000000000e-01     1.810000000000000e+03     1.620000000000000e-01     5.180000000000000e+05
%   Column 5
%      1.240000000000000e+00
% coef_min =
%   Columns 1 through 4
%      1.950000000000000e-01     1.330000000000000e+03     1.610000000000000e-01     3.070000000000000e+04
%   Column 5
%      1.240000000000000e+00
% coef_max =
%   Columns 1 through 4
%     1.970000000000000e-01     1.810000000000000e+03     1.700000000000000e-01     3.610000000000000e+06
%   Column 5
%      1.260000000000000e+00
% error_median =
%      2.300215459520012e+01
% error_fitted(index(best),1) =
%      2.288651674552262e+01
%% final values: coef_median
    VmaxoverKm = 1.95e-01;
    k_cat_Renin = 1.81e+03;
    k_feedback = 1.62e-01;
    feedback_capacity = 5.18e+05;
    k_cons_AngII = 1.24e+00; 
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%      5.518446290517842e+04
% resnorm_weighted =
%      1.496704137519168e+01
% RMSE =
%      4.181061777379366e-01     1.050525251068969e+02     8.274883229545573e-01
    end
    % mean weighting
    AngIerror = mean(ratioAngI).*mean(AngIvalue).*ones(size(AngIvalue));
    AngIIerror = mean(ratioAngII).*mean(AngIIvalue).*ones(size(AngIIvalue));
    PRAerror = mean(ratioPRA).*mean(PRAvalue).*ones(size(PRAvalue));
    % % of error from for each value in cil
%     AngIerror = ones(size(AngIvalue));%max(ratioAngI).*AngIvalue
%     AngIIerror = ones(size(AngIvalue));%max(ratioAngII).*AngIIvalue
%     PRAerror = ones(size(AngIvalue));%max(ratioPRA).*PRAvalue

%% Delapril Data
elseif strcmp(drugname,'delapril')
    Xdata = [0, 1, 2, 4, 6, 8, 24];
    if strcmp(renalfunction,'normal') % normal renal function
        % Delapril Single Dose NRF
        % No AngIvalue or error
        AngIIvalue = [23.9221, 14.48012, 13.76628, 10.974, 11.27235,12.11663,22.74005];% pg/mL
        AngIIerror = [4.078566, 3.540525, 3.173135, 2.243803, 2.0764, 2.464267,6.544924];
        % No renin values or error
        PRAvalue = [2.3340895, 9.406641, 13.64834, 12.53182, 9.384698, 5.560487, 4.611177]; %ng/ml/h
        PRAerror = [0.4275679, 3.38473, 3.401995, 2.8818915, 2.411716, 1.3792413, 1.0107642];
        
%% 'estimate' with  TolX TolFun = 1e-12
%       VmaxoverKm = 1.730025037826534e+00;
%       k_cat_Renin = 7.985807732054210e+00;
%       k_feedback =  2.716023701478610e-14;
%       feedback_capacity = 2.500000000027718e+02;
%       k_cons_AngII = 1.111916870111678e+00;
% resnorm =
%      3.786808357096718e+07
% resnorm_weighted =
%      4.041780536278870e+07
% RMSE =
%      7.176252613923212e-01     2.325881705813490e+03
%% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart
%       VmaxoverKm = 1.730e+00;
%       k_cat_Renin = 7.986e+00;
%       k_feedback =  2.716e-14;
%       feedback_capacity = 2.500e+02;
%       k_cons_AngII = 1.112e+00;
% resnorm =
%      3.990874100822210e+07
% resnorm_weighted =
%       1.355065195631136e+01
% RMSE =
%      2.015851985726136e+00     2.387727926670263e+03
%% coef_median from confidence_intevals after multistart topResults = 53
% coef_median =
%   Columns 1 through 4
%      1.020000000000000e+01     4.030000000000000e+01     2.860000000000000e-13     1.040000000000000e+03
%   Column 5
%      6.850000000000000e+00
% coef_min =
%   Columns 1 through 4
%      1.440000000000000e+00     1.780000000000000e+00     2.220000000000000e-14     2.500000000000000e+02
%   Column 5
%      9.590000000000000e-01
% coef_max =
%   Columns 1 through 4
%      1.640000000000000e+01     7.880000000000000e+01     1.520000000000000e-10     2.450000000000000e+03
%   Column 5
%      1.100000000000000e+01
% error_median =
%      4.041780651102664e+07
% error_fitted(index(best),1) =
%      4.041780536278892e+07
%% final values: coef_median
    VmaxoverKm = 1.02e+01;
    k_cat_Renin =  4.03e+01;
    k_feedback = 2.86e-13;
    feedback_capacity = 1.04e+03;
    k_cons_AngII = 6.85e+00;
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%       3.786809502622373e+07
% resnorm_weighted =
%      4.041780651102664e+07
% RMSE =
%       1.466782614516077e+00     2.325881705813490e+03
    end
    %% Lisinopril Data
elseif strcmp(drugname,'lisinopril')
    Xdata = [0, 8, 16];
    if strcmp(renalfunction,'normal') % normal renal function
        % lisinopril Single Dose NRF
        AngIvalue = [6.513, 46.41, 20.41];% pg/mL
        AngIerror = [.936, 9.984, 2.847];
        AngIIvalue = [2.772, 1.0185, .8715];% pg/mL
        AngIIerror = [.3885, .2205, .168];
        %No renin or error
        PRAvalue = [.53, 2.57, 1.08]; %ng/ml/h
        PRAerror = [.07, .62, .2];
        % Benazepril normal renal function best fit parameters for PRA 
        % instead of Renin
% %% 'estimate' with  TolX TolFun = 1e-8
% %    7.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-027.980000000000000e-02
% %resnorm =
% %      1.782882025328857e+03
% %resnorm_weighted =
% %      6.187487642104685e+01
% %RMSE =
% %    4.812370503253298e-01     2.436694842669941e+01     5.605744508248455e-01
%% 'estimate' with  TolX TolFun = 1e-8
%       VmaxoverKm = 7.775972258947957e-01;
%       k_cat_Renin = 1.955244422251964e-03;
%       k_feedback =  4.412413542140910e-01;
%       feedback_capacity = 2.800099267551874e+02;
%       k_cons_AngII = 1.603893738078590e-01; 
%resnorm =
%     1.786605653641818e+03
%resnorm_weighted =
%     4.618800511282578e+01
%RMSE =
%     5.808392821418741e-02     2.438757009313830e+01     8.821956076491260e-01
%% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart
%       VmaxoverKm = 7.776e-01;
%       k_cat_Renin = 1.955e-03;
%       k_feedback =  4.412e-01;
%       feedback_capacity = 2.800e+02;
%       k_cons_AngII = 1.604e-01; 
% resnorm =
%      1.786605841056659e+03
% resnorm_weighted =
%      4.618831071201885e+01
% RMSE =
%      5.810702313212390e-02     2.438757018588494e+01     8.822269292072031e-01
%% coef_median from confidence_intevals after multistart topResults = 2
% coef_median =
%   Columns 1 through 4
%      9.760000000000000e-01     6.690000000000000e-01     5.120000000000000e-01     1.070000000000000e+03
%   Column 5
%      2.100000000000000e-01
% coef_min =
%   Columns 1 through 4
%      9.760000000000000e-01     4.000000000000000e-01     5.090000000000000e-01     3.420000000000000e+02
%   Column 5
%      2.100000000000000e-01
% coef_max =
%   Columns 1 through 4
%      9.760000000000000e-01     9.379999999999999e-01     5.150000000000000e-01     1.800000000000000e+03
%   Column 5
%      2.110000000000000e-01
% error_median =
%     4.557561641776839e+01
% error_fitted(index(best),1) =
%     4.557267152147443e+01
%% final values: coef_median
    VmaxoverKm = 9.76e-01;
    k_cat_Renin = 6.69e-01;
    k_feedback = 5.12e-01;
    feedback_capacity = 1.07e+03;
    k_cons_AngII = 2.10e-01;
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%       1.785663971294828e+03
% resnorm_weighted =
%      4.557561641776839e+01
% RMSE =
%       5.923394835119426e-02     2.438408180281292e+01     7.964733128192335e-01
    else % impaired renal function
        % lisinopril Single Dose IRF
        AngIvalue = [14.3, 18.85, 12.623];% pg/mL
        AngIerror = [3.705, 4.238, 1.846];
        AngIIvalue = [1.7955, .5985, .672];% pg/mL
        AngIIerror = [.504, .0945, .168];
        PRAvalue = [1.5, 1.27, .85];
        PRAerror = [.3, .24, .15];
        %no renin or error
        % Benazepril impaired renal function best fit parameters for PRA 
        % instead of Renin
%% 'estimate' with  TolX TolFun = 1e-10      
% resnorm =
%      2.414868401865904e+01
% resnorm_weighted =
%     3.481263385950642e+01
% RMSE =
%      2.469038571895559e-01     2.798178808320367e+00     3.984911310490389e-01
%       VmaxoverKm = 1.326444177009483e+03;
%       k_cat_Renin = 9.797990301712355e+02;
%       k_feedback =  5.933909943689153e-04;
%       feedback_capacity = 3.039312499611492e+02;
%       k_cons_AngII = 4.328431504012415e-03;     
     %% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart (10 mins)
% resnorm =
%      2.414869687745638e+01
% resnorm_weighted =
%       3.481326678371445e+01
% RMSE =
%      2.469025714401707e-01     2.798179687713538e+00     3.984911307700471e-01
%       VmaxoverKm = 1.326e+03;
%       k_cat_Renin = 9.798e+02;
%       k_feedback =  5.934e-04;
%       feedback_capacity = 3.039e+02;
%       k_cons_AngII = 4.328e-03;  
%% coef_median from confidence_intevals after multistart topResults =93
% coef_median =
%   Columns 1 through 4
%      5.470000000000000e+03     3.030000000000000e+03     1.340000000000000e-07     1.760000000000000e+03
%   Column 5
%      7.980000000000000e-02
% coef_min =
%   Columns 1 through 4
%      3.930000000000000e+02     6.909999999999999e+01     2.220000000000000e-14     2.580000000000000e+02
%   Column 5
%      3.010000000000000e-08
% coef_max =
%   Columns 1 through 4
%      1.050000000000000e+04     5.860000000000000e+03     2.340000000000000e-04     3.540000000000000e+03
%   Column 5
%      8.590000000000000e-02
% error_median =
%      2.168808722146644e+01
% error_fitted(index(best),1) =
%      2.167635725041273e+01
%% final values: coef_median
    VmaxoverKm = 9.9e+03;
    k_cat_Renin = 4.43e+03;
    k_feedback = 1.27e-04;
    feedback_capacity = 1.56e+03;
    k_cons_AngII = 1.13e-02;  
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%      2.413956255771935e+01
% resnorm_weighted =
%      3.341088696339851e+01
% RMSE =
%      2.417836327079680e-01     2.798128570108271e+00     3.981683471491644e-01
    end
    %% Idrapril Data
elseif strcmp(drugname,'idrapril')
    Xdata = [0, .25, 2];
    if strcmp(renalfunction,'normal') % normal renal function
        % Idrapril Single Dose NRF
        AngIvalue = [12.35, 12.74, 141.05];% pg/mL
        AngIerror = [1.3, 1.82, 52.91];
        AngIIvalue = [6.62, 5.99, 3.36];% pg/mL
        AngIIerror = [1.05, 1.16, .735];
        %No renin or error
        PRAvalue = [1.06, 1.05, 5.83]; %ng/ml/h
        PRAerror = [.13, .15, 1.75];
        % Idrapril normal renal function best fit parameters for PRA 
        % instead of Renin
%% 'estimate' with  TolX TolFun = 1e-12
%     VmaxoverKm = 1.723781440778047e-01;
%     k_cat_Renin = 2.316851432929889e+03;
%     k_feedback = 1.962152760599315e+00;
%     feedback_capacity =  2.132001128241408e+04;
%     k_cons_AngII =   2.220570686385166e-14;
% resnorm =
%      4.027521181460360e+03
% resnorm_weighted =
%      4.081090833769823e+00
% RMSE =
%       1.366466228845459e-01     3.663657762762574e+01     4.995677353412436e-01
%% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart
%     VmaxoverKm = 1.724e-01;
%     k_cat_Renin = 2.317e+03;
%     k_feedback = 1.962e+00;
%     feedback_capacity = 2.132e+04;
%     k_cons_AngII =   2.221e-14;
%TEST
%    VmaxoverKm =  1.975e+01;
%    k_cat_Renin = 1.851e+00;
%    k_feedback =  7.736e+00;
%    feedback_capacity = 2.564e+02;
%    k_cons_AngII = 1.847e+03; 

%    VmaxoverKm =  2.099327811596486e+01;
%    k_cat_Renin = 1.693244563604854e+00;
%    k_feedback =  1.596946979669019e+01;
%    feedback_capacity = 2.500000021598948e+02;
%    k_cons_AngII = 1.806754834251246e+03

    VmaxoverKm =  2.100e+01;
    k_cat_Renin = 1.693e+00;
    k_feedback =  1.597e+01;
    feedback_capacity = 2.500e+02;
    k_cons_AngII = 1.807e+03;
% resnorm =
%      4.026607272598339e+03
% resnorm_weighted =
%       4.081088064228180e+00
% RMSE =
%      1.366269989461366e-01     3.663242131459325e+01     4.994656071638553e-01

%% coef_median from confidence_intevals after multistart topResults = 75
% coef_median =
%   Columns 1 through 4
%      1.440000000000000e-02     6.440000000000000e+04     6.250000000000000e-02     3.970000000000000e+02
%   Column 5
%      6.110000000000000e-01
% coef_min =
%   Columns 1 through 4
%      1.420000000000000e-02     4.700000000000000e+04     4.300000000000000e-02     2.500000000000000e+02
%   Column 5
%      6.010000000000000e-01
% coef_max =
%   Columns 1 through 4
%      1.470000000000000e-02     9.440000000000000e+04     8.200000000000000e-02     2.460000000000000e+03
%   Column 5
%      6.230000000000000e-01
% error_median =
%      1.087118529904956e+01
% error_fitted(index(best),1) =
%     1.085781627680420e+01
%% final values: coef_median
%    VmaxoverKm = 1.44e-02;
%    k_cat_Renin = 6.44e+04;
%    k_feedback = 6.25e-02;
%    feedback_capacity = 3.97e+02;
%    k_cons_AngII = 6.11e-01;
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%       1.079671334966387e+04
% resnorm_weighted =
%      1.087118529904956e+01
% RMSE =
%       1.045017913634304e+00     4.645622872165681e+01     2.634776158719798e-01
 
    end
%% Ramipril Data
elseif strcmp(drugname,'ramipril')
    Xdata = [0, 6, 24];
    if strcmp(renalfunction,'impaired') % impaired renal function
        % Ramipril Single Dose NRF
        % No AngIvalue or error
        AngIIvalue = [10.4, 6.2, 6.1];% pg/mL
        AngIIerror = [5.4, 3.6, 3.4];
        % No renin values or error
        PRAvalue = [2.8, 4.8, 5.4]; %ng/ml/h
        PRAerror = [2.4, 3.9, 5.8];
        
%% 'estimate' with  TolX TolFun = 1e-12
%    VmaxoverKm =  1.614562351116911e-01;
%    k_cat_Renin = 5.990117845447249e-01;
%    k_feedback =  7.198884200091782e-01;
%    feedback_capacity = 3.396694626115774e+03;
%    k_cons_AngII = 1.834600139044929e-01;
% resnorm =
%      8.045826844956158e-02
% resnorm_weighted =
%      3.200194378856608e-03
% RMSE =
%      4.133052643270128e-02     1.584651709408610e-011
%% 'show_plots' with estimate coefs rounded to 4 sig figs: input to multistart
%    VmaxoverKm =  1.615e-01;
%    k_cat_Renin = 5.990e-01;
%    k_feedback =  7.199e-01;
%    feedback_capacity = 3.397e+03;
%    k_cons_AngII = 1.835e-01;
% resnorm =
%      8.043956949992760e-02
% resnorm_weighted =
%      3.200249803969582e-03
% RMSE =
%      4.105306022480421e-02     1.585176207223910e-01
%% coef_median from confidence_intevals after multistart topResults = 3
% coef_median =
%   Columns 1 through 4
%      1.610000000000000e-01     3.590000000000000e-01     7.200000000000000e-01     3.840000000000000e+03
%   Column 5
%      1.840000000000000e-01
% coef_min =
%   Columns 1 through 4
%      1.120000000000000e-01     2.740000000000000e-04     7.190000000000000e-01     9.000000000000000e+02
%   Column 5
%      8.490000000000000e-08
% coef_max =
%   Columns 1 through 4
%      1.620000000000000e-01     1.020000000000000e+03     7.270000000000000e-01     1.960000000000000e+04
%   Column 5
%      1.840000000000000e-01
% error_median =
%      3.285452492206211e-03
% error_fitted(index(best),1) =
%     1.918779949793699e-03
%% final values: coef_median
    VmaxoverKm = 1.61e-01;
    k_cat_Renin = 3.59e-01;
    k_feedback = 7.20e-01;
    feedback_capacity = 3.84e+03;
    k_cons_AngII = 1.84e-01;
%% output from param_estimation 'show_plots' with coef_median
% resnorm =
%       8.547373568380266e-02
% resnorm_weighted =
%       3.285452492206211e-03
% RMSE =
%       4.294026682119359e-02     1.632402484476758e-01
    end    
end
save(strcat('params_',drugname,renalfunction,'.mat'),'-v7.3')
end