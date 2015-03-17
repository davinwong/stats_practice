load lab2_3.mat

data = vertcat(a, b);

%%% Part 4-3 %%%

for limit_discrim=1:5
	disp('limit');
	disp(limit_discrim)

	for i=1:20
		disp(i);
		g = get_sequential_discriminants(a, b, limit_discrim);
		y = sequential_classify(g, data);

	end
end



