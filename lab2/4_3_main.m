load lab2_3.mat

data = vertcat(a, b);


%%% Part 4-3 %%%

max_limit_discrim = 5;
number_tests = 20;

% rows: # discrim
% columns: multiple tests
error_rates = [];

% rows: # discrim
% columns: error: avg, min, max, std dev
error_summary = [];


% run accuracy tests with varying discrim limits
for j_limit_discrim=1:max_limit_discrim
	% disp('limit');
	% disp(j_limit_discrim)

	% run multiple tests for each limit
	for i=1:number_tests
		% disp(i);
		g = get_sequential_discriminants(a, b, j_limit_discrim);
		y = sequential_classify(g, data);
		disp('ggg');
		disp(g);

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
		for d=(length(a)+1):(length(a)+length(b))
			if y(d,1) == 1
				;
			else
				errors = errors + 1;
			end
		end

		% disp('err');
		% disp(errors);
		% disp('error_rate');
		% disp(errors / (length(a) + length(b)));

		error_rates(j_limit_discrim, i) = errors / (length(a) + length(b));

	end
end

disp(error_rates);

for j=1:max_limit_discrim
	error_summary(j, 1) = mean(error_rates(j, :));
	error_summary(j, 2) = min(error_rates(j, :));
	error_summary(j, 3) = max(error_rates(j, :));
	error_summary(j, 4) = std(error_rates(j, :));
end

disp('rows: # discrim');
disp('columns: error: avg, min, max, std dev');
disp(error_summary);


save('error_rates1.mat', 'error_rates', 'error_summary');