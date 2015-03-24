load 4_3_graphs/4_3_error_summary1.mat

disp(error_summary);

x = [1,2,3,4,5];

%avg
y = error_summary(:, 1)';
plot(x,y,'b');
hold on

% min
y = error_summary(:, 2)';
plot(x,y,'r');
hold on

%max
y = error_summary(:, 3)';
plot(x,y,'g');

legend({'Average','Minimum', 'Maximum'});
xlabel('J (Limit of Discriminant Functions)');
ylabel('Error Rate');
print('error_graph1.png');

%standard deviation
% y = error_summary(:, 4)';
% plot(x,y,'b');
% xlabel('J (Limit of Discriminant Functions)');
% ylabel('Standard Deviation');
% print('std_dev_error.png');


pause;