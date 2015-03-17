load lab2_3.mat


g = get_sequential_discriminants(a, b);

disp('g');
disp(g);

% data = vertcat(a, b);

% y = sequential_classify(g, data);

% disp(y);




% Part 4-1


% x = vertcat(a(:, 1), b(:, 1));
% y = vertcat(a(:, 2), b(:, 2));
% c = vertcat( zeros(length(a)) + 10, zeros(length(b)) + 70);


scatter(a(:, 1), a(:, 2), 'r');
hold on
scatter(b(:, 1), b(:, 2), 'g');
hold on

for j=1:length(g)

	ax = g(j, 1);
	ay = g(j, 2);
	bx = g(j, 3);
	by = g(j, 4);

	x = linspace(0,600,10);
	y = (2*ax*x - ax^2 - ay^2 - 2*bx*x + bx^2 + by^2) / (-2*ay + 2*by);
	disp(y);
	plot(x,y,'b');
	hold on

end

axis([0 600 0 600])

pause;



