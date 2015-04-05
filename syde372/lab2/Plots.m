classdef Plots
    methods(Static)
        
        function plotGauss(mu, sigma, b)

            minX = mu - (5 * sigma);
            maxX = mu + (5 * sigma);
            x = minX:1e-3:maxX;
            y = pdf('normal', x, mu, sigma);
            plot(x, y, b);
        end
        
        function plotExpo(lambda, b)
            x = 0:.1:5;
            y = pdf('exponential', x,lambda);
            plot(x, y, b);
        end
        
        function plotUniform(array, b)
            minX = min(array);
            maxX = max(array);
            x = 0:1e-1:5;
            y = pdf('uniform', x, minX, maxX);
            plot(y, b);
        end
        
        function [mu, sigma] = sampleData(array)
            N = length(array);
            mu = sum(array)/N;
            
            sigma = zeros(2,2);
            for i = 1:N
                sigma = sigma + array(i,:).'*array(i,:);
            end
            sigma = (1/N) * sigma - (mu.'*mu);
        end
        
        function class = paraClassifier(point, means, variances)
            class = -1;
            numMeans = length(means(:, end));
            mu = [];
            sigma = [];
            index = 0;
            for i=1:numMeans
                tl = variances(i+index,1);
                tr = variances(i+index,2);
                bl = variances(i+index+1, 1);
                br = variances(i+index+1, 2);
                sigma{i} = [tl tr ; bl br];
                mu{i} = [means(i, 1) means(i, 2)];
                index = index + 1;
            end

            aMu = cell2mat(mu(1)); 
            bMu = cell2mat(mu(2)); 
            cMu = cell2mat(mu(3));
            
            aSigma = cell2mat(sigma(1)); 

            bSigma = cell2mat(sigma(2)); 
            cSigma = cell2mat(sigma(3));

            aGauss = (1/(sqrt(2*pi)^2*sqrt(det(aSigma))))*exp(-0.5*(point - aMu)*inv(aSigma)*(point-aMu)');
            bGauss = (1/(sqrt(2*pi)^2*sqrt(det(bSigma))))*exp(-0.5*(point - bMu)*inv(bSigma)*(point-bMu)');
            cGauss = (1/(sqrt(2*pi)^2*sqrt(det(cSigma))))*exp(-0.5*(point - cMu)*inv(cSigma)*(point-cMu)');

            [~,class] = max([aGauss bGauss cGauss]);
        end
        
        function class = nonParaClassifier(point, al, bl, cl, sigma)
            aSum = 0;
            bSum = 0;
            cSum = 0;

            for a = 1:length(al)
                aMu = [al(a, 1) al(a, 2)];
                aSum = aSum + (1/length(al)) * (1/(sqrt(2*pi)^2*sqrt(det(sigma))))*exp(-0.5*(point - aMu)*inv(sigma)*(point-aMu)');
            end

            for b = 1:length(bl)
                bMu = [bl(b, 1) bl(b, 2)];
                bSum = bSum + (1/length(bl)) * (1/(sqrt(2*pi)^2*sqrt(det(sigma))))*exp(-0.5*(point - bMu)*inv(sigma)*(point-bMu)');
            end

            for c = 1:length(cl)
                cMu = [cl(c, 1) cl(c, 2)];
                cSum = cSum + (1/length(cl)) * (1/(sqrt(2*pi)^2*sqrt(det(sigma))))*exp(-0.5*(point - cMu)*inv(sigma)*(point-cMu)');
            end

            [~, class] = max([aSum bSum cSum]);
        end        
    end
end
