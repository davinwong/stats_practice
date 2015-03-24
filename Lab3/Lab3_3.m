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

error = error / 160
