clear; close all; clc;

testing = readtable('data_test2.txt');
training = readtable('data_train2.txt');

%-------- TASK 11: TRAINING MODEL --------

x1 = training(:,5); %Train wgt - Explanatory Variable
y1 = training(:,4); %Train hor - Dependant Variable
x2 = testing(:,5); %Testing wgt - Explanatory Variable
y2 = testing(:,4); %Testing hor - Dependant Variable

format short

%Convert txt file(table) to array

x = table2array(x1); 
y = table2array(y1); 
X = table2array(x2); %X vector of new value for predictor variable
Y = table2array(y2); %Ground Truth

Pad = [ones(length(x),1) x]; %10^2 = padding the data with a column of ones 

%(A*x = B) Solves linear system = '\':(x1,y1),(x2,y2),(x3,y3)...(xn,yn) 

B1 = x\y; %The relation becomes Y = B1x 
yR1 = B1*x; %Calculation for line 1
B0 = Pad\y; %The relation becomes Y = B0 + B1x (Padded, 10^2) Is it 10??
yR2 = Pad*B0; %Calculation for line 2

subplot(2,1,1)
scatter(x, y) %Scatter plot of linear training model
TrainTable = table(x, y); %Training data is formatted to a table
TrainModel = fitlm(TrainTable) %The table data is fitted to a linear model

hold on
plot(TrainModel) %Plot model and compare plotted lines against confidence bounds.
plot(x,yR1) %Plot 1st linear regression (Y = B1x)
plot(x,yR2) %Plot 2nd linear regression (Y = B0 + B1x)
xlabel('Acceleration')
ylabel('Miles per Gallon')
title('Acceleration V Mpg: Trained Linear Regression Model')
hold off

%Average Training Least Square (Residuals Sq)
%Root Mean Sq Eror = 5.61
%Original Train Rsq = 0.2126
%Adjusted Train Rsq = 0.2099 (For the number of coefficients)

Res = TrainModel.Residuals.Raw;

resMin = min(Res);
res1Qt = prctile(Res,25);
resMed = median(Res);
res3Qt = prctile(Res,75);
resMax = max(Res);

TrainResiduals = table(resMin, res1Qt, resMed, res3Qt, resMax, 'VariableNames',...
    {'Min', 'FirstQuarter', 'Median', 'ThirdQuarter', 'Max'})

A = TrainModel.Coefficients.Estimate(2); %Coefficient A = 4.304 (Intercept)
B = TrainModel.Coefficients.Estimate(1); %Coefficient B = 1.082 (Slope of line)


%--------TASK 8a: TEST MODEL --------

TestTable = table(X,Y);
TestModel = fitlm(TestTable)

%Average Testing Least Square (Residuals Sq)
%Root Mean Sq Eror = 5.91
%Original Test Rsq = 0.0109
%Adjusted Test Rsq = 4.1550 (For the number of coefficients)

Res2 = TestModel.Residuals.Raw;

resMin2 = min(Res2);
res1Qt2 = prctile(Res2,25);
resMed2 = median(Res2);
res3Qt2 = prctile(Res2,75);
resMax2 = max(Res2);

TestResiduals = table(resMin2, res1Qt2, resMed2, res3Qt2, resMax2, 'VariableNames',...
    {'Min', 'FirstQuarter', 'Median', 'ThirdQuarter', 'Max'})


%-------- TASK 8b: GROUND TRUTH and PREDICTION ------

yHat = (A*X) + B; %yHat = ax + b
%score = yHat - Y; %score is the difference between the ground truth and prediction
    
subplot(2,1,2)
sz = 50;
scatter(Y, yHat, 50, 'r', 'filled') %Prediction (Training Model vs Test Acc)
GTPModel = fitlm(Y, yHat)
%hold on
%plot(gtPredModel);
xlabel('Acceleration') 
ylabel('Miles per Gallon') 
title('Acceleration V Mpg: Ground Truth and Prediction')

GTP_Pvalue = GTPModel.Coefficients.pValue %Probability values from the model


%-------- TASK 8c: GROUND TRUTH and PREDICTION COMPARISON (Min, Med, Max) ------

gvpMin = [min(Y); min(yHat)]; %Mean of Ground Truth and Prediction
gvpMed = [median(Y); median(yHat)]; %Median of Ground Truth and Prediction
gvpMax = [max(Y); max(yHat)]; %Median of Ground Truth and Prediction
gvpSm1 = gvpMin(1) - gvpMin(2);
gvpSm2 = gvpMed(1) - gvpMed(2);
gvpSm3 = gvpMax(1) - gvpMax(2);
gvpTb1 = [gvpMin; gvpSm1];
gvpTb2 = [gvpMed; gvpSm2];
gvpTb3 = [gvpMax; gvpSm3];

allVar = ["GroundTruth"; "Prediction"; "Difference"];
GTPTable = table(allVar, gvpTb1, gvpTb2, gvpTb3, 'VariableNames',...
    {'Descriptor', 'Min', 'Median', 'Max'})


%-------- TASK 8d: NORMAL DISTRIBUTION and P-VALUES ------

GTNormDist = fitdist(Y,'Normal')
GTmu = GTNormDist.mu;
GTsigma = GTNormDist.sigma;

Y = [-3,-2,-1,0,1,2,3];
GTNormPval = normcdf(Y,GTmu,GTsigma)


PredNormDist = fitdist(yHat,'Normal')
Predmu = PredNormDist.mu;
Predsigma = PredNormDist.sigma;

yHat = [-3,-2,-1,0,1,2,3];
PredNormPval = normcdf(yHat,Predmu,Predsigma)
