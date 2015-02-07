
classdef Tools
    %Tools Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods (Static = true)
        function ParametricPlot(classes, colours, n_pts, x_range, y_range, contours, names)
            
            % Plot the clusters and the unit standard deviations
            for i=1:length(classes)
                classes{i}.TestData(classes{i}.Probability * n_pts).PlotCluster(colours{i})
                hold on;
                classes{i}.PlotStdDev(colours{i})
                hold on;
            end

            % Calculate and plot the boundaries
            m = ParametricClass.BoundMatrixMED(classes, x_range, y_range);
            g = ParametricClass.BoundMatrixGED(classes, x_range, y_range);
            p = ParametricClass.BoundMatrixMAP(classes, x_range, y_range);

            bounds = {m g p};
            bound_styles = {'cyan' 'magenta' ':black'};

            for i=1:length(bounds)
                contour(x_range, y_range, bounds{i}', contours, bound_styles{i}, 'LineWidth', 1)
                hold on;
            end
            
            legend(names)

        end
        
        function NonParametricPlot(classes, colours, n_pts, x_range, y_range, contours, names)
            % Create the NP Classes and plot the clusters
            np_classes = {};
            for i=1:length(classes)
                np_classes{i} = classes{i}.TestData(classes{i}.Probability * n_pts);

                np_classes{i}.PlotCluster(colours{i})
                hold on;
            end
            
            % Compute the boundaries
            n = NonParametricClass.BoundMatrixKNN(np_classes, 1, x_range, y_range);
            k = NonParametricClass.BoundMatrixKNN(np_classes, 5, x_range, y_range);

            bounds = {n k};
            bound_styles = {'black' 'magenta'};

            for i=1:length(bounds)
                contour(x_range, y_range, bounds{i}', contours, bound_styles{i}, 'LineWidth', 1)
                hold on;
            end
            
            legend(names)
        end
        
        function Testing(classes, n_pts)
            np_classes = cell(size(classes));
            test_data = cell(size(classes));
            
            for i=1:length(classes)
                np_classes{i} = classes{i}.TestData(n_pts{i}); %n_pts
                test_data{i} = classes{i}.TestData(n_pts{i});
            end

            conf_MED = ParametricClass.ConfusionMatrixMED(classes, test_data)
            prob_MED = ParametricClass.ErrorProbability(conf_MED)

            conf_GED = ParametricClass.ConfusionMatrixGED(classes, test_data)
            prob_GED = ParametricClass.ErrorProbability(conf_GED)

            conf_MAP = ParametricClass.ConfusionMatrixMAP(classes, test_data)
            prob_MAP = ParametricClass.ErrorProbability(conf_MAP)

            conf_NN = NonParametricClass.ConfusionMatrixKNN(np_classes, test_data, 1)
            prob_NN = NonParametricClass.ErrorProbability(conf_NN)

            conf_kNN = NonParametricClass.ConfusionMatrixKNN(np_classes, test_data, 5)
            prob_kNN = NonParametricClass.ErrorProbability(conf_kNN) 
        end
    end
end