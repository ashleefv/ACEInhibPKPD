%% Call the PK-PD model for scalar tfinal_dosing and output of full PKPD results
% Input: 
%   coefficients are adjustable model parameters, estimated from data
%   tfinal_dosing is final Time (scalar) for the drug dosing
%   sim_time_end is the last time simulated (allows for simulation beyond
%   the duration of dosing to see long term effects of dosing)
%   plot_mode is a string for turning on or off plotting and saving; 
%       if 'show_plots;, then construct basic plots
%       if 'plots_pub', then configure the plot sizes and export
%   Varargin > 5:
%       Run-specific parameters that aren't likely to change for each 
%       simulation should be set in run_params.m to create the .mat file. 
%       These parameters are those that are adjustable in the GUI. The GUI 
%       explicitly sets varargin{5}-{8}. These can also be specified by any 
%       other routine that calls call_PKPK_model_scalar. However, the 
%       run_params.mat option is used for convenience if one scenario is
%       used repeatedly without manipulation (particularly for debugging or
%       parameter estimation).
% Output:
%   output is all the output from PKPD_ACE_Inhibition_AngII.m at
%   0:sim_end_time
function drugoutput = call_PKPD_model_scalar(varargin)
format long e
coefficients = varargin{1};
tfinal_dosing = varargin{2};
sim_time_end = varargin{3};
plot_mode = varargin{4};
layer_plots = varargin{5};
if nargin>5
    drugdose = varargin{6};
    tau = varargin{7};
    drugname = varargin{8};
    renalfunction = varargin{9};
    linestylestring = varargin{10};
else
    run_params = matfile('run_params.mat'); 
    drugdose = run_params.drugdose;
    tau = run_params.tau;
    drugname = run_params.drugname;
    renalfunction = run_params.renalfunction;
    linestylestring = '-';
end
pill_mg = drugdose*1e-6;
num_doses_per_day=24/tau;
PK_paramsfile = strcat('PK_params_',drugname,renalfunction,'.mat');
PK_params = matfile(PK_paramsfile);
ka_drug = PK_params.ka_drug;
VF_drug = PK_params.VF_drug;
ke_drug = PK_params.ke_drug;
ke_diacid = PK_params.ke_diacid;
VF_diacid = PK_params.VF_diacid;
ka_diacid = PK_params.ka_diacid; 
C50 = PK_params.C50;
n_Hill = PK_params.n_Hill; 
AngI_conc_t0 = PK_params.AngI_conc_t0;%pM t 
AngII_conc_t0 = PK_params.AngII_conc_t0;% pM to nmol/mL 
Renin_conc_t0 = PK_params.Renin_conc_t0;
k_degr_Renin = PK_params.k_degr_Renin;
k_degr_AngI = PK_params.k_degr_AngI;
diacid_conc_t0= PK_params.diacid_conc_t0;
drug_conc_t0 = PK_params.drug_conc_t0;
Mw_AngI = PK_params.Mw_AngI;
Mw_AngII = PK_params.Mw_AngII;
Mw_Renin = PK_params.Mw_Renin;
PRA_t0 = 0.696+0.045.*Renin_conc_t0*1000*Mw_Renin/10^6;
drugoutput = PKPD_ACE_Inhibition_AngII(coefficients,...
    drugdose,tau,tfinal_dosing,ka_drug,VF_drug,...
    ke_drug,ke_diacid,VF_diacid,ka_diacid,C50,n_Hill,AngI_conc_t0,...
    AngII_conc_t0,Renin_conc_t0,diacid_conc_t0,drug_conc_t0,...
    k_degr_Renin,k_degr_AngI,Mw_AngI,Mw_AngII, Mw_Renin,sim_time_end);
t = drugoutput(:,1);
if t(end)>24
    tplot = t./24;
    xstring = 't (days)';
else
    tplot = t;
    xstring = 'Time (h)';
end    
diacid_conc = drugoutput(:,2); 
AngII_conc = drugoutput(:,3);
AngI_conc = drugoutput(:,4);
Inhibition = drugoutput(:,5);
Renin_conc = drugoutput(:,6);
drug_conc = drugoutput(:,7);
PRA = 0.696+0.045.*Renin_conc;
if strcmp(drugname,'benazepril')
    drugnum = 1;
else
    drugnum = 2;
end
% GUI has plot_mode = '' so these plots aren't produced. 'show_plots' is
% for subplots of main results. 'pub_plots' produces the publication quality 
% figures without data layered on top.
set(0,'DefaultAxesColorOrder',[19 106 177; 204 88 37; 126 ...
    162 43; 109 55 136; 143 143 145]/255)
% set(0,'defaultaxeslinestyleorder',{'-','--','o'}) %

modifiedpwd = pwd;
for i = 1:length(modifiedpwd)
    if strcmp(modifiedpwd(i),'\')
        modifiedpwd(i) = '/';
    end
end
    
if strcmp(plot_mode,'show_plots') 
    figure(1)
    subplot(221)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end
    plot(tplot,diacid_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel(xstring), ylabel('Drug Diacid Concentration (ng/mL)')
    legend('-Dynamiclegend','Location','Best')
    subplot(222)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end  
    plot(tplot,AngII_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)'), ylabel('Ang II Conc. (pg ml^{-1})','Interpreter','Tex')
    legend('-Dynamiclegend','Location','Best')
%     hold on
%     tconsec = 7+[0,2,4,8,24]/24;
%     errorbar(tconsec,[13.381861,9.537295, 8.84768, 8.093695, 11.506702],...
%         [0.743949, 0.565373, 0.565489,0.5059646, 0.535726],'o')

    subplot(223)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end  
    plot(tplot,AngI_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)'), ylabel('Ang I Conc. (pg ml^{-1})','Interpreter','Tex')
    legend('-Dynamiclegend','Location','Best')
    subplot(224)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end   
    plot(tplot,PRA,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)'), ylabel('PRA (ng/mL/hr)')%ylabel('Renin (pg/mL)')
    legend('-Dynamiclegend','Location','Best')
    figure(2)
    subplot(221)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end   
    semilogy(tplot,diacid_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)'), ylabel('Drug Diacid Concentration (ng/mL)')
    legend('-Dynamiclegend','Location','Best')
    subplot(222)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end    
    plot(tplot,Inhibition,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)'), ylabel('Inhibition (%)')
    legend('-Dynamiclegend','Location','Best')
    subplot(223)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end    
    plot(tplot,AngII_conc./AngI_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)'), ylabel('Ang II/Ang I ratio')
    legend('-Dynamiclegend','Location','Best')
    subplot(224)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end    
    diacid_inhib = [diacid_conc,Inhibition];
    sorted_diacid_inhib = sortrows(diacid_inhib,1);
    plot(sorted_diacid_inhib(:,1),sorted_diacid_inhib(:,2),linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('Drug Diacid Concentration (ng/mL)'), ylabel('Inhibition (%)')
    legend('-Dynamiclegend','Location','Best')
elseif strcmp(plot_mode,'pub_plots')
    figure(20)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end    
    plot(tplot,Inhibition,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)'), ylabel('Inhibition (%)')
    legend('-Dynamiclegend','Location','Best')
    figure(10)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end
    plot(tplot,AngII_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)','FontSize',10), ylabel('Ang II Conc. (pg ml^{-1})','Interpreter','Tex','FontSize',10)
%     legend('-Dynamiclegend','Location','Best')
    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]); 
    if strcmp(layer_plots,'yes')
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_AngIIvstime_%s%s_%d_mg_%d_doses_per_dayLAYERED',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))        
        end
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    else
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_AngIIvstime_%s%s_%d_mg_%d_doses_per_day',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))   
        end
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    end
    
    figure(11)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end
    plot(tplot,AngI_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)','FontSize',10), ylabel('Ang I Conc. (pg ml^{-1})','Interpreter','Tex','FontSize',10)
%     legend('-Dynamiclegend','Location','Best')
    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    if strcmp(layer_plots,'yes')
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_AngIvstime_%s%s_%d_mg_%d_doses_per_dayLAYERED',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))       
        end
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    else
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_AngIvstime_%s%s_%d_mg_%d_doses_per_day',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))         
        end        
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    end
    
    figure(12)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end    
    plot(tplot,PRA,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)','FontSize',10), ylabel('PRA (ng/mL/hr)','FontSize',10)
%     legend('-Dynamiclegend','Location','Best')
    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    if strcmp(layer_plots,'yes')
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_PRAvstime_%s%s_%d_mg_%d_doses_per_dayLAYERED',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))         
        end
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    else
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_PRAvstime_%s%s_%d_mg_%d_doses_per_day',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))        
        end
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    end
    
    if strcmp(drugname,'benazepril')
        figure(13)
        if strcmp(layer_plots,'yes')
            hold on
        else
            hold off
        end    
        plot(tplot,Renin_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
        xlabel('t (days)','FontSize',10), ylabel('Renin (pg/mL)','FontSize',10)
%         legend('-Dynamiclegend','Location','Best')
        get(gca);set(gca,'FontSize',10,'FontName','Arial');
        set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
        if strcmp(layer_plots,'yes')
            filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_Reninvstime_%s%s_%d_mg_%d_doses_per_dayLAYERED',drugname,renalfunction,pill_mg,num_doses_per_day));
            if exist(strcat(filename,'.png'), 'file')
                delete(strcat(filename,'.png'))
                delete(strcat(filename,'.eps'))   
                delete(strcat(filename,'.tif'))          
            end
            export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
        else
            filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_Reninvstime_%s%s_%d_mg_%d_doses_per_day',drugname,renalfunction,pill_mg,num_doses_per_day));
            if exist(strcat(filename,'.png'), 'file')
                delete(strcat(filename,'.png'))
                delete(strcat(filename,'.eps'))   
                delete(strcat(filename,'.tif'))         
            end            
            export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
        end
    end
    
    figure(14)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end    
    plot(tplot,diacid_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)','FontSize',10), ylabel('Drug Diacid Concentration (ng/mL)','FontSize',10)
%     legend('-Dynamiclegend','Location','Best')
    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    if strcmp(layer_plots,'yes')
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_Diacidvstime_%s%s_%d_mg_%d_doses_per_dayLAYERED',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))      
        end        
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    else
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_Diacidvstime_%s%s_%d_mg_%d_doses_per_day',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))          
        end        
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    end

    figure(15)
    if strcmp(layer_plots,'yes')
        hold on
    else
        hold off
    end    
    plot(tplot,drug_conc,linestylestring,'linewidth',1.25,'DisplayName',...
        [num2str(num_doses_per_day) ' dose of ' ...
        num2str(pill_mg) ' mg daily of Drug ' num2str(drugnum)...
        '; KF: ' renalfunction])
    xlabel('t (days)','FontSize',10), ylabel('Drug Concentration (ng/mL)','FontSize',10)
%     legend('-Dynamiclegend','Location','Best')
    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    if strcmp(layer_plots,'yes')
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_Drugvstime_%s%s_%d_mg_%d_doses_per_dayLAYERED',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))         
        end
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    else
        filename = strcat(modifiedpwd,sprintf('/pub_plots/nodata_Drugvstime_%s%s_%d_mg_%d_doses_per_day',drugname,renalfunction,pill_mg,num_doses_per_day));
        if exist(strcat(filename,'.png'), 'file')
            delete(strcat(filename,'.png'))
            delete(strcat(filename,'.eps'))   
            delete(strcat(filename,'.tif'))      
        end        
        export_fig(filename,'-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    end
end
    
end
