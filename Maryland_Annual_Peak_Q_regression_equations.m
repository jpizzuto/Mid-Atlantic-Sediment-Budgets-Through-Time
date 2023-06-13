% Maryland_Annual_Peak_Q_regression_equations.m computes peak discharges
% based on drainage basin area, % forest, and % impervious
Q_1_25 = 287.1*(DA_sq_mi^0.774)*((pct_forest+1)^(-.418))*((Lime+1)^(-.118));
Q_1_5 = 327.3*(DA_sq_mi^0.758)*((pct_forest+1)^(-.358))*((Lime+1)^(-.121));
Q_2 = 396.9*(DA_sq_mi^0.743)*((pct_forest+1)^(-.332))*((Lime+1)^(-.124));
Q_5 = 592.5*(DA_sq_mi^0.705)*((pct_forest+1)^(-.237))*((Lime+1)^(-.133));
Q_10 = 751.1*(DA_sq_mi^0.682)*((pct_forest+1)^(-.183))*((Lime+1)^(-.138));
Q_25 = 996.0*(DA_sq_mi^0.655)*((pct_forest+1)^(-.122))*((Lime+1)^(-.145));
Q_50 = 1218.8*(DA_sq_mi^0.635)*((pct_forest+1)^(-.082))*((Lime+1)^(-.150));
regression_peak_Q = zeros(1,7);
regression_peak_Q(1,1) = Q_1_25;
regression_peak_Q(1,2) = Q_1_5;
regression_peak_Q(1,3) = Q_2;
regression_peak_Q(1,4) = Q_5;
regression_peak_Q(1,5) = Q_10;
regression_peak_Q(1,6) = Q_25;
regression_peak_Q(1,7) = Q_50;






