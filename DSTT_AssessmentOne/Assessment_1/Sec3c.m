clear; close all; clc;

testing = readtable('data_test2.txt');
training = readtable('data_train2.txt');

%TASK 11 --------

x1a = training(:,5); %Train wgt - Explanatory Variable
y1a = training(:,4); %Train hor - Dependant Variable
nx1a = testing(:,5); %Testing wgt - Explanatory Variable
ny1a = testing(:,4); %Testing hor - Dependant Variable

%Take Training table data and put into an array
X1a = table2array(x1a);
Y1a = table2array(y1a);

%%Take Test table data and put into an array
nX1a = table2array(nx1a);
nY1a = table2array(ny1a);

%This produces the (A) and (B) variables
trainTable = table(X1a, Y1a);
trainModel = fitlm(trainTable);

%Model 
subplot(3,1,1)
scatter(X1a, Y1a)
hold on
plot(trainModel)
hold off


%TASK 12 --------

testTable = table(nX1a,nY1a);
mdl2a = fitlm(testTable);

subplot(3,1,2)
scatter(nX1a,nY1a)
hold on
plot(mdl2a)


%I think the formula needs to be broken down more....

yPred = predict(trainModel,nX1a); % y = mpg test
score = yPred - nY1a;

%X1a = original training mpg
%label, score = Training model (Train mpg * Train acc)
%T1a = Test mpg
table(nY1a(1:96), yPred(1:96), score(1:96),'VariableNames',...
    {'GroundTruth','Prediction','Score'})

%Scatter of Groundtruth (Test mpg) and 
%Prediction (Training Model vs Test Acc)
subplot(3,1,3)
scatter(nY1a, yPred)
