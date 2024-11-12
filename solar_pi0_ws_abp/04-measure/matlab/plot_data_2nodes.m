%% =============== clear & setup path =================================================================================================
clearvars                                % clear all previous data in MATLAB workspace
clc                                      % clear MATLAB command window
close all                                % close all previously opened figures and graphs

% =====================================================================================================================================
% ================================                  Plot Battery Voltage Measurements                   ===============================
% =====================================================================================================================================
%% print parameters
%set(0,'DefaultFigureWindowStyle','docked');
set(0,'DefaultAxesFontSize', 20);
set(0,'DefaultTextFontSize', 20);
set(0,'DefaultlineLineWidth', 1.5);

fileID = fopen('/Users/gwongwen/Documents/projects/youpi/02-fig-jan23/N223/meas_N223_L14.txt','r');

indata = textscan(fileID, '%f', 'HeaderLines',1);   % read all the data into indata and delete first line (date)
fclose(fileID);
y = indata{1};

x = (0:length(y)-1)*5;
x = x';

coeff = polyfit(x,y,1);
yfit = polyval(coeff,x);

a1str = num2str(coeff(1)*1000);
a0str = num2str(coeff(2));
eqnstr = ['linear: y = ', a1str, '*10^{-3}*x +', a0str, ''];

yresid = y - yfit;
SSresid = sum(yresid.^2);
SStotal = (length(y)-1) * var(y);
rsq = 1 - SSresid/SStotal;
rsq_adj = 1 - SSresid/SStotal * (length(y)-1)/(length(y)-length(coeff));
rsqstr = ['R^2 = ', num2str(rsq_adj)];

fileID = fopen('/Users/gwongwen/Documents/projects/youpi/02-fig-jan23/N223/meas_N223_L14.txt','r');

indata = textscan(fileID, '%f', 'HeaderLines',1);   % read all the data into indata and delete first line (date)
fclose(fileID);
y1 = indata{1};

x1 = (0:length(y1)-1)*5;
x1 = x1';

coeff1 = polyfit(x1,y1,1);
yfit1 = polyval(coeff1,x1);

a1str1 = num2str(coeff1(1)*1000);
a0str1 = num2str(coeff1(2));
eqnstr1 = ['linear: y = ', a1str1, '*10^{-3}*x +', a0str1, ''];

yresid1 = y1 - yfit1;
SSresid1 = sum(yresid1.^2);
SStotal1 = (length(y1)-1) * var(y1);
rsq1 = 1 - SSresid1/SStotal1;
rsq_adj1 = 1 - SSresid1/SStotal1 * (length(y1)-1)/(length(y1)-length(coeff1));
rsqstr1 = ['R^2 = ', num2str(rsq_adj1)];

figure
plot(x,y,'b');
hold on
plot(x,yfit,'r')
hold on
plot(x1,y1,'k');
hold on
plot(x1,yfit1,'r')

%title('Discharge N222 & N223 - Only Battery - LED ON - Wifi ON');

xlabel('time [min]');
ylabel('battery level [volt]');
legend('data node N222','linear','data node N223','linear');
text(20,3.8,{eqnstr,rsqstr});
text(20,3.3,{eqnstr1,rsqstr1});
grid on;