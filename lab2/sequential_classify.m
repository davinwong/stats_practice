function y_out = sequential_classify(g, data)

	% A: 0
	% B: 1

	y = [];

	i_data = 1;
	j_discrim = 1;

	while i_data <= size(data,1)

		proto_a = g(j_discrim, 1:2);
		proto_b = g(j_discrim, 3:4);

		d_a = (data(i_data,:) - proto_a) * (data(i_data,:) - proto_a)';
		d_b = (data(i_data,:) - proto_b) * (data(i_data,:) - proto_b)';

		if d_b < d_a & g(j_discrim, 5) == 0
			% classify as B. start next data point.
			y(i_data, 1) = 1;
			i_data = i_data + 1;
			j_discrim = 1;

		elseif d_a < d_b & g(j_discrim, 6) == 0
			% classify as A. start next data point.
			y(i_data, 1) = 0;
			i_data = i_data + 1;
			j_discrim = 1;

		elseif j_discrim == size(g,1)
			% last discriminant reached
			if g(j_discrim, 5) == 0
				% classify as A. start next data point.
				y(i_data, 1) = 0;
				i_data = i_data + 1;
				j_discrim = 1;
			else
				% classify as B. start next data point.
				y(i_data, 1) = 1;
				i_data = i_data + 1;
				j_discrim = 1;
			end

		else
			% try next discriminant function
			j_discrim = j_discrim + 1;
		end

	end

	y_out = y;

end