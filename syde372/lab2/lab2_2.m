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
alPts = [al; bl; cl];

x = min(alPts(:, 1)):5:max(alPts(:, 1));
y = min(alPts(:, 2)):5:max(alPts(:, 2));

boundary = zeros(length(x), length(y));

for i = 1:length(x)
    for j = 1:length(y)
        boundary(i,j) = Plots.paraClassifier([x(i), y(j)], mu, sigma);
    end
end

figure
contour(x, y, boundary, 3);
hold on
plot(al(:, 1), al(:, 2), 'b+');
hold on
plot(bl(:, 1), bl(:, 2), 'r+');
hold on
plot(cl(:, 1), cl(:, 2), 'g+');
title('2D Parametric Estimation Boundary');
legend('Non Parametric Boundary', 'Set A', 'Set B', 'Set C');


%2D Non Parametric Estimation Boundary

minX = min([min(al(1 ,:)) min(bl(1,:)) min(cl(1,:))]);
maxX = max([max(al(1 ,:)) max(bl(1,:)) max(cl(1,:))]);
minY = min([min(al(: ,1)) min(bl(:,1)) min(cl(:,1))]);
maxY = max([max(al(: ,1)) max(bl(:,1)) max(cl(:,1))]);

dx = 5;
x = minX:dx:maxX;
y = minY:dx:maxY;
boundary = zeros(length(x), length(y));

sigma = [20 0; 0 20];
for i = 1:length(x)
    for j = 1:length(y)
        point = [x(i) y(j)];
        boundary(i, j) = Plots.nonParaClassifier(point, al, bl, cl, sigma);
    end
end

figure
contour(x, y, boundary.', 2);
hold on
plot(al(:,1), al(:,2), 'b+');
hold on
plot(bl(:,1), bl(:,2), 'r+');
hold on
plot(cl(:,1), cl(:,2), 'g+');
title('2D Non Parametric Estimation Boundary');
legend('Non Parametric Boundary', 'Set A', 'Set B', 'Set C');