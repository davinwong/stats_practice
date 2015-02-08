
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

%{

%Class A/B MED, GED, MAP
figure;
colours = {'red' 'blue'};
classes = {ClassA ClassB};
names = {'A' 'StdDev A' 'B' 'StdDev B' 'med' 'ged' 'map'};

x_range = -5:0.2:20;
y_range = 4:0.2:20;
contours = 1.5;

med = Classifier.medClassifier(classes,x_range,y_range);
ged = Classifier.gedClassifier(classes,x_range,y_range);
map = Classifier.mapClassifier(classes,x_range,y_range);

for i=1:length(classes)
    classes{i}.plotData(colours{i});
    hold on;
    classes{i}.plotStdDev(colours{i})
    hold on;
end

bounds = {med ged map};
bound_colours = {'black' 'cyan' 'yellow'};
for i=1:length(bounds)
    contour(x_range, y_range, bounds{i}', contours, bound_colours{i}, 'LineWidth', 1)
    hold on;
end

legend(names)


%Class A/B NN, 5NN
figure;

x_range = -5:0.2:20;
contours = 1;
names = {'NN' '5 NN'};

training = vertcat(ClassA.cluster,ClassB.cluster);
nn_classes_A = zeros(length(ClassA.cluster),1);
nn_classes_B = zeros(length(ClassB.cluster),1);
nn_classes_B = nn_classes_B+1;
nn_classes = vertcat(nn_classes_A, nn_classes_B);

[nn_X,nn_Y,nn_Z] = k_nearest_neighbor(x_range, ...
    x_range, training, nn_classes, 1);
[nn5_X,nn5_Y,nn5_Z] = k_nearest_neighbor(x_range, ...
    x_range, training, nn_classes, 5);

contour(nn_X, nn_Y, nn_Z, contours, 'black', 'LineWidth', 1);
hold on;
contour(nn5_X,nn5_Y,nn5_Z, contours, 'green', 'LineWidth', 1);
hold on;
ClassA.plotData('red');
hold on;
ClassB.plotData('blue');
hold on;
ClassA.plotStdDev('red');
hold on;
ClassB.plotStdDev('blue');
hold on;

legend(names);


%Class C/D/E MED GED MAP
figure;
colours = {'red' 'blue' 'black'};
classes = {ClassC ClassD ClassE};
names = {'C' 'StdDev C' 'D' 'StdDev D' 'E' 'StdDev E' 'med' 'ged' 'map'};

x_range =  -20:0.2:30;
y_range = -10:0.2:35;
contours = [1.5 2.5];

med = Classifier.medClassifier(classes,x_range,y_range);
ged = Classifier.gedClassifier(classes,x_range,y_range);
map = Classifier.mapClassifier(classes,x_range,y_range);

for i=1:length(classes)
    classes{i}.plotData(colours{i});
    hold on;
    classes{i}.plotStdDev(colours{i})
    hold on;
end

bounds = {med ged map};
bound_colours = {'black' 'cyan' 'yellow'};
for i=1:length(bounds)
    contour(x_range, y_range, bounds{i}', contours, bound_colours{i}, 'LineWidth', 1)
    hold on;
end

legend(names)


%Class C/D/E NN, 5NN
figure;

x_range =  -5:0.2:30;
contours = 1;
names = {'NN' '5 NN'};

training = vertcat(ClassC.cluster,ClassD.cluster, ClassE.cluster);
nn_classes_C = zeros(length(ClassA.cluster),1);
nn_classes_D = zeros(length(ClassB.cluster),1);
nn_classes_E = zeros(length(ClassB.cluster),1);
nn_classes_D = nn_classes_D+1;
nn_classes_E = nn_classes_E+2;
nn_classes = vertcat(nn_classes_C, nn_classes_D, nn_classes_E);

[nn_X,nn_Y,nn_Z] = k_nearest_neighbor(x_range, ...
    x_range, training, nn_classes, 1);
[nn5_X,nn5_Y,nn5_Z] = k_nearest_neighbor(x_range, ...
    x_range, training, nn_classes, 5);

contour(nn_X, nn_Y, nn_Z, contours, 'black', 'LineWidth', 1);
hold on;
contour(nn5_X,nn5_Y,nn5_Z, contours, 'cyan', 'LineWidth', 1);
hold on;
ClassC.plotData('red');
hold on;
ClassD.plotData('blue');
hold on;
ClassE.plotData('green');

ClassC.plotStdDev('red');
hold on;
ClassD.plotStdDev('blue');
hold on;
ClassE.plotStdDev('green');
legend(names);

%}

%Confusion Matrix Class A/B
classes = {ClassA ClassB};
training = vertcat(ClassA.cluster,ClassB.cluster);
actual_A = zeros(length(ClassA.cluster),1);
actual_B = zeros(length(ClassB.cluster),1);
actual_B= actual_B+1;

actual_AB = vertcat(actual_A, actual_B);
predicted_AB = zeros(length(training),1);
for  i = 1:length(predicted_AB)
    predicted_AB(i) = Classifier.medDistance(classes,[training(i,1) training(i,2)]');
end

[matrix,order] = confusionmat(actual_AB,predicted_AB);











