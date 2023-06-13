function y=pick_random_value(x_data,cum_dist_of_x_data)
%
% the function pick_random_value selects a random
% value following the observed distribution of x summarized in
% x_data and the cumulative distribution of x given by
% cum_dist_of_x_data
cum_value = unifrnd(0,1); % uniformly distributed random number on 0,1
y = interp1(cum_dist_of_x_data,x_data,cum_value);
end