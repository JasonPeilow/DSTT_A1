%EXAMPLE
%{
load accidents
x = hwydata(:,14); %Population of states
y = hwydata(:,4); %Accidents per states
format long %why format long?
b1 = x\y %x divided by y

yCalc1 = b1*x; % x divided by y multiplied by x
scatter(x,y) %scatter x and y, for lols
hold on %?
plot(x,yCalc1) %plot dat line
xlabel('Population of state')
ylabel('Fatal traffic accidents per state')
title('Linear Regression Relation Between Accidents & Population')
grid on %?
%}

%testing = readtable('data_test2.txt');
training = readtable('data_train2.txt');

%{
%TASK 7... 
d1 = training(:,6); %Acceleration
d2 = training(:,1); %Miles per Gallon

x = table2array(d1);
y = table2array(d2);

%This is just a Scatter plot of Acc and mpg (train)
figure
subplot(2,2,1);
scatter(x,y)
xlabel('x')
ylabel('y')

%Array of x (hat?) becomes 'X'
X = [x];
%Let's solve for the parameter estimates using the "Backslash Operator"
b = X \ y

%This is the first and basic linear regression.
%This is "Simple Linear Regression".
subplot(2,2,2);
scatter(x,y)
%Then, we tell Matlab to "hold on". 
%This prevents Matlab from making a new figure for subsequent plots 
%(until we tell it to "hold off").
hold on
%THIS IS X^2 AND XY : https://www.mathsisfun.com/data/least-squares-regression.html
%PLOT (in general) IS PLOTTING A LINE. WITH (X*b = SQUARE REGRESSION).
plot(x, X*b)
title('y = \beta_1 x', 'FontSize',18)
hold off

%why?
X = [ones(size(x)) x];
b = X \ y

subplot(2,2,3);
scatter(x,y)
hold on
plot(x, X*b)
title('y = \beta_0 + \beta_1 x', 'FontSize',18)
hold off

%Is this THIRD (QUADRATIC LINE) even reequired?
X = [ones(size(x)) x x.^2];
b = X \ y

subplot(2,2,4)
scatter(x,y)
hold on
plot(x, X*b)
title('y = \beta_0 + \beta_1 x + \beta_2 x^2', 'FontSize',18)
hold off

%...and TASK 8
%}

%TASK 9...



%...and TASK 10

%TASK 11... 


%...and TASK 12
