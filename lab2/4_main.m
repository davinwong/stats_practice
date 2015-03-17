load lab2_3.mat


g = get_sequential_discriminants(a, b);

disp('g');
disp(g);

data = vertcat(a, b);

y = sequential_classify(g, data);

disp(y);





