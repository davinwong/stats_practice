% could optimize with dynamic programming by memo-izing position of training data
% start at grid position and expand from there until k neighbors are found

function G = k_nearest_neighbor(x_length, y_length, training, classes, k)
scale = 0.1;

% grid = zeros(x_length, y_length)

for x=1:x_length
	for y=1:y_length
		best_class = 0;
		closest = 9999999999;

		for d=1:length(training)
			square_distance = (scale*x - training(d,1))^2 + (scale*y - training(d,2))^2;
			if square_distance < closest
				closest = square_distance;
				best_class = classes(d);
			end
		end

		grid(x,y) = best_class;
	end
end

G = grid;

end