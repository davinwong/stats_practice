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
        
        function class = nonParaClassifier(point, p)
            class = -1;
            pdfA = cell2mat(p(1));
            pdfB = cell2mat(p(2));
            pdfC = cell2mat(p(3));

            probA = pdfA(point);
            probB = pdfB(point);
            probC = pdfC(point);

            [~, class] = max([probA probB probC]);
        end
        
        %
        % Parzen - compute 2-D density estimates
        %
        % [p,x,y] = parzen( data, res, win )    
        %
        %  data - two-column matrix of (x,y) points
        %         (third row/col optional point frequency)
        %  res  - resolution (step size)
        %         optionally [res lowx lowy highx highy]
        %  win  - optional, gives form of window 
        %          if a scalar - radius of square window
        %          if a vector - radially symmetric window
        %          if a matrix - actual 2D window shape
        %
        %  x    - locations along x-axis
        %  y    - locations along y-axis
        %  p    - estimated 2D PDF
        %

        %
        % P. Fieguth
        % Nov. 1997
        %

        function [p,x,y] = parzen( data, res, win )

            if (size(data,2)>size(data,1)), data = data'; end;
            if (size(data,2)==2), data = [data ones(size(data))]; end;
            numpts = sum(data(:,3));

            dl = min(data(:,1:2));
            dh = max(data(:,1:2));
            if length(res)>1, dl = [res(2) res(3)]; dh = [res(4) res(5)]; res = res(1); end;

            if (nargin == 2), win = 10; end;
            if (max(dh-dl)/res>1000), 
              error('Excessive data range relative to resolution.');
            end;

            if length(win)==1, win = ones(1,win); end;
            if min(size(win))==1, win = win(:) * win(:)'; end;
            win = win / (res*res*sum(sum(win)));

            p = zeros(round(2+(dh(2)-dl(2))/res),round(2+(dh(1)-dl(1))/res));
            fdl1 = find(data(:,1)>dl(1));
            fdh1 = find(data(fdl1,1)<dh(1));
            fdl2 = find(data(fdl1(fdh1),2)>dl(2));
            fdh2 = find(data(fdl1(fdh1(fdl2)),2)<dh(2));

            for i=fdl1(fdh1(fdl2(fdh2)))',
              j1 = round(1+(data(i,1)-dl(1))/res);
              j2 = round(1+(data(i,2)-dl(2))/res);
              p(j2,j1) = p(j2,j1) + data(i,3);
            end;

            p = conv2(p,win,'same')/numpts;
            x = [dl(1):res:(dh(1)+res)]; x = x(1:size(p,2));
            y = [dl(2):res:(dh(2)+res)]; y = y(1:size(p,1));
        end
    end
end
