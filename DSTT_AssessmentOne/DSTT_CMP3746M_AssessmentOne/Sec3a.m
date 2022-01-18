clear; close all; clc;

%-------- DATA PREPERATION --------

testing = readtable('data_test2.txt');
training = readtable('data_train2.txt');

x1 = training(:,6); %Train acc - Explanatory Variable
y1 = training(:,1); %Train mpg - Dependant Variable
x2 = testing(:,6); %Testing acc - Explanatory Variable
y2 = testing(:,1); %Testing mpg - Dependant Variable

format short

%Convert txt file(table) to array
x = table2array(x1); 
y = table2array(y1); 
X = table2array(x2); %X vector of new value for predictor variable
Y = table2array(y2); %Ground Truth


%-------- TASK 7a: LINES of REGRESSION --------

%(A*x = B) Solves linear system = '\':(x1,y1),(x2,y2),(x3,y3)...(xn,yn) 
B1 = x\y; 
yR1 = x*B1; %The relation becomes Y = B1x 
Pad = [ones(length(x),1) x]; %10^2 = Padding the data with a column of ones 
B0 = Pad\y; 
yR2 = Pad*B0; %The relation becomes Y = B0 + B1x (Padded, 10^2)
[ply,S] = polyfit(x,y,1); %Polynomial fit and S = error estimation structure
[yFit,delta] = polyval(ply,x,S); %Delta returns the standard error estimate

%Testing yR1 and yR2 to see which is the line of best fit.
Rsq1 = 1 - sum((y - yR1).^2)/sum((y - mean(y)).^2); %R^2 value
Rsq2 = 1 - sum((y - yR2).^2)/sum((y - mean(y)).^2); %R^2 value (with padding for better fit)
TrainTable = table(x, y); %Training data is formatted to a table
TrainModel = fitlm(TrainTable) %The table data is fitted to a linear model


%-------- TASK 7b: TRAINING LINEAR MODEL with 95% PREDICTION INTERVAL --------

figure
subplot(2,2,1)
scatter(x, y) %Scatter plot of linear training model
hold on 
plot(x,yR1) %Plot 1st linear regression (Y = B1x)
plot(x,yR2) %Plot 2nd linear regression (Y = B0 + B1x)
plot(x,yFit+2*delta,'m--',x,yFit-2*delta,'m--') % 95% confidence boundary (2* deviations)
xlabel('Acceleration')
ylabel('Miles per Gallon')
title('Acceleration V Mpg: Trained Linear Regression Model (95% Prediction Interval)')
legend('Observation','1st Regression', '2nd Regression','95% Prediction Interval')
hold off 


%-------- TASK 7c: TRAINING LINEAR MODEL COMPARISON --------

subplot(2,2,2)
scatter(x, y) %Scatter plot of linear training model
hold on 
plot(TrainModel)
plot(x,yR1) %Plot 1st linear regression (Y = B1x)
plot(x,yR2) %Plot 2nd linear regression (Y = B0 + B1x)
xlabel('Acceleration')
ylabel('Miles per Gallon')
title('Acceleration V Mpg: Trained Linear Regression Model (Model Comparison)')
legend('Scatter Observation', 'Model Observation', 'Model: Best Fit', 'Upper Confidence Boundary', 'Lower Confidence Boundary', '1st Manual Regression', '2nd Manual Regression')
hold off 

TrainAnalysis = anova(TrainModel,'summary') %Interpretation of train model

%-------- TASK 7d: EXTRACT COEFFICIENTS --------

a = TrainModel.Coefficients.Estimate(2); %Coefficient A (Slope of line)
b = TrainModel.Coefficients.Estimate(1); %Coefficient B (Intercept)


%--------TASK 8a: TEST MODEL --------

TestTable = table(X,Y); %Create table of test data
TestModel = fitlm(TestTable) %Fit test table data to a linear model

subplot(2,2,3)
scatter(X, Y) %Scatter plot of linear training model
hold on 
xlabel('Acceleration')
ylabel('Miles per Gallon')
title('Acceleration V Mpg: Test Linear Model')
hold off 

TestAnalysis = anova(TestModel,'summary') %Interpretation of test model

%-------- TASK 8b: GROUND TRUTH and PREDICTION ------

yHat = (a*X) + b; %yHat = ax + b  (IMPORTANT! My prediction)

subplot(2,2,4)
scatter(Y, yHat, 50, 'filled') %Fills scatter plot with values of size 50
xlabel('Acceleration') 
ylabel('Miles per Gallon') 
title('Acceleration V Mpg: Ground Truth and Prediction')


%-------- TASK 8d: COMPARE TRAINING and TEST RESIDUALS from MODELS ------

%Training Residuals
OrigRSqTrn = TrainModel.Rsquared.Ordinary; %Ordinary average training least-square error
AdjuRSqTrn = TrainModel.Rsquared.Adjusted; %Adjusted average training least-square error (based on coefficients)
MeanSqETrn = TrainModel.MSE; %Test Mean Square Error = 
RootRSqTrn = TrainModel.RMSE; %Training Root Mean Square Error

%Test Residuals
OrigRSqTst = TestModel.Rsquared.Ordinary; %Ordinary average training least-square error
AdjuRSqTst = TestModel.Rsquared.Adjusted; %Adjusted average training least-square error (based on coefficients)
MeanSqETst = TestModel.MSE; %Test Mean Square Error
RootRSqTst = TestModel.RMSE; %Test Root Mean Square Error

%Perform subtration to find the difference between Training and Test residuals
RsqSum1 = OrigRSqTrn - OrigRSqTst; 
RsqSum2 = AdjuRSqTrn - AdjuRSqTst;
RsqSum3 = MeanSqETrn - MeanSqETst;
RsqSum4 = RootRSqTrn - RootRSqTst;

%Take all of the results and fit to three different arrays
RsqTb1 = [OrigRSqTrn; OrigRSqTst; RsqSum1]; 
RsqTb2 = [AdjuRSqTrn; AdjuRSqTst; RsqSum2];
RsqTb3 = [MeanSqETrn; MeanSqETst; RsqSum3];
RsqTb4 = [RootRSqTrn; RootRSqTst; RsqSum4];

%Take the arrays of results from both models and fit to a table
AllVar1 = ["Train Model Residuals"; "Test Model Residuals"; "Difference"];
MeanRsqTable = table(AllVar1, RsqTb1, RsqTb2, RsqTb3, RsqTb4, 'VariableNames',...
   {'Variable', 'Original', 'Adjusted', 'MSE','RMSE'})


%-------- TASK 8e: INTERPRETATION of GROUND TRUTH and PREDICTION LINEAR MODEL --------

GTruthPredModel = fitlm(Y, yHat) %Create a model of Ground Truth and Prediction
GTruthPredAnalysis = anova(GTruthPredModel,'summary')


%-------- TASK 8f: GROUND TRUTH and PREDICTION COMPARISON (Min, Med, Max) ------

GtPMin = [min(Y); min(yHat)]; %Mean of Ground Truth and Prediction
GtP1Qt = [prctile(Y,25); prctile(yHat,25)];
GtPMed = [median(Y); median(yHat)]; %Median of Ground Truth and Prediction
GtP3Qt = [prctile(Y,75); prctile(yHat,75)];
GtPMax = [max(Y); max(yHat)]; %Median of Ground Truth and Prediction

%Perform subtration to find the difference between Ground Truth and Prediction
GtPSm1 = GtPMin(1) - GtPMin(2); %Ground Truth MIN value minus Prediction MIN value
GtPSm2 = GtP1Qt(1) - GtP1Qt(2);
GtPSm3 = GtPMed(1) - GtPMed(2); %Ground Truth MEDIAN value minus Prediction MEDIAN value
GtPSm4 = GtP3Qt(1) - GtP3Qt(2); %Ground Truth MAX value minus Prediction MAX value
GtPSm5 = GtPMax(1) - GtPMax(2);

%Take all of the results and fit to three different arrays
GtPTb1 = [GtPMin; GtPSm1];
GtPTb2 = [GtP1Qt; GtPSm2];
GtPTb3 = [GtPMed; GtPSm3];
GtPTb4 = [GtP3Qt; GtPSm4];
GtPTb5 = [GtPMax; GtPSm5];

%Take the arrays of results from Ground Truth and Prediction comparisons then fit them to a table
AllVar3 = ["GroundTruth"; "Prediction"; "Difference"];
GTruthPredTable = table(AllVar3, GtPTb1, GtPTb2, GtPTb3, GtPTb4, GtPTb5, 'VariableNames',...
    {'Variable', 'Min', 'FirstQuarter','Median', 'ThirdQuarter','Max'})

