%% Combines & constructs plots for global sensitivity output for all cases for PK-PD model for ACE inhibition
% Uses the output of param_estimation.m function 'eFAST' for the four different
% drug and renalfunction cases are stored in globalSens_drugnamerenalfunction.mat files.
BenNRF = matfile('globalSens_benazeprilnormal.mat');
BenIRF = matfile('globalSens_benazeprilimpaired.mat');
CilNRF = matfile('globalSens_cilazaprilnormal.mat');
CilIRF = matfile('globalSens_cilazaprilimpaired.mat');
efast_var={'V_{max}/K_M','k_R','k_f','k_{AII}','f','dummy'};
x=1:5;
red = [102, 0, 0]/255;%[126 162 43]/255;

BenNRFA_AII=[BenNRF.Si(1:3,1,1) BenNRF.Sti(1:3,1,1); BenNRF.Si(5,1,1) BenNRF.Sti(5,1,1); BenNRF.Si(4,1,1) BenNRF.Sti(4,1,1)];
BenNRFA_AI = [BenNRF.Si(1:3,1,2) BenNRF.Sti(1:3,1,2); BenNRF.Si(5,1,2) BenNRF.Sti(5,1,2); BenNRF.Si(4,1,2) BenNRF.Sti(4,1,2)];
BenNRFA_PRA = [BenNRF.Si(1:3,1,3) BenNRF.Sti(1:3,1,3); BenNRF.Si(5,1,3) BenNRF.Sti(5,1,3); BenNRF.Si(4,1,3) BenNRF.Sti(4,1,3)];

BenIRFA_AII=[BenIRF.Si(1:3,1,1) BenIRF.Sti(1:3,1,1); BenIRF.Si(5,1,1) BenIRF.Sti(5,1,1); BenIRF.Si(4,1,1) BenIRF.Sti(4,1,1)];
BenIRFA_AI = [BenIRF.Si(1:3,1,2) BenIRF.Sti(1:3,1,2); BenIRF.Si(5,1,2) BenIRF.Sti(5,1,2); BenIRF.Si(4,1,2) BenIRF.Sti(4,1,2)];
BenIRFA_PRA = [BenIRF.Si(1:3,1,3) BenIRF.Sti(1:3,1,3); BenIRF.Si(5,1,3) BenIRF.Sti(5,1,3); BenIRF.Si(4,1,3) BenIRF.Sti(4,1,3)];

CilNRFA_AII=[CilNRF.Si(1:3,1,1) CilNRF.Sti(1:3,1,1); CilNRF.Si(5,1,1) CilNRF.Sti(5,1,1); CilNRF.Si(4,1,1) CilNRF.Sti(4,1,1)];
CilNRFA_AI = [CilNRF.Si(1:3,1,2) CilNRF.Sti(1:3,1,2); CilNRF.Si(5,1,2) CilNRF.Sti(5,1,2); CilNRF.Si(4,1,2) CilNRF.Sti(4,1,2)];
CilNRFA_PRA = [CilNRF.Si(1:3,1,3) CilNRF.Sti(1:3,1,3); CilNRF.Si(5,1,3) CilNRF.Sti(5,1,3); CilNRF.Si(4,1,3) CilNRF.Sti(4,1,3)];

CilIRFA_AII=[CilIRF.Si(1:3,1,1) CilIRF.Sti(1:3,1,1); CilIRF.Si(5,1,1) CilIRF.Sti(5,1,1); CilIRF.Si(4,1,1) CilIRF.Sti(4,1,1)];
CilIRFA_AI = [CilIRF.Si(1:3,1,2) CilIRF.Sti(1:3,1,2); CilIRF.Si(5,1,2) CilIRF.Sti(5,1,2); CilIRF.Si(4,1,2) CilIRF.Sti(4,1,2)];
CilIRFA_PRA = [CilIRF.Si(1:3,1,3) CilIRF.Sti(1:3,1,3); CilIRF.Si(5,1,3) CilIRF.Sti(5,1,3); CilIRF.Si(4,1,3) CilIRF.Sti(4,1,3)];

A_AII = [BenNRFA_AII(:,1) BenIRFA_AII(:,1) CilNRFA_AII(:,1) CilIRFA_AII(:,1),...
    BenNRFA_AII(:,2) BenIRFA_AII(:,2) CilNRFA_AII(:,2) CilIRFA_AII(:,2)];
A_AI = [BenNRFA_AI(:,1) BenIRFA_AI(:,1) CilNRFA_AI(:,1) CilIRFA_AI(:,1),...
    BenNRFA_AI(:,2) BenIRFA_AI(:,2) CilNRFA_AI(:,2) CilIRFA_AI(:,2)];
A_PRA = [BenNRFA_PRA(:,1) BenIRFA_PRA(:,1) CilNRFA_PRA(:,1) CilIRFA_PRA(:,1),...
    BenNRFA_PRA(:,2) BenIRFA_PRA(:,2) CilNRFA_PRA(:,2) CilIRFA_PRA(:,2)];

figure(1)
b=bar(x,A_AII);

b(1).FaceColor=red;
b(2).FaceColor=red;
b(3).FaceColor=red;
b(4).FaceColor=red;
b(5).FaceColor=red;
b(6).FaceColor=red;
b(7).FaceColor=red;
b(8).FaceColor=red;
b(1).EdgeColor = 'k';
b(2).EdgeColor = 'k';
b(3).EdgeColor = 'k';
b(4).EdgeColor = 'k';
b(5).EdgeColor = 'k';
b(6).EdgeColor = 'k';
b(7).EdgeColor = 'k';
b(8).EdgeColor = 'k';
b(1).LineWidth = 1;
b(2).LineWidth = 1;
b(3).LineWidth = 1;
b(4).LineWidth = 1;
b(5).LineWidth = 1;
b(6).LineWidth = 1;
b(7).LineWidth = 1;
b(8).LineWidth = 1;
b(5).LineStyle = '--';
b(6).LineStyle = '--';
b(7).LineStyle = '--';
b(8).LineStyle = '--';

alpha(b(1),1)
alpha(b(2),2/3)
alpha(b(3),1/3)
alpha(b(4),0)
alpha(b(5),1)
alpha(b(6),2/3)
alpha(b(7),1/3)
alpha(b(8),0)

ax = gca;
ax.XTickLabel = {efast_var{1},efast_var{2},efast_var{3},efast_var{4},efast_var{5},'FontName','Arial','FontSize',10};
% columnlegend(4,{'S_k Ben. NRF','S_k Ben. IRF', 'S_k Cil. NRF', 'S_k Cil. IRF','S_{Tk} Ben. NRF','S_{Tk} Ben. IRF', 'S_{Tk} Cil. NRF', 'S_{Tk} Cil. IRF'},'Location','Southoutside')
legend('Ben. NRF','Ben. IRF', 'Cil. NRF', 'Cil. IRF','Location','Southoutside','Orientation','horizontal')
ylabel('Global Sensitivity of C_{AII}','FontName','Arial','FontSize',10,'Interpreter','Tex')
set(gca,'FontName','Arial','FontSize',10);
set(gca,'YScale','log');
set(gca,'ygrid','on');
axis([0.5 5.5 1e-4 1])
set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 5 3]);
% export_fig('pub_plots/globalSens_AII','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');


figure(2)
b=bar(x,A_AI);

b(1).FaceColor=red;
b(2).FaceColor=red;
b(3).FaceColor=red;
b(4).FaceColor=red;
b(5).FaceColor=red;
b(6).FaceColor=red;
b(7).FaceColor=red;
b(8).FaceColor=red;
b(1).EdgeColor = 'k';
b(2).EdgeColor = 'k';
b(3).EdgeColor = 'k';
b(4).EdgeColor = 'k';
b(5).EdgeColor = 'k';
b(6).EdgeColor = 'k';
b(7).EdgeColor = 'k';
b(8).EdgeColor = 'k';
b(1).LineWidth = 1;
b(2).LineWidth = 1;
b(3).LineWidth = 1;
b(4).LineWidth = 1;
b(5).LineWidth = 1;
b(6).LineWidth = 1;
b(7).LineWidth = 1;
b(8).LineWidth = 1;
b(5).LineStyle = '--';
b(6).LineStyle = '--';
b(7).LineStyle = '--';
b(8).LineStyle = '--';

alpha(b(1),1)
alpha(b(2),2/3)
alpha(b(3),1/3)
alpha(b(4),0)
alpha(b(5),1)
alpha(b(6),2/3)
alpha(b(7),1/3)
alpha(b(8),0)

ax = gca;
ax.XTickLabel = {efast_var{1},efast_var{2},efast_var{3},efast_var{4},efast_var{5},'FontName','Arial','FontSize',10};
% columnlegend(4,{'S_k Ben. NRF','S_k Ben. IRF', 'S_k Cil. NRF', 'S_k Cil. IRF','S_{Tk} Ben. NRF','S_{Tk} Ben. IRF', 'S_{Tk} Cil. NRF', 'S_{Tk} Cil. IRF'},'Location','Southoutside')
legend('Ben. NRF','Ben. IRF', 'Cil. NRF', 'Cil. IRF','Location','Southoutside','Orientation','horizontal')
ylabel('Global Sensitivity of C_{AI}','FontName','Arial','FontSize',10,'Interpreter','Tex')
set(gca,'FontName','Arial','FontSize',10);
set(gca,'YScale','log');
set(gca,'ygrid','on');
axis([0.5 5.5 1e-4 1])
set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 5 3]);
export_fig('pub_plots/globalSens_AI','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');

figure(3)
b=bar(x,A_PRA);

b(1).FaceColor=red;
b(2).FaceColor=red;
b(3).FaceColor=red;
b(4).FaceColor=red;
b(5).FaceColor=red;
b(6).FaceColor=red;
b(7).FaceColor=red;
b(8).FaceColor=red;
b(1).EdgeColor = 'k';
b(2).EdgeColor = 'k';
b(3).EdgeColor = 'k';
b(4).EdgeColor = 'k';
b(5).EdgeColor = 'k';
b(6).EdgeColor = 'k';
b(7).EdgeColor = 'k';
b(8).EdgeColor = 'k';
b(1).LineWidth = 1;
b(2).LineWidth = 1;
b(3).LineWidth = 1;
b(4).LineWidth = 1;
b(5).LineWidth = 1;
b(6).LineWidth = 1;
b(7).LineWidth = 1;
b(8).LineWidth = 1;
b(5).LineStyle = '--';
b(6).LineStyle = '--';
b(7).LineStyle = '--';
b(8).LineStyle = '--';

alpha(b(1),1)
alpha(b(2),2/3)
alpha(b(3),1/3)
alpha(b(4),0)
alpha(b(5),1)
alpha(b(6),2/3)
alpha(b(7),1/3)
alpha(b(8),0)

ax = gca;
ax.XTickLabel = {efast_var{1},efast_var{2},efast_var{3},efast_var{4},efast_var{5},'FontName','Arial','FontSize',10};
% columnlegend(4,{'S_k Ben. NRF','S_k Ben. IRF', 'S_k Cil. NRF', 'S_k Cil. IRF','S_{Tk} Ben. NRF','S_{Tk} Ben. IRF', 'S_{Tk} Cil. NRF', 'S_{Tk} Cil. IRF'},'Location','Southoutside')
legend('Ben. NRF','Ben. IRF', 'Cil. NRF', 'Cil. IRF','Location','Southoutside','Orientation','horizontal')
ylabel('Global Sensitivity of C_{PRA}','FontName','Arial','FontSize',10,'Interpreter','Tex')
set(gca,'FontName','Arial','FontSize',10);
set(gca,'YScale','log');
set(gca,'ygrid','on');
axis([0.5 5.5 1e-4 1])
set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 5 3]);
export_fig('pub_plots/globalSens_PRA','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');
