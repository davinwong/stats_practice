% could optimize with dynamic programming by memo-izing position of training data
% start at grid position and expand from there until k neighbors are found

function G = k_nearest_neighbor(x_length, y_length, training, classes, k)
scale = 1;

% grid = zeros(x_length, y_length)

% for every grid point
for x=1:x_length
	for y=1:y_length
		% k rows for k points
		% first column: classes
		% second column: distance
		k_best_points = zeros(k, 2);

		% initialize k best points
		for p=1:k
			current_distance = (scale*x - training(p,1))^2 + (scale*y - training(p,2))^2;
			k_best_points(p, 1) = classes(p);
			k_best_points(p, 2) = current_distance;
		end

		% calculate distance from grid point to each training point
		% store the k-best training points (with class)
		for p=k:length(training)
			current_class = classes(p);
			current_distance = (scale*x - training(p,1))^2 + (scale*y - training(p,2))^2;

			for b=1:k
				if current_distance < k_best_points(b, 2)
					temp_class = k_best_points(b, 1);
					temp_distance = k_best_points(b, 2);

					k_best_points(b, 1) = current_class;
					k_best_points(b, 2) = current_distance;

					current_class = temp_class;
					current_distance = temp_distance;

				end
			end
		end

		% of the best/closest points, the most frequent is the class given to the grid
		grid(x,y) = mode(k_best_points(1));
	end
end

G = grid;

end