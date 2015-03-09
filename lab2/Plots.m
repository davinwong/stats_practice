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
    end
end
