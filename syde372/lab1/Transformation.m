classdef ParametricClass
    %Class containing a Pattern Rec Classification Class
    
    properties
        Mu
        Sigma
        Probability
    end
    
    methods
        %% Initialzation
        function PC = ParametricClass(mu, sigma, prob)
            PC.Mu = mu;
            PC.Sigma = sigma;
            PC.Probability = prob;
        end
        
        %% Plotting
        function t = TestData(PC, n_pts)
            t = NonParametricClass(PC.Mu, PC.Sigma, n_pts);
        end
        
        function PlotStdDev(PC, colour)
            x=PC.Mu(1);
            y=PC.Mu(2);

            [V,D]= eig(PC.Sigma);

            rta = sqrt(D(1,1));
            rtc = sqrt(D(2,2));

            theta = atan(V(2,1)/V(1,1));
            
            PlotEllipse(x,y,theta,rta,rtc, colour)
        end
        
        %% Distance Calculations
        % MED
        function d = MED(PC, point)
            d = (point - PC.Mu)'*(point - PC.Mu); %dist squared
        end
        
        % GED
        function d = GED(PC, point)
            d = (point - PC.Mu)'*PC.Sigma^(-1)*(point - PC.Mu); %dist squared
        end
        
        function p = MAP(PC, point)
           p = PC.Probability * sqrt(2 * pi * det(PC.Sigma))^(-1) * exp(-0.5 * PC.GED(point)); %probability-ish
        end
    end
    
    %% Static Methods
    methods (Static = true)
        %% Classification Methods
        % Classify based on MED
        % Use: ParametricClass.ClassifyMED( unknown_point, {Class1 Class2})
        % Returns: The index of the selected class.
        function c = ClassifyMED(point, classes)
            c = 0; %The class index
            d = Inf; %The distance
            for i = 1:length(classes)
                if classes{i}.MED(point) <= d
                   c = i;
                   d = classes{i}.MED(point);
                end
            end
        end
        
        % Classify based on GED
        % Use: ParametricClass.ClassifyGED( unknown_point, {Class1 Class2})
        % Returns: The index of the selected class.
        function c = ClassifyGED(point, classes)
            c = 0; %The class index
            d = Inf; %The distance
            for i = 1:length(classes)
                if classes{i}.GED(point) <= d
                   c = i;
                   d = classes{i}.GED(point);
                end
            end
        end
        
        % Classify based on MAP
        % Use: ParametricClass.ClassifyMAP( unknown_point, {Class1 Class2}, {P1 P2})
        % Returns: The index of the selected class.
        function c = ClassifyMAP(point, classes)
            c = 0; %The class index
            p = 0;
            for i = 1:length(classes)
                if classes{i}.MAP(point) >= p
                   c = i;
                   p = classes{i}.MAP(point);
                end
            end
        end
        
        %% Boundary Plotting Methods
        % Plot boundary based on MED
        function map = BoundMatrixMED(classes, x_pts, y_pts)
           map = zeros(length(x_pts),length(y_pts));
           for i = 1:length(x_pts)
               for j = 1:length(y_pts)
                   map(i,j) = ParametricClass.ClassifyMED([x_pts(i) y_pts(j)]', classes);
               end
           end
        end
        
        % Plot boundary based on GED
        function map = BoundMatrixGED(classes, x_pts, y_pts)
           map = zeros(length(x_pts),length(y_pts));
           for i = 1:length(x_pts)
               for j = 1:length(y_pts)
                   map(i,j) = ParametricClass.ClassifyGED([x_pts(i) y_pts(j)]', classes);
               end
           end
        end
        
        % Plot boundary based on MAP
        function map = BoundMatrixMAP(classes, x_pts, y_pts)
           map = zeros(length(x_pts),length(y_pts));
           for i = 1:length(x_pts)
               for j = 1:length(y_pts)
                   map(i,j) = ParametricClass.ClassifyMAP([x_pts(i) y_pts(j)]', classes);
               end
           end
        end
        
        %% Testing Methods
        % Generate confusion matrix based on MED
        function conf = ConfusionMatrixMED(classes, test_data)
            conf = zeros(length(classes));
            
            %populate test classes and confusion matrix
            for i=1:length(classes)
                td_size = size(test_data{i}.Cluster);
                for j=1:td_size(1)
                    c = ParametricClass.ClassifyMED(test_data{i}.Cluster(j, :)', classes);
                    conf(c,i) = conf(c,i) + 1;
                end
            end
            
        end
        
        % Generate confusion matrix based on GED
        function conf = ConfusionMatrixGED(classes, test_data)
            conf = zeros(length(classes));
            
            %populate test classes and confusion matrix
            for i=1:length(classes)
                td_size = size(test_data{i}.Cluster);
                for j=1:td_size(1)
                    c = ParametricClass.ClassifyGED(test_data{i}.Cluster(j, :)', classes);
                    conf(c,i) = conf(c,i) + 1;
                end
            end
            
        end
        
        % Generate confusion matrix based on MAP
        function conf = ConfusionMatrixMAP(classes, test_data)
            conf = zeros(length(classes));
            
            %populate test classes and confusion matrix
            for i=1:length(classes)
                td_size = size(test_data{i}.Cluster);
                for j=1:td_size(1)
                    c = ParametricClass.ClassifyMAP(test_data{i}.Cluster(j, :)', classes);
                    conf(c,i) = conf(c,i) + 1;
                end
            end
            
        end
        
        function prob = ErrorProbability(confusion)
            correct = diag(diag(confusion));
            incorrect = confusion - correct;
            prob = sum(sum(incorrect)) / sum(sum(confusion));
        end
    end
end