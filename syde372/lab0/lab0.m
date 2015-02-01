% SYDE Lab 0 - Matlab Introduction
% Feb 1, 2015
clear all
close all
mu = [0 0]'; % the mean of the pdf
sigma = [1 0; 0 1]; % the variance matrix of the pdf
dx = 0.1; % step-size 0.5, 0.1
x1 = [-3:dx:3]; % range of the random variable x1
x2 = [-3:dx:3]; % range of the random variable x2

% Calculate the pdf
y = Gauss2d(x1,x2,mu,sigma);

% Show a 3-D plot of the pdf
figure
subplot(2,1,1);
surf(x1,x2,y);
xlabel('x_1');
ylabel('x_2');

% Show contours of the pdf
subplot(2,1,2);
contour(x1,x2,y);
xlabel('x_{1}');
ylabel('x_{2}');
axis equal

% Show a colour map of the pdf
figure
imagesc(x1,x2,y)
xlabel('x_{1}');
ylabel('x_{2}');

% region
z = (y>0.1);
figure
imagesc(x1,x2,z)
hold on; % allow us to plot more on the same figure
plot(mu(1,1),mu(2,1),'y.'); % plot the mean
xlabel('x_{1}');
ylabel('x_{2}');

pause;