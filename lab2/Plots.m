classdef Plots
    methods(Static)
        
        function plotGauss(mu, sigma, b)

            minX = mu - (5 * sigma);
            maxX = mu + (5 * sigma);
            x = minX:1e-3:maxX;
            y = pdf('normal', x, mu, sigma);
            plot(x, y, b);
            
            %hold on
            
            %yL = get(gca,'YLim');
            %line([mu mu],yL,'Color',b);
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
    end
end
