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
        
        function class = paraClassifier(means, point, variances)
            class = -1;
            mu = [];
            sigma = [];
            numMeans = length(means(:, end));
            count = 0;
            for k=1:numMeans
                mu{k} = [means(k, 1) means(k, 2)];
                sigma{k} = [variances(k+count,1) variances(k+count,2); variances(k+count+1, 1) variances(k+count+1, 2)];
                count = count + 1;
            end

            muA = cell2mat(mu(1)); muB = cell2mat(mu(2)); muC = cell2mat(mu(3));
            sigA = cell2mat(sigma(1)); sigB = cell2mat(sigma(2)); sigC = cell2mat(sigma(3));

            guassA = 1/(sqrt(2*pi)^2*sqrt(det(sigA)))*exp(-0.5*(point - muA)*inv(sigA)*(point-muA)');
            guassB = 1/(sqrt(2*pi)^2*sqrt(det(sigB)))*exp(-0.5*(point - muB)*inv(sigB)*(point-muB)');
            guassC = 1/(sqrt(2*pi)^2*sqrt(det(sigC)))*exp(-0.5*(point - muC)*inv(sigC)*(point-muC)');

            [~,class] = max([guassA guassB guassC]);
        end
    end
end
