clear all
load('lab2_1.mat');

%Parametric Estimation Gaussian - Set A
tMu = 5;
tSigma = 1;
N = length(a);

mlMu = (1/N) * sum(a);
mlSigma = 0;
for i=1:N
    mlSigma = mlSigma + (a(i) - mlMu)^2;
end
mlSigma = mlSigma * (1/N);

figure
Plots.plotGauss(mlMu, mlSigma, 'b');
hold on
Plots.plotGauss(tMu, tSigma, 'r');
title('Estimated vs. Actual Gauss Dist. Set A');
legend('Est Gauss', 'Act Gauss');

%Parametric Estimation Gaussian - Set B
lambda = 1;
tMu = 1/(lambda);
tSigma = 1/(lambda^2);
N = length(b);

mlMu = (1/N) * sum(b);
mlSigma = 0;
for i=1:N
    mlSigma = mlSigma + (b(i) - mlMu)^2;
end
mlSigma = mlSigma * (1/N);

figure
Plots.plotGauss(mlMu, mlSigma, 'b');
hold on
Plots.plotGauss(tMu, tSigma, 'r');
title('Estimated vs. Actual Gauss Dist. Set B');
legend('Est Gauss', 'Act Gauss');

%Parametric Estimation Exponential - Set A
tMu = 5;
tLambda = 1/tMu;
N = length(a);

mlMu = (1/N) * sum(a);
mlLambda = 1/mlMu;

figure
Plots.plotExpo(mlLambda, 'b');
hold on
Plots.plotExpo(tLambda, 'r');
title('Estiamted vs. Actual Expo Dist. Set A');
legend('Est Expo', 'Act Expo');

%Parametric Estimation Exponential - Set B
tLambda = 1;
N = length(b);

mlMu = (1/N) * sum(b);
mlLambda = 1/mlMu;

figure
Plots.plotExpo(mlLambda, 'b');
hold on
Plots.plotExpo(tLambda, 'r');
title('Estiamted vs. Actual Expo Dist. Set B');
legend('Est Expo', 'Act Expo');

%Parametric Estimation Uniform - Set A
tMu = 5;
tSigma = 1;

figure
Plots.plotUniform(a, 'b');
hold on
Plots.plotGauss(tMu, tSigma, 'r');
title('Estimated Unif Dist vs. Actual Gauss Dist Set A');
legend('Est Unif', 'Act Gauss');

%Parametric Estimation Uniform - Set B
tLambda = 1;

figure
Plots.plotUniform(b, 'b');
hold on
Plots.plotExpo(tLambda, 'r');
title('Estimated Unif Dist vs. Actual Expo Dist Set B');
legend('Est Unif', 'Act Expo');

%Non-parametric Estimation 

tMu = 5;
tSigma = 1;
tLambda = 1;

stdDev1 = 0.1;
stdDev2 = 0.4;
x = 0:.1:9.9;
N = length(a);

parzen1a = zeros(1,100);
parzen2a = zeros(1,100);
parzen1b = zeros(1,100);
parzen2b = zeros(1,100);


for j=1:100
    parzenSum1a = 0;
    parzenSum2a = 0;
    parzenSum1b = 0;
    parzenSum2b = 0;

    for i = 1:N
        parzenSum1a = parzenSum1a + ((1/(stdDev1 * sqrt(2*pi))) * exp(-.5 * (((j/10 - a(i))/(stdDev1))^2)));
        parzenSum2a = parzenSum2a + ((1/(stdDev2 * sqrt(2*pi))) * exp(-.5 * (((j/10 - a(i))/(stdDev2))^2)));
        parzenSum1b = parzenSum1b + ((1/(stdDev1 * sqrt(2*pi))) * exp(-.5 * (((j/10 - b(i))/(stdDev1))^2)));
        parzenSum2b = parzenSum2b + ((1/(stdDev2 * sqrt(2*pi))) * exp(-.5 * (((j/10 - b(i))/(stdDev2))^2)));
    end
    parzen1a(j) = (1/N) * parzenSum1a;
    parzen2a(j) = (1/N) * parzenSum2a;
    parzen1b(j) = (1/N) * parzenSum1b;
    parzen2b(j) = (1/N) * parzenSum2b;

end

figure 
plot(x, parzen1a, 'b');
hold on
plot(x, parzen2a, 'r');
hold on
Plots.plotGauss(tMu, tLambda, 'g');
title('Parzen gaussian window estimation Set A');
legend('StdDev = 0.1', 'StdDev = 0.4', 'Act Dist');

figure
plot(x, parzen1b, 'b');
hold on
plot(x, parzen2b, 'r');
hold on
Plots.plotExpo(tLambda, 'g');
title('Parzen gaussian window estimation Set B');
legend('StdDev = 0.1', 'StdDev = 0.4', 'Act Dist');e

