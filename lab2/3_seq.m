load lab2_3.mat

j = 1;

% proto_a, proto_b, n_aB, n_bA
g = [];

while length(a) > 0 | length(b) > 0

	if length(a) > 0
		r_a = randi([1, length(a)]);
		proto_a = a(r_a,:);
	else
		proto_a = [99999999999999999999999999999999999999999999999 99999999999999999999999999999999999999999999999];
	end

	if length(b) > 0
		r_b = randi([1, length(b)]);
		proto_b = b(r_b,:);
	else
		proto_b = [99999999999999999999999999999999999999999999999 99999999999999999999999999999999999999999999999];
	end

	% error: number in a incorrectly classified as B
	n_aB = 0;

	n_bA = 0;

	% next version (not yet correct with current discriminants)
	next_a = [];
	next_b = [];

	% iterate a
	for i=1:length(a)
		d_a = (a(i,:) - proto_a)' * (a(i,:) - proto_a)
		d_b = (a(i,:) - proto_b)' * (a(i,:) - proto_b)

		if d_a < d_b
			;
		else
			% error
			n_aB = n_aB + 1;

			% add to next version
			next_a(end+1,:) = a(i,:)
		end
	end

	% iterate b
	for i=1:length(b)
		d_a = (b(i,:) - proto_a)' * (b(i,:) - proto_a)
		d_b = (b(i,:) - proto_b)' * (b(i,:) - proto_b)

		if d_a < d_b
			% error
			n_bA = n_bA + 1;

			% add to next version
			next_b(end+1,:) = b(i,:)
		else
			;
		end
	end

	% ignore prototype if it classifies neither class completely correctly
	if n_aB ~= 0 & n_bA ~= 0
		continue
	end

	% save prototype, a/b success
	g(j,:) = [proto_a, proto_b, n_aB, n_bA];
	j = j + 1;

	% use next version. removes a, b elements that were already correctly classified
	a = next_a;
	b = next_b;

end


disp('GGG');
disp(g);

disp('LENGTHS');
disp(length(a));
disp(length(b));
% disp('AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA');
% disp(a);
% disp('BBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBBB');
% disp(b);