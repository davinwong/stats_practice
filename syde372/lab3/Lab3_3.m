clear all
close all

load feat.mat

cloth = readim('cloth.im');
cork = readim('cork.im');
cotton = readim('cotton.im');
face = readim('face.im');
grass = readim('grass.im');
paper = readim('paper.im');
pigskin = readim('pigskin.im');
raiffa = readim('raiffa.im');
stone = readim('stone.im');
straw = readim('straw.im');
wood = readim('wood.im');
wool = readim('wool.im');

dataSet = f8;
testDataSet = f8t;


for i = 1 : 10
    first = 0;
    for j = i * 16 - 15 : i * 16
        if (dataSet(3, j) == i)
            if (first == 0)
                data = [dataSet(1, j) dataSet(2, j)];
                testData = [testDataSet(1, j) testDataSet(2, j)];
                first = 1;
            else 
                data = [data; dataSet(1, j) dataSet(2, j)];
                testData = [testData; testDataSet(1, j) testDataSet(2, j)];
            end
        end
    end
    
    [mu, sigma] = Tools.sampleData(data);
    [tMu, tSigma] = Tools.sampleData(testData);
    
    if (i == 1)
		means = mu;
		testMeans = tMu;
		variances = sigma;
		testVariances = tSigma;
		points = data;
		testPoints = testData;
	else
		means = [means; mu];
		testMeans = [testMeans; tMu];
		variances = [variances; sigma];
		testVariances = [testVariances; tSigma];
		points = [points; data];
		testPoints = [testPoints; testData];
    end
end

boundary = zeros(1, 160);
testBoundary = zeros(1, 160);

for a = 1 : 160
    boundary(1,a) = Tools.paraClassifier([dataSet(1, a), dataSet(2, a)], testMeans, testVariances);
end

[C,order] = confusionmat(dataSet(3, :), boundary(1, :));

error = 0;
for i = 1 : 10
    for j = 1 : 10
        if (i ~= j)
            error = error + C(i, j);
        end
    end
end

error = error / 160;


%%% Part 4
%{
cimage = zeros(256, 256);
for i = 1:256
    for j=1:256
        cimage(i,j) = Tools.paraClassifier([multf8(i,j,1), multf8(i,j,2)], means, variances);
    end
end

imagesc(cimage);
colormap(jet(10));
%}
%%% Part 5

% random prototype
mean_Mat = zeros(2, 10);
for i = 1:10
   randomNumber = randi([1, size(f32t,2)]);
  
   mean_Mat(1, i) = f32t(1, randomNumber);
   mean_Mat(2, i) = f32t(2, randomNumber);
end


% rows: classes
% columns: 0 or point's index
class_point = zeros(10, 160) - 1;

% iterate k-means a number of times
for iterate = 1:10000

    % for each point, find closest class_mean. assign to class.
    for pt = 1:size(f32t,2)
        
        best_dist = 9999;
        best_prototype = 0;

        % on the point, find the best of the 10 prototypes
        for proto = 1:10
            curr_dist = ( f32t(1, pt) - mean_Mat(1, proto) )^2 + ( f32t(2, pt) - mean_Mat(2, proto) )^2;

            if (curr_dist <= best_dist)
                best_dist = curr_dist;
                best_prototype = proto;
            end
        end

        class_point(best_prototype, pt) = pt;
    end

    % enter
    for i = 1:10
        all_points = class_point(i,:);
        real_points = all_points(all_points >= 0);
        % what do you do if a class runs out of points? no points belong to
        % the prototype
        % impossible. each class must have at least 1 point because the
        % prototype started on a point.

        sum_x = 0;
        sum_y = 0;

        for rp = 1:length(real_points)
           sum_x = sum_x + f32t(1, real_points(rp));
           sum_y = sum_y + f32t(2, real_points(rp));
        end

        avg_x = sum_x / length(real_points);
        avg_y = sum_y / length(real_points);

        mean_Mat(1, i) = avg_x;
        mean_Mat(2, i) = avg_y;

    end

    
end


figure
aplot(f32);
hold on
scatter(mean_Mat(1,:), mean_Mat(2,:));





