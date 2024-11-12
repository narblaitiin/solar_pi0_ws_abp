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

%fileID = fopen('/Users/gwongwen/Documents/projects/youpi/02-fig-jan23/N221/meas_N221_L07.txt','r');
%fileID = fopen('/Users/gwongwen/Documents/projects/youpi/03-fig-feb23/N222/meas_N222_L03.txt','r');
%fileID = fopen('/Users/gwongwen/Documents/projects/youpi/02-fig-jan23/N223/meas_N223_L14.txt','r');
%y = fscanf(fileID, '%f'); % read all the data into y

indata = textscan(fileID, '%f', 'HeaderLines',1);   % read all the data into indata and delete first line (date)
fclose(fileID);
y1 = indata{1};

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

figure
plot(x,y,'b');
hold on
plot(x,yfit,'r')

%title('Disharge Node 221 - Battery & Solar Panel -  - LED ON - Wifi ON');
%title('Disharge Node 221 - Battery Only -  - LED ON - Wifi ON');

%title('Disharge Node 222 - Battery & Solar Panel - Idle State - LED ON - Wifi ON');
%title('Disharge Node 222 - Battery Only - Idle State - LED ON - Wifi ON');

%title('Disharge Node 223 - Battery & Solar Panel - Lora Packets every 100ms - LED ON - Wifi ON');
%title('Disharge Node 223 - Battery Only - Lora Packets every 100ms & Stress Mode - LED ON - Wifi ON');

xlabel('time [min]');
ylabel('battery level [volt]');
legend('data','linear');
text(20,3.74,{eqnstr,rsqstr});
grid on;