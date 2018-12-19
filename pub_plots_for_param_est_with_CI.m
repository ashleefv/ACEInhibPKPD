%% Combines & constructs plots for parameter estimation output for all cases for PK-PD model for ACE inhibition
% Uses the output of param_estimation.m function for the four different
% drug and renalfunction cases are stored in PE_drugnamerenalfunction.mat files.
close all
% [19 106 177]/255; %blue [109 55 136]/255; %purple [126 162 43]/255; %green
BenNRF = matfile('PE_benazeprilnormal.mat');
BenIRF = matfile('PE_benazeprilimpaired.mat');
CilNRF = matfile('PE_cilazaprilnormal.mat');
CilIRF = matfile('PE_cilazaprilimpaired.mat');
BenNRFCI = matfile('CI_benazeprilnormal.mat');
BenIRFCI = matfile('CI_benazeprilimpaired.mat');
CilNRFCI = matfile('CI_cilazaprilnormal.mat');
CilIRFCI = matfile('CI_cilazaprilimpaired.mat');
BenNRFt = BenNRF.drugoutput(:,1);
BenNRFAngII_conc = BenNRF.drugoutput(:,3);
BenNRFAngI_conc = BenNRF.drugoutput(:,4);
BenNRFRenin_conc = BenNRF.drugoutput(:,6);
BenNRFPRA = 0.696+0.045.*BenNRFRenin_conc;
BenNRFXdata = BenNRF.Xdata;
BenNRFYdata = BenNRF.Ydata;
BenIRFt = BenIRF.drugoutput(:,1);
BenIRFAngII_conc = BenIRF.drugoutput(:,3);
BenIRFAngI_conc = BenIRF.drugoutput(:,4);
BenIRFRenin_conc = BenIRF.drugoutput(:,6);
BenIRFPRA = 0.696+0.045.*BenIRFRenin_conc;
BenIRFXdata = BenIRF.Xdata;
BenIRFYdata = BenIRF.Ydata;
BenNRFAngIIerror = BenNRF.AngIIerror;
BenNRFAngIerror = BenNRF.AngIerror;
BenNRFPRAerror = BenNRF.PRAerror;
BenIRFAngIIerror = BenIRF.AngIIerror;
BenIRFAngIerror = BenIRF.AngIerror;
BenIRFPRAerror = BenIRF.PRAerror;
CilNRFt = CilNRF.drugoutput(:,1);
CilNRFAngII_conc = CilNRF.drugoutput(:,3);
CilNRFAngI_conc = CilNRF.drugoutput(:,4);
CilNRFRenin_conc = CilNRF.drugoutput(:,6);
CilNRFPRA = 0.696+0.045.*CilNRFRenin_conc;
CilNRFXdata = CilNRF.Xdata;
CilNRFYdata = CilNRF.Ydata;
CilIRFt = CilIRF.drugoutput(:,1);
CilIRFAngII_conc = CilIRF.drugoutput(:,3);
CilIRFAngI_conc = CilIRF.drugoutput(:,4);
CilIRFRenin_conc = CilIRF.drugoutput(:,6);
CilIRFPRA = 0.696+0.045.*CilIRFRenin_conc;
CilIRFXdata = CilIRF.Xdata;
CilIRFYdata = CilIRF.Ydata;
BenNRFAngII_timepoints=BenNRFCI.AngII_timepoints;
BenNRFAngII_50CI_lower=BenNRFCI.AngII_50CI_lower;
BenNRFAngII_50CI_upper=BenNRFCI.AngII_50CI_upper;
BenNRFAngII_95CI_lower=BenNRFCI.AngII_95CI_lower;
BenNRFAngII_95CI_upper=BenNRFCI.AngII_95CI_upper;
BenNRFAngII_CI_median=BenNRFCI.AngII_CI_median;
BenNRFAngII_CI_best=BenNRFCI.AngII_CI_best;
BenNRFAngII_timepoints=BenNRFCI.AngII_timepoints;
BenNRFAngI_50CI_lower=BenNRFCI.AngI_50CI_lower;
BenNRFAngI_50CI_upper=BenNRFCI.AngI_50CI_upper;
BenNRFAngI_95CI_lower=BenNRFCI.AngI_95CI_lower;
BenNRFAngI_95CI_upper=BenNRFCI.AngI_95CI_upper;
BenNRFAngI_CI_median=BenNRFCI.AngI_CI_median;
BenNRFAngI_CI_best=BenNRFCI.AngI_CI_best;
BenNRFAngI_timepoints=BenNRFCI.AngI_timepoints;
BenNRFPRA_50CI_lower=BenNRFCI.PRA_50CI_lower;
BenNRFPRA_50CI_upper=BenNRFCI.PRA_50CI_upper;
BenNRFPRA_95CI_lower=BenNRFCI.PRA_95CI_lower;
BenNRFPRA_95CI_upper=BenNRFCI.PRA_95CI_upper;
BenNRFPRA_CI_median=BenNRFCI.PRA_CI_median;
BenNRFPRA_CI_best=BenNRFCI.PRA_CI_best;
BenNRFPRA_timepoints=BenNRFCI.PRA_timepoints;

BenIRFAngII_timepoints=BenIRFCI.AngII_timepoints;
BenIRFAngII_timepoints=BenIRFCI.AngII_timepoints;
BenIRFAngII_50CI_lower=BenIRFCI.AngII_50CI_lower;
BenIRFAngII_50CI_upper=BenIRFCI.AngII_50CI_upper;
BenIRFAngII_95CI_lower=BenIRFCI.AngII_95CI_lower;
BenIRFAngII_95CI_upper=BenIRFCI.AngII_95CI_upper;
BenIRFAngII_CI_median=BenIRFCI.AngII_CI_median;
BenIRFAngII_CI_best=BenIRFCI.AngII_CI_best;
BenIRFAngII_timepoints=BenIRFCI.AngII_timepoints;
BenIRFAngI_50CI_lower=BenIRFCI.AngI_50CI_lower;
BenIRFAngI_50CI_upper=BenIRFCI.AngI_50CI_upper;
BenIRFAngI_95CI_lower=BenIRFCI.AngI_95CI_lower;
BenIRFAngI_95CI_upper=BenIRFCI.AngI_95CI_upper;
BenIRFAngI_CI_median=BenIRFCI.AngI_CI_median;
BenIRFAngI_CI_best=BenIRFCI.AngI_CI_best;
BenIRFAngI_timepoints=BenIRFCI.AngI_timepoints;
BenIRFPRA_50CI_lower=BenIRFCI.PRA_50CI_lower;
BenIRFPRA_50CI_upper=BenIRFCI.PRA_50CI_upper;
BenIRFPRA_95CI_lower=BenIRFCI.PRA_95CI_lower;
BenIRFPRA_95CI_upper=BenIRFCI.PRA_95CI_upper;
BenIRFPRA_CI_median=BenIRFCI.PRA_CI_median;
BenIRFPRA_CI_best=BenIRFCI.PRA_CI_best;
BenIRFPRA_timepoints=BenIRFCI.PRA_timepoints;

CilNRFAngII_timepoints=CilNRFCI.AngII_timepoints;
CilNRFAngII_50CI_lower=CilNRFCI.AngII_50CI_lower;
CilNRFAngII_50CI_upper=CilNRFCI.AngII_50CI_upper;
CilNRFAngII_95CI_lower=CilNRFCI.AngII_95CI_lower;
CilNRFAngII_95CI_upper=CilNRFCI.AngII_95CI_upper;
CilNRFAngII_CI_median=CilNRFCI.AngII_CI_median;
CilNRFAngII_CI_best=CilNRFCI.AngII_CI_best;
CilNRFAngII_timepoints=CilNRFCI.AngII_timepoints;
CilNRFAngI_50CI_lower=CilNRFCI.AngI_50CI_lower;
CilNRFAngI_50CI_upper=CilNRFCI.AngI_50CI_upper;
CilNRFAngI_95CI_lower=CilNRFCI.AngI_95CI_lower;
CilNRFAngI_95CI_upper=CilNRFCI.AngI_95CI_upper;
CilNRFAngI_CI_median=CilNRFCI.AngI_CI_median;
CilNRFAngI_CI_best=CilNRFCI.AngI_CI_best;
CilNRFAngI_timepoints=CilNRFCI.AngI_timepoints;
CilNRFPRA_50CI_lower=CilNRFCI.PRA_50CI_lower;
CilNRFPRA_50CI_upper=CilNRFCI.PRA_50CI_upper;
CilNRFPRA_95CI_lower=CilNRFCI.PRA_95CI_lower;
CilNRFPRA_95CI_upper=CilNRFCI.PRA_95CI_upper;
CilNRFPRA_CI_median=CilNRFCI.PRA_CI_median;
CilNRFPRA_CI_best=CilNRFCI.PRA_CI_best;
CilNRFPRA_timepoints=CilNRFCI.PRA_timepoints;

CilIRFAngII_timepoints=CilIRFCI.AngII_timepoints;
CilIRFAngII_timepoints=CilIRFCI.AngII_timepoints;
CilIRFAngII_50CI_lower=CilIRFCI.AngII_50CI_lower;
CilIRFAngII_50CI_upper=CilIRFCI.AngII_50CI_upper;
CilIRFAngII_95CI_lower=CilIRFCI.AngII_95CI_lower;
CilIRFAngII_95CI_upper=CilIRFCI.AngII_95CI_upper;
CilIRFAngII_CI_median=CilIRFCI.AngII_CI_median;
CilIRFAngII_CI_best=CilIRFCI.AngII_CI_best;
CilIRFAngII_timepoints=CilIRFCI.AngII_timepoints;
CilIRFAngI_50CI_lower=CilIRFCI.AngI_50CI_lower;
CilIRFAngI_50CI_upper=CilIRFCI.AngI_50CI_upper;
CilIRFAngI_95CI_lower=CilIRFCI.AngI_95CI_lower;
CilIRFAngI_95CI_upper=CilIRFCI.AngI_95CI_upper;
CilIRFAngI_CI_median=CilIRFCI.AngI_CI_median;
CilIRFAngI_CI_best=CilIRFCI.AngI_CI_best;
CilIRFAngI_timepoints=CilIRFCI.AngI_timepoints;
CilIRFPRA_50CI_lower=CilIRFCI.PRA_50CI_lower;
CilIRFPRA_50CI_upper=CilIRFCI.PRA_50CI_upper;
CilIRFPRA_95CI_lower=CilIRFCI.PRA_95CI_lower;
CilIRFPRA_95CI_upper=CilIRFCI.PRA_95CI_upper;
CilIRFPRA_CI_median=CilIRFCI.PRA_CI_median;
CilIRFPRA_CI_best=CilIRFCI.PRA_CI_best;
CilIRFPRA_timepoints=CilIRFCI.PRA_timepoints;
set(0,'DefaultAxesColorOrder',[19 106 177; 204 88 37; 126 ...
    162 43; 109 55 136; 143 143 145]/255)
figure(1)
    hold on
%     %--- shade 50% CI
%     h1=jbfill(BenNRFAngII_timepoints,BenNRFAngII_50CI_lower,BenNRFAngII_50CI_upper,[19 106 177]/255,[19 106 177]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h2=jbfill(BenNRFAngII_timepoints,BenNRFAngII_95CI_lower,BenNRFAngII_95CI_upper,[19 106 177]/255,[19 106 177]/255,1,0.2);
hold on
    % %--- plot predictions from median of each parameter
   %plot(BenNRFAngII_timepoints,BenNRFAngII_CI_best,'-.','color',[19 106 177]/255,'LineWidth',1.25);
    hold on
%     %--- shade 50% CI
%     h3=jbfill(BenIRFAngII_timepoints,BenIRFAngII_50CI_lower,BenIRFAngII_50CI_upper,[204 88 37]/255,[204 88 37]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h4=jbfill(BenIRFAngII_timepoints,BenIRFAngII_95CI_lower,BenIRFAngII_95CI_upper,[204 88 37]/255,[204 88 37]/255,1,0.2);
hold on
    % %--- plot predictions from median of each parameter
   %plot(BenIRFAngII_timepoints,BenIRFAngII_CI_best,'--','color',[204 88 37]/255,'LineWidth',1.25);
       ax = gca;
    ax.ColorOrderIndex = 1;
    plot(BenNRFt,BenNRFAngII_conc,'-.','linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(BenIRFt,BenIRFAngII_conc,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax.ColorOrderIndex = 1;
   errorbar(BenNRFXdata,BenNRFYdata(1,:),BenNRFAngIIerror,'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    errorbar(BenIRFXdata,BenIRFYdata(1,:),BenIRFAngIIerror,'s','MarkerSize',3,'Marker','o','DisplayName',...
        'IRF data')

    ax.ColorOrderIndex = 1;

    hold off
    axis([-1 25 5 25])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('Ang II Conc. (pg ml^{-1})','FontName','Arial','FontSize',10)
% hasbehavior(h1, 'legend', false);   % line will not be in legend
hasbehavior(h2, 'legend', false);   % line will not be in legend
% hasbehavior(h3, 'legend', false);   % line will not be in legend
hasbehavior(h4, 'legend', false);   % line will not be in legend
        legend('-Dynamiclegend','Location','best')
    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/CI_PE_ben_AngIIvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');

figure(2)
%     %--- shade 50% CI
%     h1=jbfill(CilNRFAngII_timepoints,CilNRFAngII_50CI_lower,CilNRFAngII_50CI_upper,[19 106 177]/255,[19 106 177]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h2=jbfill(CilNRFAngII_timepoints,CilNRFAngII_95CI_lower,CilNRFAngII_95CI_upper,[19 106 177]/255,[19 106 177]/255,1,0.2);
hold on
    % %--- plot predictions from median of each parameter
    %plot(CilNRFAngII_timepoints,CilNRFAngII_CI_best,'-.','color',[19 106 177]/255,'LineWidth',1.25);
    hold on
%     %--- shade 50% CI
%     h3=jbfill(CilIRFAngII_timepoints,CilIRFAngII_50CI_lower,CilIRFAngII_50CI_upper,[204 88 37]/255,[204 88 37]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h4=jbfill(CilIRFAngII_timepoints,CilIRFAngII_95CI_lower,CilIRFAngII_95CI_upper,[204 88 37]/255,[204 88 37]/255,1,0.2);
hold on
    % %--- plot predictions from median of each parameter
    %plot(CilNRFAngII_timepoints,CilNRFAngII_CI_best,'--','color',[204 88 37]/255,'LineWidth',1.25);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(CilNRFt,CilNRFAngII_conc,'-.','linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(CilIRFt,CilIRFAngII_conc,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')

    ax.ColorOrderIndex = 1;
    h=plot(CilNRFXdata,CilNRFYdata(1,:),'s','MarkerSize',3,'DisplayName',...
        'NRF data');
        set(h, 'MarkerFaceColor', get(h, 'Color'));
    plot(CilIRFXdata,CilIRFYdata(1,:),'s','MarkerSize',3,'Marker','o','DisplayName',...
        'IRF data')

    hold on

    hold off
    axis([-1 25 0 35])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('Ang II Conc. (pg ml^{-1})','FontName','Arial','FontSize',10)
% hasbehavior(h1, 'legend', false);   % line will not be in legend
hasbehavior(h2, 'legend', false);   % line will not be in legend
% hasbehavior(h3, 'legend', false);   % line will not be in legend
hasbehavior(h4, 'legend', false);   % line will not be in legend
        legend('-Dynamiclegend','Location','best') 

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/CI_PE_cil_AngIIvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
figure(3)
% %--- shade 50% CI
%     h1=jbfill(BenNRFAngI_timepoints,BenNRFAngI_50CI_lower,BenNRFAngI_50CI_upper,[19 106 177]/255,[19 106 177]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h2=jbfill(BenNRFAngI_timepoints,BenNRFAngI_95CI_lower,BenNRFAngI_95CI_upper,[19 106 177]/255,[19 106 177]/255,1,0.2);
hold on
    % %--- plot predictions from median of each parameter
   %plot(BenNRFAngI_timepoints,BenNRFAngI_CI_best,'-.','color',[19 106 177]/255,'LineWidth',1.25);
    hold on
%     %--- shade 50% CI
%     h3=jbfill(BenIRFAngI_timepoints,BenIRFAngI_50CI_lower,BenIRFAngI_50CI_upper,[204 88 37]/255,[204 88 37]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h4=jbfill(BenIRFAngI_timepoints,BenIRFAngI_95CI_lower,BenIRFAngI_95CI_upper,[204 88 37]/255,[204 88 37]/255,1,0.2);
hold on
    % %--- plot predictions from median of each parameter
   %plot(BenNRFAngI_timepoints,BenNRFAngI_CI_best,'--','color',[204 88 37]/255,'LineWidth',1.25);
ax = gca;
    ax.ColorOrderIndex = 1;
    plot(BenNRFt,BenNRFAngI_conc,'-.','linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(BenIRFt,BenIRFAngI_conc,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
        ax.ColorOrderIndex = 1;
    errorbar(BenNRFXdata,BenNRFYdata(2,:),BenNRFAngIerror,'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    errorbar(BenIRFXdata,BenIRFYdata(2,:),BenIRFAngIerror,'s','Marker','o','MarkerSize',3,'DisplayName',...
        'IRF data')

    
    hold off
    axis([-1 25 350 900])
    xlabel('Time (h)','FontName','Arial','FontSize',10) 
    ylabel('Ang I Conc. (pg ml^{-1})','Interpreter','Tex','FontName','Arial','FontSize',10)
% hasbehavior(h1, 'legend', false);   % line will not be in legend
hasbehavior(h2, 'legend', false);   % line will not be in legend
% hasbehavior(h3, 'legend', false);   % line will not be in legend
hasbehavior(h4, 'legend', false);   % line will not be in legend
        legend('-Dynamiclegend','Location','Northeast') 

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/CI_PE_ben_AngIvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
figure(4)
%     %--- shade 50% CI
%     h1=jbfill(CilNRFAngI_timepoints,CilNRFAngI_50CI_lower,CilNRFAngI_50CI_upper,[19 106 177]/255,[19 106 177]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h2=jbfill(CilNRFAngI_timepoints,CilNRFAngI_95CI_lower,CilNRFAngI_95CI_upper,[19 106 177]/255,[19 106 177]/255,1,0.2);
hold on
    %--- plot predictions from median of each parameter
   %plot(CilNRFAngI_timepoints,CilNRFAngI_CI_best,'-.','color',[19 106 177]/255,'LineWidth',1.25);
    hold on
%     %--- shade 50% CI
%     h3=jbfill(CilIRFAngI_timepoints,CilIRFAngI_50CI_lower,CilIRFAngI_50CI_upper,[204 88 37]/255,[204 88 37]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h4=jbfill(CilIRFAngI_timepoints,CilIRFAngI_95CI_lower,CilIRFAngI_95CI_upper,[204 88 37]/255,[204 88 37]/255,1,0.2);
hold on
    %--- plot predictions from median of each parameter
  %plot(CilNRFAngI_timepoints,CilNRFAngI_CI_best,'--','color',[204 88 37]/255,'LineWidth',1.25);
ax = gca;
    ax.ColorOrderIndex = 1;
    plot(CilNRFt,CilNRFAngI_conc,'-.','linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(CilIRFt,CilIRFAngI_conc,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax.ColorOrderIndex = 1;
   h= plot(CilNRFXdata,CilNRFYdata(2,:),'s','MarkerSize',3,'DisplayName',...
        'NRF data');
        set(h, 'MarkerFaceColor', get(h, 'Color'));
    plot(CilIRFXdata,CilIRFYdata(2,:),'s','MarkerSize',3,'Marker','o','DisplayName',...
        'IRF data')

    hold off
    axis([-1 25 0 500])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('Ang I Conc. (pg ml^{-1})','Interpreter','Tex','FontName','Arial','FontSize',10)
% hasbehavior(h1, 'legend', false);   % line will not be in legend
hasbehavior(h2, 'legend', false);   % line will not be in legend
% hasbehavior(h3, 'legend', false);   % line will not be in legend
hasbehavior(h4, 'legend', false);   % line will not be in legend
        legend('-Dynamiclegend','Location','best') 

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/CI_PE_cil_AngIvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
figure(5)
% %--- shade 50% CI
%     h1=jbfill(BenNRFPRA_timepoints,BenNRFPRA_50CI_lower,BenNRFPRA_50CI_upper,[19 106 177]/255,[19 106 177]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h2=jbfill(BenNRFPRA_timepoints,BenNRFPRA_95CI_lower,BenNRFPRA_95CI_upper,[19 106 177]/255,[19 106 177]/255,1,0.2);
hold on
    % %--- plot predictions from median of each parameter
   %plot(BenNRFPRA_timepoints,BenNRFPRA_CI_best,'-.','color',[19 106 177]/255,'LineWidth',1.25);
    hold on
%     %--- shade 50% CI
%     h3=jbfill(BenIRFPRA_timepoints,BenIRFPRA_50CI_lower,BenIRFPRA_50CI_upper,[204 88 37]/255,[204 88 37]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h4=jbfill(BenIRFPRA_timepoints,BenIRFPRA_95CI_lower,BenIRFPRA_95CI_upper,[204 88 37]/255,[204 88 37]/255,1,0.2);
hold on
    %--- plot predictions from median of each parameter
    %plot(BenNRFPRA_timepoints,BenNRFPRA_CI_best,'--','color',[204 88 37]/255,'LineWidth',1.25);
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(BenNRFt,BenNRFPRA,'-.','linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(BenIRFt,BenIRFPRA,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax.ColorOrderIndex = 1;
    errorbar(BenNRFXdata,BenNRFYdata(3,:),BenNRFPRAerror,'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    errorbar(BenIRFXdata,BenIRFYdata(3,:),BenIRFPRAerror,'s','Marker','o','MarkerSize',3,'DisplayName',...
        'IRF data')
    
    hold off
    axis([-1 25 0 3])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('PRA (ng ml^{-1} h^{-1})','Interpreter','Tex','FontSize',10,'FontName','Arial')
% hasbehavior(h1, 'legend', false);   % line will not be in legend
hasbehavior(h2, 'legend', false);   % line will not be in legend
% hasbehavior(h3, 'legend', false);   % line will not be in legend
hasbehavior(h4, 'legend', false);   % line will not be in legend
        legend('-Dynamiclegend','Location','SouthEast') 
    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/CI_PE_ben_PRAvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
figure(6)
%     %--- shade 50% CI
%     h1=jbfill(CilNRFPRA_timepoints,CilNRFPRA_50CI_lower,CilNRFPRA_50CI_upper,[19 106 177]/255,[19 106 177]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h2=jbfill(CilNRFPRA_timepoints,CilNRFPRA_95CI_lower,CilNRFPRA_95CI_upper,[19 106 177]/255,[19 106 177]/255,1,0.2);
hold on
    %--- plot predictions from median of each parameter
    %plot(CilNRFPRA_timepoints,CilNRFPRA_CI_best,'-.','color',[19 106 177]/255,'LineWidth',1.25);
    hold on
%    % --- shade 50% CI
%     h3=jbfill(CilIRFPRA_timepoints,CilIRFPRA_50CI_lower,CilIRFPRA_50CI_upper,[204 88 37]/255,[204 88 37]/255,0,0.2);
% hold on
    %--- shade 90% CI
    h4=jbfill(CilIRFPRA_timepoints,CilIRFPRA_95CI_lower,CilIRFPRA_95CI_upper,[204 88 37]/255,[204 88 37]/255,1,0.2);
hold on
    %--- plot predictions from median of each parameter
    %plot(CilNRFPRA_timepoints,CilNRFPRA_CI_best,'--','color',[204 88 37]/255,'LineWidth',1.25);
    ax = gca;
    ax.ColorOrderIndex = 1;    
    plot(CilNRFt,CilNRFPRA,'-.','linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(CilIRFt,CilIRFPRA,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax.ColorOrderIndex = 1; 
    h=plot(CilNRFXdata,CilNRFYdata(3,:),'s','MarkerSize',3,'DisplayName',...
        'NRF data');
    set(h, 'MarkerFaceColor', get(h, 'Color'));
    plot(CilIRFXdata,CilIRFYdata(3,:),'s','MarkerSize',3,'Marker','o','DisplayName',...
        'IRF data')
    hold on

    hold off
    axis([-1 25 0 15])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('PRA (ng ml^{-1} h^{-1})','Interpreter','Tex','FontSize',10,'FontName','Arial')
%     hasbehavior(h1, 'legend', false);   % line will not be in legend
hasbehavior(h2, 'legend', false);   % line will not be in legend
% hasbehavior(h3, 'legend', false);   % line will not be in legend
hasbehavior(h4, 'legend', false);   % line will not be in legend
        legend('-Dynamiclegend','Location','best') 
    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/CI_PE_cil_PRAvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
    