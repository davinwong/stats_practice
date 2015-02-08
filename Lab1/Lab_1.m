clear;

ClassA = ParametricClass([5;10], [8 0; 0 4], 0.5);
ClassB = ParametricClass([10;15], [8 0; 0 4], 0.5);
ClassC = ParametricClass([5;10], [8 4; 4 40], 100/450);
ClassD = ParametricClass([15;10], [8 0; 0 8], 200/450);
ClassE = ParametricClass([10;5], [10 -5; -5 20], 150/450);

figure;

n_pts = 450;
colours = {'red' 'blue' 'green'};
classes = {ClassC ClassD ClassE};

% Plot bounds
x_range =  -20:0.2:30;
y_range = -10:0.2:35;
contours = [1.5 2.5];

Tools.ParametricPlot(classes, colours, n_pts, x_range, y_range, contours, {'C' '\sigma_C' 'D' '\sigma_D' 'E' '\sigma_E' 'MED' 'GED' 'MAP'})

figure;

%Plot KNN and NN
x_range =  -1:0.15:25;
y_range = -6:0.15:28;

Tools.NonParametricPlot(classes, colours, n_pts, x_range, y_range, contours, {'C' 'D' 'E' 'NN' '5NN'})