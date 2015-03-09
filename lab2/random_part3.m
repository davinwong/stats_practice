for i=1:length(delete_a)
	a(i,:) = [];
end




a( (a(i,:) - proto_a)' * (a(i,:) - proto_a) < (a(i,:) - proto_b)' * (a(i,:) - proto_b) , :) = [];

b( (b(i,:) - proto_a)' * (b(i,:) - proto_a) < (b(i,:) - proto_b)' * (b(i,:) - proto_b) , :) = [];




if n_aB == 0
		% delete from a
		for i=1:length(delete_a)
			disp('yolooo');
			disp(i);
			disp(delete_a(i));
			a(delete_a(i),:) = [];
			% since an element was deleted, positions of elements to be deleted were shifted
			delete_a - 1;
		end
		% -1
		
	end

	if n_bA == 0
		% delete from b
		for i=1:length(delete_b)
			b(delete_b(i),:) = [];
			delete_b - 1;
		end
	end