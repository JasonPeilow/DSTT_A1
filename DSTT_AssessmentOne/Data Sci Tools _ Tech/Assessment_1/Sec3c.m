testing = readtable('data_test2.txt');
training = readtable('data_train2.txt');

%TASK 7 --------

x1a = training(:,6); %Acceleration
y1a = training(:,1); %Miles per Gallon
t1a = testing(:,1); %Testing mpg
t2a = testing(:,6); %Testing acc

%Explanatory variable - mpg
X1a = table2array(x1a);
%Dependent variable - accel
Y1a = table2array(y1a);

%Testing data - mpg
T1a = table2array(t1a);
%Testing data - accel
T2a = table2array(t2a)

%This is (A)
tblTraina = table(X1a, Y1a);
mdla = LinearModel.fit(tblTraina)

%Model coefficients
%"Explain whether each coefficient could be zero significantly."
figure
scatter(X1a, Y1a)
hold on
plot(mdla)
hold off
%TASK 8 --------

tblTesta = table(T1a,T2a);
mdl2a = LinearModel.fit(tblTesta)

figure
scatter(T1a,T2a)
hold on
plot(mdl2a)

[label,score] = predict(mdla,T1a);
bo = table(T2a(1:96),label(1:96),score(1:96,2),'VariableNames',...
    {'GroundTruth','Prediction','Score'})

figure
scatter(bo{:,'GroundTruth'},bo{:,'Prediction'})
plot(T1a)