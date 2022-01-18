clear; close all; clc;

dataTrain = readtable('data_train2.txt');

% -------- TASK 5 --------

mpgCol = dataTrain(:,1); %
accCol = dataTrain(:,6);
horCol = dataTrain(:,4);
wgtCol = dataTrain(:,5);

mpgArr = table2array(mpgCol);
accArr = table2array(accCol);
horArr = table2array(horCol);
wgtArr = table2array(wgtCol);

%are mpgCol and mpgArr neccessary?

allAvg = [mean(mpgArr); mean(accArr); mean(horArr); mean(wgtArr)]; %Mean of Ground Truth and Prediction
allMed = [median(mpgArr); median(accArr); median(horArr); median(wgtArr)]; %Mean of Ground Truth and Prediction
allMin = [min(mpgArr); min(accArr); min(horArr); min(wgtArr)]; %Mean of Ground Truth and Prediction
allMax = [max(mpgArr); max(accArr); max(horArr); max(wgtArr)]; %Mean of Ground Truth and Prediction
allStD = [std(mpgArr); std(accArr); std(horArr); std(wgtArr)]; %Mean of Ground Truth and Prediction

allVar = ["mpg"; "acceleration"; "horsepower"; "weight"];
Task5Output = table(allVar,allAvg, allMed, allMin, allMax, allStD, 'VariableNames',...
   {'Variable', 'Mean', 'Median', 'Min', 'Max', 'Standard_Deviation'})


% -------- TASK 6 --------

%TASK 6a. mpg box plot
figure
subplot(1,4,1)
boxMinA = allMin(1); 
boxMedA = allMed(1);
boxMaxA = allMax(1);
boxA = [boxMinA, boxMedA, boxMaxA];
boxplot(boxA)
set(gca,'FontSize',15);
xlabel('All Vehicles', 'FontSize', 20)
ylabel('Miles per Gallon (MPG)', 'FontSize', 20)
title('Miles per Gallon for All Vehicles', 'FontSize', 20)

%TASK 6b. acceleration box plot
subplot(1,4,2)
boxMinB = allMin(2); 
boxMedB = allMed(2);
boxMaxB = allMax(2);
boxB = [boxMinB, boxMedB, boxMaxB];
boxplot(boxB)
set(gca,'FontSize',15);
xlabel('All vehicles', 'FontSize', 20)
ylabel('Acceleration', 'FontSize', 20)
title('Acceleration for All Vehicles', 'FontSize', 20)

%TASK 6c. horsepower box plot
subplot(1,4,3)
boxMinC = allMin(3); 
boxMedC = allMed(3);
boxMaxC = allMax(3);
boxC = [boxMinC, boxMedC, boxMaxC];
boxplot(boxC)
set(gca,'FontSize',15);
xlabel('All vehicles', 'FontSize', 20)
ylabel('Horsepower', 'FontSize', 20)
title('Horsepower for All Vehicles', 'FontSize', 20)

%TASK 6d. weight box plot
subplot(1,4,4)
boxMinD = allMin(4); 
boxMedD = allMed(4);
boxMaxD = allMax(4);
boxD = [boxMinD, boxMedD, boxMaxD];
boxplot(boxD)
set(gca,'FontSize',15);
xlabel('All vehicles', 'FontSize', 20)
ylabel('Weight', 'FontSize', 20)
title('Weight for All Vehicles', 'FontSize', 20)

%TASK 6e. acceleration v mpg scater
figure
subplot(1,3,1)
scatter(accArr, mpgArr, 'filled')
set(gca,'FontSize',15);
xlabel('Acceleration', 'FontSize', 20)
ylabel('Miles per Gallon', 'FontSize', 20)
title('Acceleration vs Miles per Gallon', 'FontSize', 20)

%TASK 6f. horsepower v mpg scatter
subplot(1,3,2)
scatter(horArr, mpgArr, 'filled')
set(gca,'FontSize',15);
xlabel('Horsepower', 'FontSize', 20)
ylabel('Miles per Gallon', 'FontSize', 20)
title('Horsepower vs Miles per Gallon', 'FontSize', 20)

%TASK 6g. weight v horsepower scatter
subplot(1,3,3)
scatter(wgtArr, horArr, 'filled')
set(gca,'FontSize',15);
xlabel('Weight', 'FontSize', 20)
ylabel('Horsepower', 'FontSize', 20)
title('Weight vs Horsepower', 'FontSize', 20)
