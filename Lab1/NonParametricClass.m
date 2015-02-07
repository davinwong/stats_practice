classdef NonParametricClass
    %NonParametricClass Contains a non-parametric class
    %   Holds a set of points that form a cluster
    
    properties
        Cluster
    end
    
    methods
        %% Initialization
        function NPC = NonParametricClass(mu, sigma, n_pts)
           NPC.Cluster = mvnrnd(mu, sigma, n_pts);
        end
        
        %% Plotting
        function PlotCluster(NPC, colour)
           Y_1=NPC.Cluster*[1;0];
           Y_2=NPC.Cluster*[0;1];
           scatter(Y_1, Y_2, 5, strcat('*', colour)) 
        end
        
        %% Distance
        function d = kNN(NPC, point, k)
           d = inf;
           s_cluster = size(NPC.Cluster);
           p = repmat(point,1,s_cluster(1));
           d_matrix = sort(sqrt(diag((p' - NPC.Cluster)*(p' - NPC.Cluster)')));
           d = d_matrix(k);
        end
    end
    
    %% Static Methods
    methods (Static = true)
        % Classify based on kNN
        % Use: NonParametricClass.ClassifyKNN( unknown_point, {Class1 Class2}, k)
        % Returns: The index of the selected class.
        function c = ClassifyKNN(point, classes, k)
            c = 0; %The class index
            d = Inf; %The distance
            for i = 1:length(classes)
                if classes{i}.kNN(point, k) <= d
                   c = i;
                   d = classes{i}.kNN(point, k);
                end
            end
        end
    
        %% Boundary Plotting Methods
        % Plot boundary based on KNN
        function map = BoundMatrixKNN(classes, k, x_pts, y_pts)
           map = zeros(length(x_pts),length(y_pts));
           for i = 1:length(x_pts)
               for j = 1:length(y_pts)
                   map(i,j) = NonParametricClass.ClassifyKNN([x_pts(i) y_pts(j)]', classes, k);
               end
           end
        end
        
        %% Testing Methods
        % Generate confusion matrix based on kNN
        function conf = ConfusionMatrixKNN(classes, test_data, k)
            conf = zeros(length(classes));
            
            %populate test classes and confusion matrix
            for i=1:length(classes)
                td_size = size(test_data{i}.Cluster);
                for j=1:td_size(1)
                    c = NonParametricClass.ClassifyKNN(test_data{i}.Cluster(j, :)', classes, k);
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