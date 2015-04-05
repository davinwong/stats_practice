%%% black white %%%
cup = imread('cup.jpg');
cup = rgb2gray(cup);
% imwrite(cup, 'cup_bw.jpg');


%%% downsample %%%
% cup = imread('cup_bw.png');
% cup = imresize(cup, 0.5);
cup = im2double(cup);
% imwrite(cup, 'cup_bw_downsample.png');


%%% singular value decomposition %%%
[u, s, v] = svd(cup);

% limit of singular values. higher limit decreases size at cost of image quality
limit = 70;

u_2 = u(:, 1:limit);
s_2 = s(1:limit, 1:limit);
v_2 = v(:, 1:limit);

% reconstruct matrix
cup_2 = u_2 * s_2 * v_2';

% imwrite(cup_2, strcat('cup_bw_processed_', num2str(limit), '.png'));

disp(size(cup));

disp(size(u));
disp(size(s));
disp(size(v));

disp(size(u_2));
disp(size(s_2));
disp(size(v_2));