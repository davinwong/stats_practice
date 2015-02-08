
clear;

N_A = 200;
N_B = 200;

mu_A = [ 5;10];
mu_B = [10;15];

Sigma_A = [ 8  0;  0  4];
Sigma_B = [ 8  0;  0  4];

ClassA = Classifier(mu_A,Sigma_A, 0.5, N_A);
ClassB = Classifier(mu_B,Sigma_B, 0.5, N_B);

figure;
colours = {'red' 'blue'};
classes = {ClassA ClassB};
pts = 400;
names = {'A' '\sigma_A' 'B' '\sigma_B' 'MED' 'GED' 'MAP'};

x_range = -5:0.2:20;
y_range = 4:0.2:20;
contours = 1.5;

for i=1:length(classes)
    classes{i}.plotData(colours{i});
    hold on;
    classes{i}.plotStdDev(colours{i})
    hold on;
end

med = Classifier.medClassifier(classes,x_range,y_range);
ged = Classifier.gedClassifier(classes,x_range,y_range);
map = Classifier.mapClassifier(classes,x_range,y_range);

bounds = {med ged map};
bound_colours = {'black' 'cyan' 'yellow'};
for i=1:length(bounds)
    contour(x_range, y_range, bounds{i}', contours, bound_colours{i}, 'LineWidth', 1)
    hold on;
end

legend(names)