cleanTrain = readtable('data_train2.txt');

%TASK 5

%are mpgCol and mpgArr neccessary?
mpgCol = cleanTrain(:,1);
mpgArr = table2array(mpgCol);
mpgAvg = mean(mpgArr);
%mpgAvg2 = round(mpgAvg1,1);
mpgMed = median(mpgArr);
mpgMin = min(mpgArr);
mpgMax = max(mpgArr);
mpgStD = std(mpgArr);

accCol = cleanTrain(:,6);
accArr = table2array(accCol);
accAvg = mean(accArr);
accMed = median(accArr);
accMin = min(accArr);
accMax = max(accArr);
accStD = std(accArr);

horCol = cleanTrain(:,4);
horArr = table2array(horCol);
horAvg = mean(horArr);
horMed = median(horArr);
horMin = min(horArr);
horMax = max(horArr);
horStD = std(horArr);

wgtCol = cleanTrain(:,5);
wgtArr = table2array(wgtCol);
wgtAvg = mean(wgtArr);
wgtMed = median(wgtArr);
wgtMin = min(wgtArr);
wgtMax = max(wgtArr);
wgtStD = std(wgtArr);

%Put into tabular form (task 5)
task5Array = {'mpg' mpgAvg mpgMed mpgMin mpgMax mpgStD ; 'acceleration' accAvg accMed accMin accMax accStD ; 'horse power' horAvg horMed horMin horMax horStD ; 'weight' wgtAvg wgtMed wgtMin wgtMax wgtStD ; };
%cellArray = {'mpg' mpgTot(:,:) ; 'acceleration' accTot(:,:) ; 'horse power' horTot(:,:) ; 'weight' wgtTot(:,:)} ;
task5Table = cell2table(task5Array);
%Better way of doing this? %rownames? Yeah...
task5Table.Properties.VariableNames = {'Variable', 'Mean', 'Median', 'Min', 'Max', 'Standard_Deviation'}
 

%TASK 6

%a. acc box plot
figure
mpgBox = [mpgMin, mpgMed,  mpgMax];
%subplot(2,2,1) %Another format?
boxplot(mpgBox)
xlabel('All Vehicles')
ylabel('Miles per Gallon (MPG)')
title('Miles per Gallon for All Vehicles')

%b. acc box plot
figure
accBox = [accMin, accMed, accMax];
%subplot(2,2,2)
boxplot(accBox)
xlabel('All vehicles')
ylabel('Acceleration')
title('Acceleration for All Vehicles')

%c. hor box plot
figure
horBox = [horMin, horMed, horMax];
%subplot(2,2,3)
boxplot(horBox)
xlabel('All vehicles')
ylabel('Horse Power')
title('Horse Power for All Vehicles')

%d. wgt box plot
figure
wgtBox = [wgtMin, wgtMed, wgtMax];
%subplot(2,2,4)
boxplot(wgtBox)
xlabel('All vehicles')
ylabel('Weight')
title('Weight for All Vehicles')

%e. acc v mpg scater
figure
%subplot(3,1,1)
scatter(accArr, mpgArr, 'filled')
xlabel('Acceleration')
ylabel('Miles per Gallon')
title('Acceleration vs Miles per Gallon')

%f. hor v mpg scatter
figure
%subplot(3,1,2)
scatter(horArr, mpgArr, 'filled')
xlabel('Horse Power')
ylabel('Miles per Gallon')
title('Horse Power vs Miles per Gallon')

%g. wgt v hor scatter
figure
%subplot(3,1,3)
scatter(wgtArr, horArr, 'filled')
xlabel('Weight')
ylabel('Horse Power')
title('Weight vs Horse Power')
