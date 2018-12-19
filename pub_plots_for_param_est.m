%% Combines & constructs plots for parameter estimation output for all cases for PK-PD model for ACE inhibition
% Uses the output of param_estimation.m function for the four different
% drug and renalfunction cases are stored in PE_drugnamerenalfunction.mat files.
close all
BenNRF = matfile('PE_benazeprilnormal.mat');
BenIRF = matfile('PE_benazeprilimpaired.mat');
CilNRF = matfile('PE_cilazaprilnormal.mat');
CilIRF = matfile('PE_cilazaprilimpaired.mat');
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
set(0,'DefaultAxesColorOrder',[19 106 177; 204 88 37; 126 ...
    162 43; 109 55 136; 143 143 145]/255)
figure(1)
    plot(BenNRFt,BenNRFAngII_conc,'linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(BenIRFt,BenIRFAngII_conc,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax = gca;
    ax.ColorOrderIndex = 1;
    errorbar(BenNRFXdata,BenNRFYdata(1,:),BenNRFAngIIerror,'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    errorbar(BenIRFXdata,BenIRFYdata(1,:),BenIRFAngIIerror,'s','MarkerSize',3,'DisplayName',...
        'IRF data')
    hold off
    axis([-1 25 0 25])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('Ang II Conc. (pg ml^{-1})','FontName','Arial','FontSize',10)
    legend('-Dynamiclegend','Location','North')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/PE_ben_AngIIvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');

figure(2)
    plot(CilNRFt,CilNRFAngII_conc,'linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(CilIRFt,CilIRFAngII_conc,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(CilNRFXdata,CilNRFYdata(1,:),'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    plot(CilIRFXdata,CilIRFYdata(1,:),'s','MarkerSize',3,'DisplayName',...
        'IRF data')
    hold off
    axis([-1 25 0 40])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('Ang II Conc. (pg ml^{-1})','FontName','Arial','FontSize',10)
    legend('-Dynamiclegend','Location','North')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/PE_cil_AngIIvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
figure(3)
    plot(BenNRFt,BenNRFAngI_conc,'linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(BenIRFt,BenIRFAngI_conc,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax = gca;
    ax.ColorOrderIndex = 1;
    errorbar(BenNRFXdata,BenNRFYdata(2,:),BenNRFAngIerror,'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    errorbar(BenIRFXdata,BenIRFYdata(2,:),BenIRFAngIerror,'s','MarkerSize',3,'DisplayName',...
        'IRF data')
    hold off
    axis([-1 25 0 1200])
    xlabel('Time (h)','FontName','Arial','FontSize',10) 
    ylabel('Ang I Conc. (pg ml^{-1})','Interpreter','Tex','FontName','Arial','FontSize',10)
    legend('-Dynamiclegend','Location','NorthEast')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/PE_ben_AngIvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
figure(4)
    plot(CilNRFt,CilNRFAngI_conc,'linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(CilIRFt,CilIRFAngI_conc,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(CilNRFXdata,CilNRFYdata(2,:),'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    plot(CilIRFXdata,CilIRFYdata(2,:),'s','MarkerSize',3,'DisplayName',...
        'IRF data')
    hold off
    axis([-1 25 0 1000])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('Ang I Conc. (pg ml^{-1})','Interpreter','Tex','FontName','Arial','FontSize',10)
    legend('-Dynamiclegend','Location','North')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/PE_cil_AngIvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
figure(5)
    plot(BenNRFt,BenNRFPRA,'linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(BenIRFt,BenIRFPRA,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax = gca;
    ax.ColorOrderIndex = 1;
    errorbar(BenNRFXdata,BenNRFYdata(3,:),BenNRFPRAerror,'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    errorbar(BenIRFXdata,BenIRFYdata(3,:),BenIRFPRAerror,'s','MarkerSize',3,'DisplayName',...
        'IRF data')
    hold off
    axis([-1 25 0 8])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('PRA (ng ml^{-1} h^{-1})','Interpreter','Tex','FontSize',10,'FontName','Arial')
    legend('-Dynamiclegend','Location','North')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/PE_ben_PRAvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
figure(6)
    plot(CilNRFt,CilNRFPRA,'linewidth',1.25,'DisplayName',...
        'NRF fit')
    hold on
    plot(CilIRFt,CilIRFPRA,'--','linewidth',1.25,'DisplayName',...
        'IRF fit')
    ax = gca;
    ax.ColorOrderIndex = 1;
    plot(CilNRFXdata,CilNRFYdata(3,:),'s','MarkerSize',3,'MarkerfaceColor','auto','DisplayName',...
        'NRF data')
    plot(CilIRFXdata,CilIRFYdata(3,:),'s','MarkerSize',3,'DisplayName',...
        'IRF data')
    hold off
    axis([-1 25 0 30])
    xlabel('Time (h)','FontName','Arial','FontSize',10)
    ylabel('PRA (ng ml^{-1} h^{-1})','Interpreter','Tex','FontSize',10,'FontName','Arial')
    legend('-Dynamiclegend','Location','North')

    get(gca);set(gca,'FontSize',10,'FontName','Arial');
    set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 3.5 2.5]);
    export_fig('pub_plots/PE_cil_PRAvstime','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');