clear; close all; clc;

% -------- TASK 1.a --------

%Copy txt file into Excel: 305 rows * 2 columns
%Import txt as csv into Excel: 305 rows * 9 columns
%Import txt into MATLAB: 305 rows * 9 columns
Train1 = readtable('data_train.txt','TreatAsEmpty',{'NA'});

% -------- TASK 2.a --------

%When cleaned: 296 rows * 9 columns
Train2 = rmmissing(Train1); %Any row with missing data is removed

% -------- TASK 3.c --------

%Variable names for each of the columns in the newly cleaned data set.
Train2.Properties.VariableNames = {'mpg','cylinders','displacement','horsepower','weight','acceleration','model_year','origin','car_name'};
writetable(Train2, 'data_train2.txt'); %Cleaned data is saved into a new file: data_test2.txt

% -------- TASK 4 --------
% -------- TASK 1.b --------

%Copy txt file into Excel: 101 rows * 2 columns
%Import txt as csv into Excel: 101 rows * 9 columns
%Import txt into MATLAB: 101 rows * 9 columns
Test1 = readtable('data_test.txt','TreatAsEmpty',{'NA'});

% -------- TASK 2.b --------

%When cleaned: 96 rows * 9 columns
Test2 = rmmissing(Test1); %Any row with missing data is removed

% -------- TASK 3.b --------

%Variable names for each of the columns in the newly cleaned data set.
Test2.Properties.VariableNames = {'mpg','cylinders','displacement','horsepower','weight','acceleration','model_year','origin','car_name'};
writetable(Test2, 'data_test2.txt'); %Cleaned data is saved into a new file: data_test2.txt
