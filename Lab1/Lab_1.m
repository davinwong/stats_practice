clear;

ClassA = ParametricClass([5;10], [8 0; 0 4], 0.5);
ClassB = ParametricClass([10;15], [8 0; 0 4], 0.5);
ClassC = ParametricClass([5;10], [8 4; 4 40], 100/450);
ClassD = ParametricClass([15;10], [8 0; 0 8], 200/450);
ClassE = ParametricClass([10;5], [10 -5; -5 20], 150/450);

figure;
colours = {'red' 'blue'};
classes = {ClassA ClassB};
pts = 400;
names = {'A' '\sigma_A' 'B' '\sigma_B' 'MED' 'GED' 'MAP'};

x_range = -5:0.2:20;
y_range = 4:0.2:20;
contours = 1.5;

Tools.ParametricPlot(classes, colours, pts, x_range, y_range, contours, names);
