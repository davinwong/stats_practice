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
