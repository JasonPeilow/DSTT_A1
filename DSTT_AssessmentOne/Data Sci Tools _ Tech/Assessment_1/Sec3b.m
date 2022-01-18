testing = readtable('data_test2.txt');
training = readtable('data_train2.txt');

%TASK 7

x1 = training(:,6); %Acceleration
y1 = training(:,1); %Miles per Gallon
t1 = testing (:,1); %Test MPG 

%Explanatory variable
X1 = table2array(x1);
%Dependent variable
Y1 = table2array(y1);
%Testing data
T1 = table2array(t1);

tbl = table(T1, X1, Y1);
model1 = fitlm(tbl, 'T1 ~ Y1 + X1')