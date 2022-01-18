clear; close all; clc;

testing = readtable('data_test2.txt');
training = readtable('data_train2.txt');

%-------- TASK 9: TRAINING MODEL --------

x1 = training(:,4); %Train hor - Explanatory Variable
y1 = training(:,1); %Train mpg - Dependant Variable
x2 = testing(:,4); %Testing hor - Explanatory Variable
y2 = testing(:,1); %Testing mpg - Dependant Variable

format short

%Convert txt file(table) to array

x = table2array(x1); 
y = table2array(y1); 
X = table2array(x2); %X vector of new value for predictor variable
Y = table2array(y2); %Ground Truth

Pad = [ones(length(x),1) x]; %10^2 = padding the data with a column of ones 

%(A*x = B) Solves linear system: '\' (x1,y1),(x2,y2),(x3,y3)...(xn,yn) 

B1 = x\y; %The relation becomes Y = B1x 
yR1 = B1*x; %Calculation for line 1
B0 = Pad\y; %The relation becomes Y = B0 + B1x (Padded, 10^2) Is it 10??
yR2 = Pad*B0; %Calculation for line 2

subplot(2,1,1)
scatter(x, y) %Scatter plot of linear training model
trainTable = table(x, y); %Training data is formatted to a table
trainModel = fitlm(trainTable) %The table data is fitted to a linear model

hold on
plot(trainModel) %Plot model and compare plotted lines against confidence bounds.
plot(x,yR1) %Plot 1st linear regression (Y = B1x)
plot(x,yR2) %Plot 2nd linear regression (Y = B0 + B1x)
xlabel('Horse Power')
ylabel('Miles per Gallon')
title('Horse Power V Miles per Gallon: Trained Linear Regression Model')
hold off

%Average Training Least Square (Residuals Sq)
%Root Mean Sq Eror = 3.79
%Original Train Rsq = 0.641
%Adjusted Train Rsq = 0.64(For the number of coefficients)

A = trainModel.Coefficients.Estimate(2); %Coefficient A = 34.777 (Intercept)
B = trainModel.Coefficients.Estimate(1); %Coefficient B = -0.1251 (Slope of line)


%-------- TASK 10a: TEST MODEL --------

testTable = table(X,Y);
testModel = fitlm(testTable)

%Average Testing Least Square (Residuals Sq)
%Root Mean Sq Eror = 4.4
%Original Test Rsq = 0.451
%Adjusted Test Rsq = 0.445 (For the number of coefficients)

%{
%Scatter plot of linear testing model
scatter(X,Y)
hold on
plot(testModel)
subplot(3,1,2)
%}


%-------- TASK 10b: GROUND TRUTH and PREDICTION ------

yHat = (A*X) + B; %yHat = ax + b
%score = yHat - Y; %score is the difference between the ground truth and prediction

% remember ; or , !!!
gvpAvg = [mean(Y); mean(yHat)]; %Mean of Ground Truth and Prediction
gvpMed = [median(Y); median(yHat)]; %Median of Ground Truth and Prediction
gvpMin = [min(Y); min(yHat)]; %Mean of Ground Truth and Prediction
gvpMax = [max(Y); max(yHat)]; %Median of Ground Truth and Prediction
gvpStD = [std(Y); std(yHat)]; %Mean of Ground Truth and Prediction

allVar = ["GroundTruth"; "Prediction"];
gtPred = table(allVar, gvpAvg ,gvpMed, gvpMin, gvpMax, gvpStD, 'VariableNames',...
    {'Descriptor', 'Mean', 'Median', 'Min', 'Max', 'Standard_Deviation'})

scrAvg = gtPred{2,2} - gtPred{1,2};
scrMed = gtPred{2,3} - gtPred{1,3};
scrMin = gtPred{2,4} - gtPred{1,4};
scrMax = gtPred{2,5} - gtPred{1,5};
scrStD = gtPred{2,6} - gtPred{1,6};

allScr = table("All Scores", scrAvg, scrMed, scrMin, scrMax, scrStD, 'VariableNames',...
    {'Descriptor', 'Mean', 'Median', 'Min', 'Max', 'Standard_Deviation'})

%{
score = y2 - yHat; %score is the difference between the ground truth and prediction

table(y2(1:96), yHat(1:96), score(1:96),'VariableNames',...
    {'GroundTruth','Prediction','Score'})
%}
    
subplot(2,1,2)
scatter(Y, yHat) %Prediction (Training Model vs Test Acc)
groundAndPred = fitlm(Y, yHat);
hold on
plot(groundAndPred);
xlabel('Horse Power') 
ylabel('Miles per Gallon') 
title('Horse Power V Miles per Gallon: Ground Truth and Prediction')