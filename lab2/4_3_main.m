load lab2_3.mat

data = vertcat(a, b);

%%% Part 4-3 %%%

error_rates = [];

for limit_discrim=1:5
	% disp('limit');
	% disp(limit_discrim)

	% run multiple tests for each limit
	for i=1:20
		% disp(i);
		g = get_sequential_discriminants(a, b, limit_discrim);
		y = sequential_classify(g, data);

		% calculate error rate
		errors = 0;

		% a
		for d=1:length(a)
			if y(d,1) == 0
				;
			else
				errors = errors + 1;
			end
		end

		% b
		for d=(length(a)+1):length(b)
			if y(d,1) == 1
				;
			else
				errors = errors + 1;
			end
		end

		disp('err');
		disp(errors);
		disp('lengths');
		disp(length(a));
		disp(length(b));
		disp('error_rate');
		disp(errors / (length(a) + length(b)))

		error_rates(limit_discrim, i) = errors / (length(a) + length(b));

	end
end

disp(error_rates);



