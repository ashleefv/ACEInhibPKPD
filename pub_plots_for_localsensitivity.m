%% Combines & constructs plots for local sensitivity output for all cases for PK-PD model for ACE inhibition
% Uses the output of param_estimation.m function 'sensitivity' for the four different
% drug and renalfunction cases are stored in localSens_drugnamerenalfunction.mat files.
BenNRF = matfile('localSens_benazeprilnormal.mat');
BenIRF = matfile('localSens_benazeprilimpaired.mat');
CilNRF = matfile('localSens_cilazaprilnormal.mat');
CilIRF = matfile('localSens_cilazaprilimpaired.mat');
stringCoefLabels = {'V_{max}/K_M','k_R','k_f','k_{AII}','f'};
x = 1:5;

green = [126 162 43]/255;
purple = [109 55 136]/255;
%gray = [143 143 145]/255;
A_AII = [BenNRF.A_AII(:,1) BenIRF.A_AII(:,1) CilNRF.A_AII(:,1) CilIRF.A_AII(:,1)];
A_AI = [BenNRF.A_AI(:,1) BenIRF.A_AI(:,1) CilNRF.A_AI(:,1) CilIRF.A_AI(:,1)];
A_PRA = [BenNRF.A_PRA(:,1) BenIRF.A_PRA(:,1) CilNRF.A_PRA(:,1) CilIRF.A_PRA(:,1)];

figure(1)
% at 2 hours which is the 2nd data point
% Show the effects of decreasing the parameters ['-' num2str(sensitivity_range*100) '%']
b=bar(x,A_AII);

b(1).FaceColor=purple;
b(2).FaceColor=purple;
b(3).FaceColor=purple;
b(4).FaceColor=purple;
b(1).EdgeColor = 'k';
b(2).EdgeColor = 'k';
b(3).EdgeColor = 'k';
b(4).EdgeColor = 'k';
b(1).LineWidth = 1;
b(2).LineWidth = 1;
b(3).LineWidth = 1;
b(4).LineWidth = 1;
% b(1).LineStyle = '--';
% b(2).LineStyle = '--';
% b(3).LineStyle = '--';
% b(4).LineStyle = '--';

alpha(b(1),1)
alpha(b(2),2/3)
alpha(b(3),1/3)
alpha(b(4),0)
% b(2).FaceColor = [143 143 145]/255;
set(gca,'YScale','log');
set(gca,'FontName','Arial','FontSize',10);

ylabel('Local Sensitivity of C_{AII}','FontName','Arial','FontSize',10,'Interpreter','Tex');
legend('Ben. NRF','Ben. IRF', 'Cil. NRF', 'Cil. IRF','Location','Southoutside','Orientation','horizontal')
ax = gca;
ax.XTickLabel = {stringCoefLabels{1},stringCoefLabels{2},stringCoefLabels{3},stringCoefLabels{4},stringCoefLabels{5},'FontName','Arial','FontSize',10};
set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 5 3]);
axis([0.5 5.5 10^(-9) 10])
ax.YTick= [1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0 1e1];
set(gca,'ygrid','on');
export_fig('pub_plots/localSens_AII','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');


figure(2)
% at 2 hours which is the 2nd data point
% Show the effects of decreasing the parameters ['-' num2str(sensitivity_range*100) '%']
b=bar(x,A_AI);

b(1).FaceColor=purple;
b(2).FaceColor=purple;
b(3).FaceColor=purple;
b(4).FaceColor=purple;
b(1).EdgeColor = 'k';
b(2).EdgeColor = 'k';
b(3).EdgeColor = 'k';
b(4).EdgeColor = 'k';
b(1).LineWidth = 1;
b(2).LineWidth = 1;
b(3).LineWidth = 1;
b(4).LineWidth = 1;
% b(1).LineStyle = '--';
% b(2).LineStyle = '--';
% b(3).LineStyle = '--';
% b(4).LineStyle = '--';

alpha(b(1),1)
alpha(b(2),2/3)
alpha(b(3),1/3)
alpha(b(4),0)
% b(2).FaceColor = [143 143 145]/255;
set(gca,'YScale','log');
set(gca,'FontName','Arial','FontSize',10);
grid on;
ylabel('Local Sensitivity of C_{AI}','FontName','Arial','FontSize',10,'Interpreter','Tex');
legend('Ben. NRF','Ben. IRF', 'Cil. NRF', 'Cil. IRF','Location','Southoutside','Orientation','horizontal')
ax = gca;
ax.XTickLabel = {stringCoefLabels{1},stringCoefLabels{2},stringCoefLabels{3},stringCoefLabels{4},stringCoefLabels{5},'FontName','Arial','FontSize',10};
set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 5 3]);
axis([0.5 5.5 10^(-9) 10])
ax.YTick= [1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0 1e1];
set(gca,'ygrid','on');
export_fig('pub_plots/localSens_AI','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');

figure(3)
% at 2 hours which is the 2nd data point
% Show the effects of decreasing the parameters ['-' num2str(sensitivity_range*100) '%']
b=bar(x,A_PRA);

b(1).FaceColor=purple;
b(2).FaceColor=purple;
b(3).FaceColor=purple;
b(4).FaceColor=purple;
b(1).EdgeColor = 'k';
b(2).EdgeColor = 'k';
b(3).EdgeColor = 'k';
b(4).EdgeColor = 'k';
b(1).LineWidth = 1;
b(2).LineWidth = 1;
b(3).LineWidth = 1;
b(4).LineWidth = 1;
% b(1).LineStyle = '--';
% b(2).LineStyle = '--';
% b(3).LineStyle = '--';
% b(4).LineStyle = '--';

alpha(b(1),1)
alpha(b(2),2/3)
alpha(b(3),1/3)
alpha(b(4),0)
% b(2).FaceColor = [143 143 145]/255;
set(gca,'YScale','log');
set(gca,'FontName','Arial','FontSize',10);
grid on;
ylabel('Local Sensitivity of PRA','FontName','Arial','FontSize',10,'Interpreter','Tex');
legend('Ben. NRF','Ben. IRF', 'Cil. NRF', 'Cil. IRF','Location','Southoutside','Orientation','horizontal')
ax = gca;
ax.XTickLabel = {stringCoefLabels{1},stringCoefLabels{2},stringCoefLabels{3},stringCoefLabels{4},stringCoefLabels{5},'FontName','Arial','FontSize',10};
set(gcf, 'Color', 'w','Units', 'inches', 'Position', [0 0 5 3]);
axis([0.5 5.5 10^(-9) 10])
ax.YTick= [1e-9 1e-8 1e-7 1e-6 1e-5 1e-4 1e-3 1e-2 1e-1 1e0 1e1];
set(gca,'ygrid','on');
export_fig('pub_plots/localSens_PRA','-r1000', '-a4', '-q101', '-painters', '-eps', '-png', '-tiff');