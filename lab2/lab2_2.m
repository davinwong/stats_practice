clear all
load('lab2_2.mat');
%{
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

contour(x, y, boundary, 3);
hold on
plot(al(:, 1), al(:, 2), 'b+');
hold on
plot(bl(:, 1), bl(:, 2), 'r+');
hold on
plot(cl(:, 1), cl(:, 2), 'g+');
%}
%2D Non Parametric Estimation Boundary
%{
stDev = 20;
win = fspecial('gaussian', [25 25], stDev);

minX = min([min(al(1 ,:)) min(bl(1,:)) min(cl(1,:))]);
maxX = max([max(al(1 ,:)) max(bl(1,:)) max(cl(1,:))]);
minY = min([min(al(: ,1)) min(bl(:,1)) min(cl(:,1))]);
maxY = max([max(al(: ,1)) max(bl(:,1)) max(cl(:,1))]);
res = [5 minX minY maxX maxY];

[aP, aX, aY] = Plots.parzen(al, res, win);
[bP, bX, bY] = Plots.parzen(bl, res, win);
[cP, cX, cY] = Plots.parzen(cl, res, win);
p = {aP, bP, cP};

x = minX:5:maxX+5;
y = minY:5:maxY+5;

boundary = zeros(length(aX), length(aY));
for i = 1:length(aX)
    for j = 1:length(aY)
        boundary(i,j) = Plots.nonParaClassifier([x(i), y(i)], p);
    end
end

contour(x, y, boundary, 3);
%}
%{
stDev = 20;
win = fspecial('gaussian', [25 25], stDev);
minX = min([min(al(1 ,:)) min(bl(1,:)) min(cl(1,:))]);
maxX = max([max(al(1 ,:)) max(bl(1,:)) max(cl(1,:))]);
minY = min([min(al(: ,1)) min(bl(:,1)) min(cl(:,1))]);
maxY = max([max(al(: ,1)) max(bl(:,1)) max(cl(:,1))]);

res = [5, minX - 5, minY-5, maxX+5, maxY+5];
[pdfA, xA, yA] = Plots.parzen(al,res,win);
[pdfB, xB, yB] = Plots.parzen(bl,res,win);
[pdfC, xC, yC] = Plots.parzen(cl,res,win);

grid = zeros(length(xA),length(yA));

dx = 5;
xVals = [minX-10:dx:maxX+5];
yVals = [minY-10:dx:maxY+5];

probs{1} = pdfA;
probs{2} = pdfB;
probs{3} = pdfC;

for j=1:yA
	for k=1:xA
        point = [xVals(j), yVals(k)];
        class = -1;
        pA = cell2mat(probs(1));
        pB = cell2mat(probs(2));
        pC = cell2mat(probs(3));

        disp(point);
        probA = pA(point);
        probB = pB(point);
        probC = pC(point);
        [~, class] = max([probA probB probC]);
        if class == 1 || class == 2
            grid(j, k) = 1;
        elseif class == 3 || class == 4
            grid(j, k) = 2;
        elseif class == 5 || class == 6
            grid(j, k) = 3;
        else
            grid(j, k) = 0;
        end
	end
end
contour(yVals, xVals, grid);
%}

minX = min([min(al(1 ,:)) min(bl(1,:)) min(cl(1,:))]);
maxX = max([max(al(1 ,:)) max(bl(1,:)) max(cl(1,:))]);
minY = min([min(al(: ,1)) min(bl(:,1)) min(cl(:,1))]);
maxY = max([max(al(: ,1)) max(bl(:,1)) max(cl(:,1))]);

dx = 5;
xVals = [minX:dx:maxX];
yVals = [minY:dx:maxY];
data = [xVals yVals];

sigma = [20 0; 0 20];
for i = 1:length(data)
    for z = 1;length(al)
        gauss = (1/(sqrt(2*pi)^2*sqrt(det(sigma))))*exp(-0.5*(data(z) - al(z))*inv(sigma)*(data(z)-al(z))');
    end
end