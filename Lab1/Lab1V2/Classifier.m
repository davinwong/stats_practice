classdef Classifier
    
    properties
        mu
        sigma
        prob
        cluster
    end
    methods
        
        function class = Classifier(mu, sigma, prob, size) 
            class.mu = mu;
            class.sigma = sigma;
            class.prob = prob;
            class.cluster = gaussTransform(randn(size,2),class.mu,class.sigma);
        end
        
        function plotStdDev(class, colour)
            x=class.mu(1);
            y=class.mu(2);
            [V,D] = eig(class.sigma);
            distA = sqrt(D(1,1));
            distB = sqrt(D(2,2));
            
            theta = atan(V(2,1)/V(1,1));
            
            np = 100;
            ang = [0:np]*2*pi/np;
            pts = [x;y]*ones(size(ang)) + [cos(theta) -sin(theta);...
                sin(theta) cos(theta)]*[cos(ang)*distA; sin(ang)*distB];
            plot( pts(1,:), pts(2,:), colour);
        end
        
        function plotData(class, colour)
            x = class.cluster*[1;0];
            y = class.cluster*[0;1];
            scatter(x,y,5,strcat('*',colour));
        end
    end
    
    methods (Static = true)
        
        function c = medDistance(classes, point)
            c = 0;
            d = Inf;
            for k = 1:length(classes)
                medDist = (point - classes{k}.mu)'*(point - classes{k}.mu);
                if medDist <= d
                   c = k;
                   d = medDist;
                end
            end
        end
        
        function map = medClassifier(classes, x, y)
           map = zeros(length(x),length(y));
           for i = 1:length(x)
               for j = 1:length(y)
                    point = [x(i) y(j)]';
                    map(i,j) = Classifier.medDistance(classes,point);
               end
           end
        end
        
        function c = gedDistance(classes,point)
            c = 0; 
            d = Inf; 
            for k = 1:length(classes)
                gedDist = (point - classes{k}.mu)'*classes{k}...
                    .sigma^(-1)*(point - classes{k}.mu);
                if gedDist <= d
                   c = k;
                   d = gedDist;
                end
            end
        end
                
        function map = gedClassifier(classes, x, y)
           map = zeros(length(x),length(y));
           for i = 1:length(x)
               for j = 1:length(y)
                   point = [x(i) y(j)]';
                   map(i,j) = Classifier.gedDistance(classes,point);
               end
           end
        end
        
        function m = mapDistance(classes,point)
            m = 0;
            d = 0;
            for k = 1:length(classes)
                gedDist = (point - classes{k}.mu)'*classes{k}.sigma^(-1)...
                    *(point - classes{k}.mu);
                mapDist = classes{k}.prob * sqrt(2 * pi * det(classes{k}...
                    .sigma))^(-1) * exp(-.5 * gedDist);
                if mapDist >= d
                    m = k;
                    d = mapDist;
                end
            end
        end
        
        function map = mapClassifier(classes, x, y)
            map = zeros(length(x),length(y));
            for i = 1:length(x)
                for j = 1:length(y)
                    point = [x(i) y(j)]';
                    map(i,j) = Classifier.mapDistance(classes,point);
                end
            end
        end
    end
    
end