# ACEInhibPKPD
PKPD model for ACE inhibition with benazapril or cilazapril; educational drug dosing app for treatment of high blood pressure

[![DOI](https://zenodo.org/badge/79126249.svg)](https://zenodo.org/badge/latestdoi/79126249)

![GUI screenshot](thumbnail.png)

## Overview
This app is an interactive computer simulation that can be used to design the best dosage of two pharmaceuticals for reducing high blood pressure. The app uses concepts from chemical engineering and tools from mathematics, pharmacology, and computational science to describe and solve the the dynamics of the chemical reactions in the human body involved in the absorption, metabolism, and excretion of the drug and how the blood pressure-regulating homone Angiotensin II is affected by the drug concentration as a function of time.  Begin by entering dose size and frequency values and select the ACE inhibitor drug and the patient kidney function from the drop down menus. Run the simulation to generate the plots. Use the plots to analyze the behavior of the tested dosing schedule. Determine what dose size and frequency will be the most effective in lowering the blood pressure by lowering the Angiotensin II hormone concentration of the individual to a normal level while managing tradeoffs like efficacy, convenience, price, and side effects. Advanced users may refer to the MATLAB run_PKPD_without_GUI.m to bypass the GUI to show additional results or edit the code directly.

## PKPD ACE Inhibition Model
### Authors
Ashlee N. Ford Versypt, Grace K. Harrell, and Alexandra N. McPeak, 
School of Chemical Engineering,
Oklahoma State University.
Corresponding author: A. N. Ford Versypt, ashleefv@okstate.edu

### Data sources for ACE inhibitor drugs
* H. Shionoiri, S. Ueda, K. Minamisawa, Pharmacokinetics and Pharmacodynamics 
   of Benazepril in Hypertensive Patients with Normal and Impaired Renal-
   Function, Journal of Cardiovascular Pharmacology 20 (3) (1992) 348–57.

* H. Shionoiri, E. Gotoh, N. Takagi, Antihypertensive Effects and 
   Pharmacokinetics of Single and Consecutive Doses of Cilazapril in 
   Hypertensive Patients with Normal and Impaired Renal-Function, Journal of 
   Cardiovascular Pharmacology 11 (2) (1988) 242–9.

### Main files

* GUI_ACE_Inhib_PKPD.m & .fig.
   Runs the model interactively with a graphical user interface. Designed for 
   educational use for students in grades 6-12 and undergraduate students.
 
OR
  
* run_PKPD_without_GUI.m.
   Runs the model manually either in the Editor or by passing arguments in the
   command line. Can run more cases that allowable in the GUI and can specify
   plot_mode to show more plots than available through GUI or to produce and 
   save publication-quality plots.

### Supplementary files

* PKPD_ACE_Inhibition_AngII.m.
   The central file that uses case-specific parameters and dosing information 
   as input to the PKPD model of ACE inhibitor dose impact on AngII plasma 
   concentration. Output includes the vectors of time and the concentrations of 
   the drug, diacid form, AngI, AngII, and Renin and the percent of inhibition 
   (not in this order). Note: do not run this file directly. Instead let it be called by either 
   call_PKPD_model_scalar.m or call_PKPD_model_vector_param_est.m
   (described subsequently) that correctly define all the input values.

* setup_mat_for_PK_params.m.
   All PK parameters for the drug/renalfunction combinations are edited and 
   written to .mat files for use in other routines.

* setup_mat_for_data_estimated_params.m.
   All data for parameter estimation and the estimated parameters are edited and
   written to .mat files for use in other routines.
   
* run_params.m.
   Sets the input values that GUI_ACE_Inhib_PKPD.m sets interactively. It is
   used as a default input through a .mat file for run_PKPD_without_GUI.m and 
   param_estimation.m.

* call_PKPD_model_vector_param_est.m.
   Sets up parameters once before a loop through tfinal_dosing vector calling
   PKPD_ACE_Inhibition_AngII.m at each loop iteration. Output is the vector of  
   Y values used for parameter estimation comparison to data.
   
* call_PKPD_model_scalar.m.
   Used by GUI_ACE_Inhib_PKPD.m, run_PKPD_without_GUI.m, and param_estimation.m. 
   Sets up parameters before calling PKPD_ACE_Inhibition_AngII.m for a scalar 
   value of tfinal_dosing. Output is all of the output from 
   PKPD_ACE_Inhibition_AngII.m with options for plotting and saving figures
   through plot_mode string.
   
* .mat files. 
   Needed to run the programs to pass data, parameters, and calculated values.
   
* /pub_plots/.
   Subdirectory where plots are stored when plot_mode = 'pub_plots'
   
* export_fig.m
   MATLAB package to nicely export figures.
   Download: https://www.mathworks.com/matlabcentral/fileexchange/23629-export-fig
   Tips for usage: https://github.com/altmany/export_fig/blob/master/README.md
