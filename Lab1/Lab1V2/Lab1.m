
clear;

N_A = 200;
N_B = 200;
N_C = 100;
N_D = 200;
N_E = 150;

mu_A = [  5 ; 10 ];
mu_B = [ 10 ; 15 ];
mu_C = [  5 ; 10 ];
mu_D = [ 15 ; 10 ];
mu_E = [ 10 ;  5 ];

Sigma_A = [ 8  0;  0  4];
Sigma_B = [ 8  0;  0  4];
Sigma_C = [ 8  4;  4 40];
Sigma_D = [ 8  0;  0  8];
Sigma_E = [10 -5; -5 20];

ClassA = Classifier(mu_A,Sigma_A, 0.5, N_A);
ClassB = Classifier(mu_B,Sigma_B, 0.5, N_B);
ClassC = Classifier(mu_C,Sigma_C, 0.5, N_C);
ClassD = Classifier(mu_D,Sigma_D, 0.5, N_D);
ClassE = Classifier(mu_E,Sigma_E, 0.5, N_E);

figure;
colours = {'red' 'blue'};
classes = {ClassA ClassB};
pts = 400;
names = {'A' '\sigma_A' 'B' '\sigma_B' 'MED' 'GED' 'MAP'};

x_range = -5:0.2:20;
y_range = 4:0.2:20;
contours = 1.5;

%{
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
%}


training = vertcat(ClassA.cluster,ClassB.cluster);
nn_classes_A = zeros(length(ClassA.cluster),1);
nn_classes_B = zeros(length(ClassB.cluster),1);
nn_classes_B = nn_classes_B+1;
nn_classes = vertcat(nn_classes_A, nn_classes_B);

nn = k_nearest_neighbor(200, 200, training, nn_classes, 1);
disp(nn);

contour(x_range, y_range, nn, contours, 'black', ...
    'LineWidth', 1)
hold on;



training = [1 1; 2 2; 3 3; 4 4; 5 5; 6 6; 7 7; 8 8; 9 9; 10 10];
classes = [1; 2; 3; 4; 5; 6; 7; 8; 9; 10];


[nn_X,nn_Y,nn_Z] = k_nearest_neighbor(-4:.1:20, -4:.1:20, training, classes, 1);

contour(nn_X, nn_Y, nn_Z);












