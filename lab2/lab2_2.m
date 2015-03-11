clear all
load('lab2_2.mat');

%2D Parametric Estimation Boundary
aN = length(al);
bN = length(bl);
cN = length(cl);

[aMu, aSigma] = Plots.sampleData(al);
[bMu, bSigma] = Plots.sampleData(bl);
[cMu, cSigma] = Plots.sampleData(cl);

mu = [aMu; bMu; cMu];
sigma = [aSigma; bSigma; cSigma];
dataPts = [al; bl; cl];

x = min(dataPts(:, 1)):5:max(dataPts(:, 1));
y = min(dataPts(:, 2)):5:max(dataPts(:, 2));

boundary = zeros(length(x), length(y));

for i = 1:length(x)
    for j = 1:length(y)
        boundary(i,j) = Plots.paraClassifier([x(i), y(j)], mu, sigma);
    end
end

contour(x, y, boundary, 3);
hold on
plot(al(:, 1), al(:, 2), 'b+');
hold on
plot(bl(:, 1), bl(:, 2), 'r+');
hold on
plot(cl(:, 1), cl(:, 2), 'g+');
