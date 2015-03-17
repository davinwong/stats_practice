load lab2_3.mat

data = vertcat(a, b);

number_tests = 2;

%%% Part 4-3 %%%

% rows: # discrim
% columns: multiple tests
error_rates = [];

% rows: # discrim
% columns: avg err, min err, max err, std dev err
error_summary = [];

for j_discrim=1:5
	% disp('limit');
	% disp(j_discrim)

	% run multiple tests for each limit
	for i=1:number_tests
		% disp(i);
		g = get_sequential_discriminants(a, b, j_discrim);
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
		for d=(length(a)+1):(length(a)+length(b))
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
		disp(errors / (length(a) + length(b)));

		error_rates(j_discrim, i) = errors / (length(a) + length(b));

	end
end

disp(error_rates);

% for i=1:number_tests
% end


save('error_rates1.mat', 'error_rates');