%-----------TASK 7-----------
testing = readtable('data_test2.txt');
training = readtable('data_train2.txt');

m = training(:,6); %Acceleration
n = training(:,1); %Miles per Gallon

%Explanatory variable
x = table2array(m);
%Dependent variable
y = table2array(n);

%Slide 1 of 6: Scatter plot
figure
scatter(x,y)
xlabel('x')
ylabel('y')
title('title')
hold on
grid on

%Slide 2 of 6: Line A
b1 = x\y;
yHat1 = x*b1; %Prediction
% -- Plotting begins : Line A
plot(x, yHat1)

%Slide 3 of 6: Line B
X = [ones(length(x),1) x]; %Only difference
b2 = X\y;
yHat2 = X*b2; %Prediction
% -- Plotting begins : Line B
plot(x,yHat2, '--')

%look at residuals (Report Avg least SQ error).
% -- compare Line A residuals with...
Rsq1 = 1 - sum((y - yHat1).^2)/sum((y - mean(y)).^2);% -- LINE A = 0.1985 <--less is the better fitting
% -- compare Line B residuals with...
Rsq2 = 1 - sum((y - yHat2).^2)/sum((y - mean(y)).^2);% -- LINE B = 0.2126

tbl = table(x, y);
model1 = fitlm(tbl, 'y ~ x')
% USING FITLM:
% -- Rsq Ordinary: 0.2126 < Line B
% -- Rsq Adjusted: 0.2099


%-----------TASK 8-----------

%Make a preditcion using the best fitting line

% model = fitlm (x,y)

%So, each model needs to be fitted. Make it model1 and model2 using fitlm.
x2 = testing(:,6); %Acceleration
y2 = testing(:,1); %Miles per Gallon

%Explanatory variable
X2 = table2array(x2);
%Dependent variable
Y2 = table2array(y2);

%{
model1 = fitlm(X2, Rsq1); %Acceleration
model2 = fitlm(Y2, Rsq1); %Miles per Gallon

%Then do this again
% -- compare Line A residuals with...
Rsq1 = 1 - sum((Y1 - yHat1).^2)/sum((Y1 - mean(Y1)).^2)
% -- compare Line B residuals with...
Rsq2 = 1 - sum((Y1 - yHat2).^2)/sum((Y1 - mean(Y1)).^2)
%}