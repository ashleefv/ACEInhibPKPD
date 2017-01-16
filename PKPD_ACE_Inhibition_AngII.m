%% PK-PD model of ACE inhibitor dose impact on Ang II plasma concentration
% This code takes an ACE-inhibitor drug dose and calculates the drug and 
% diacid (active drug) concentration in the blood plasma, the % of ACE
% inhibition due to the diacid concentration, and the Renin, angiotensin I
% (ANG I), and angiotensin I (Ang II) concentrations due to enzymatic 
% reactions of the renin angiotensin system with Ang I --> AngII via 
% ACE inhibited competitively by the diacid and with negative feedback 
% from Ang II on Renin enzyme levels
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Not intended to be run directly.  Instead called by an external function
% (call_PKPD_model_scalar or call_PKPD_model_vector) that specifies all the 
% necessary input values for a specific case with dosing information supplied.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function output = PKPD_ACE_Inhibition_AngII(coefficients, drugdose,...
    tau,tfinal_dosing,ka_drug,VF_drug,ke_drug,ke_diacid,VF_diacid,ka_diacid,C50,...
    n_Hill,AngI_conc_t0,AngII_conc_t0,Renin_conc_t0,diacid_conc_t0,...
    drug_conc_t0,k_degr_Renin,k_degr_AngI,Mw_AngI,Mw_AngII,Mw_Renin,sim_time_end)

format long e
VmaxoverKm=coefficients(1);
k_cat_Renin=coefficients(2);
k_feedback=coefficients(3);
feedback_capacity= coefficients(4);
k_cons_AngII=coefficients(5);
% impose constraining assumption that the initial values are steady-state
% values
baseline_cons_AngII = VmaxoverKm*AngI_conc_t0;
baseline_prod_AngI = baseline_cons_AngII+k_degr_AngI*AngI_conc_t0;
baseline_prod_Renin=k_degr_Renin*Renin_conc_t0;
if length(tfinal_dosing)>1
    % For parameter estimation, the time vector is specified by the vector
    % tfinal_dosing = Xdata.
    time = tfinal_dosing; 
else
    % For other cases, only a scalar tfinal is used and it is used for drug
    % concentration calculations. Time needs to be defined based on tau and
    % sim_time_end
    time = 0:tau/500:sim_time_end; % hours
end

% Simulation in units of concentration of pico molar
if tfinal_dosing(end) == 0
    % tfinal_dosing specified as zero returns the initial condition without calling
    % the ODE solver
    output = [tfinal_dosing,diacid_conc_t0,AngII_conc_t0*Mw_AngII*1000/10^6,...
        AngI_conc_t0*Mw_AngI*1000/10^6,0,Renin_conc_t0*Mw_Renin*1000/10^6,drug_conc_t0];
else
    %% call the ODE solver
    % initial condition for the ODE solver
    conc_t0 = [AngI_conc_t0; AngII_conc_t0; Renin_conc_t0]; 
    % ODE solver options
    options = odeset('RelTol',1e-12,'AbsTOL',1e-6);
    [t,conc] = ode45(@(t,conc) ODE(t,conc,drugdose,ke_diacid,...
            VF_diacid,ka_diacid,feedback_capacity,baseline_prod_AngI,...
            baseline_cons_AngII,VmaxoverKm,k_cat_Renin,k_feedback,C50,...
            n_Hill,tau,tfinal_dosing(end),AngII_conc_t0,Renin_conc_t0,baseline_prod_Renin,...
            k_degr_Renin,k_degr_AngI,k_cons_AngII),time,conc_t0,options);
    %% Concentrations of each species at each time
    for i = 1:length(t)
        drug_conc(i,1) = analytical_PK(drugdose,ka_drug,VF_drug,ke_drug,...
            t(i),tau,tfinal_dosing(end)); %ng/ml
        diacid_conc(i,1) = analytical_PK(drugdose,ka_diacid,VF_diacid,...
            ke_diacid,t(i),tau,tfinal_dosing(end)); %ng/ml
    end
AngI_conc = conc(:,1).*Mw_AngI*1000/10^6; % pg/ml
AngII_conc = conc(:,2).*Mw_AngII*1000/10^6; % pg/ml
Renin_conc = conc(:,3).*Mw_Renin*1000/10^6; % pg/ml
Inhibition = diacid_conc.^n_Hill./(diacid_conc.^n_Hill+C50.^n_Hill)*100;

output = [t,diacid_conc,AngII_conc,AngI_conc,Inhibition,Renin_conc,drug_conc];

end
end

%% Pharmacokinetics analytical solution
function drug_conc_theo = analytical_PK(drugdose,ka,VF,ke,t,tau,tfinal_dosing)
    if t<tfinal_dosing
        n = floor(t/tau)+1;
    else
        n = floor(tfinal_dosing/tau);
    end
    tprime = t-tau*(n-1);
    drug_conc_theo = drugdose*ka/(VF*(ka-ke))*...
        ( (1-exp(-n*ke*tau))*(exp(-ke.*tprime))/(1-exp(-ke*tau))...
        -(1-exp(-n*ka*tau))*(exp(-ka.*tprime))/(1-exp(-ka*tau)) ); 
end

%% Local function: ODE
% Define the differential equations for concentrations of non-drug species
function d_conc_dt = ODE(t,conc,drugdose,ke_diacid,VF_diacid,ka_diacid,...
    feedback_capacity,baseline_prod_AngI,baseline_cons_AngII,...
    VmaxoverKm,k_cat_Renin,k_feedback,C50,n_Hill,tau,tfinal_dosing,AngII_conc_t0,...
    Renin_conc_t0,baseline_prod_Renin,k_degr_Renin,k_degr_AngI,k_cons_AngII)
    
    % Input concentration vector conc contains species AngI, AngII & Renin
    AngI_conc = conc(1); % angiotension I concentration nmol/ml
    AngII_conc = conc(2); % angiotension II concentration nmol/ml
    Renin_conc = conc(3); % renin concentration nmol/ml
    
    % PK model explicit functions
    diacid_conc = analytical_PK(drugdose,ka_diacid,VF_diacid,ke_diacid,t,tau,tfinal_dosing);
    Inhibition=diacid_conc.^n_Hill./(diacid_conc.^n_Hill+C50.^n_Hill);
%     IKI=Inhibition*(AngI_conc/Km+1)/(1-Inhibition);
    
     %%%%%%%%%%%%
    % PD model
    %%%%%%%%%%%%
    % Rxn 1
    % Production rate of Ang I from angiotensinogen --> Ang I in presence
    % of Renin with baseline and variable contributions. Only Renin changes 
    % due to drug presence.
    variable_prod_AngI = k_cat_Renin*(Renin_conc-Renin_conc_t0);
    r1 = variable_prod_AngI+baseline_prod_AngI;
    %%%%%%%%%%%%
    % Rxn 2
    % Baseline production of Renin + negative feedback from AngII to Renin 
    % production using logistic function dependence on change of AngII_conc 
    % from steady state set point
%     r2 = baseline_prod_Renin - k_feedback*(AngII_conc-AngII_conc_t0)*...
%         (1+(AngII_conc-AngII_conc_t0)/feedback_capacity);
    r2 = baseline_prod_Renin + k_feedback*(AngII_conc_t0-AngII_conc)*...
        (1-(AngII_conc_t0-AngII_conc)/feedback_capacity);
    %%%%%%%%%%%%
    % Rxn 3
    % Degradation of Renin
    r3 = k_degr_Renin*Renin_conc;
    %%%%%%%%%%%%
    % Rxn 4
    % Degradation of Ang I
    r4 = k_degr_AngI*AngI_conc;
    %%%%%%%%%%%%
    % Rxn 5
    % Rate of Ang I --> Ang II catalyzed by ACE with AngI_conc and I/KI 
    % changing due to drug presence
    r5 = VmaxoverKm*AngI_conc*(1-Inhibition);
    %%%%%%%%%%%%
    % Rxn 6
    % Consumption rate of Ang II --> with AngII_conc being the only term 
    % thatchanges due to drug presence
    r6 = k_cons_AngII*(AngII_conc-AngII_conc_t0)+baseline_cons_AngII;
    
    % ODEs for the three changing hormone/enzyme concentrations
    d_AngI_conc_dt = r1-r4-r5;
    d_AngII_conc_dt = r5-r6;
    d_Renin_conc_dt = r2-r3;


    % concentration derivative vector has entries for Ang I, Ang II, & Renin
    d_conc_dt(1) = d_AngI_conc_dt; 
    d_conc_dt(2) = d_AngII_conc_dt;
    d_conc_dt(3) = d_Renin_conc_dt;
    d_conc_dt = d_conc_dt';
end