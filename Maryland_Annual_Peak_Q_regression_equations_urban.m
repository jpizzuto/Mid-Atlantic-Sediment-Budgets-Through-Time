% Maryland_Annual_Peak_Q_regression_equations_urban.m 
% computes peak discharges for urbanized basins
Q_1_25 = 17.85*(DA_sq_mi^0.652)*((pct_impervious+1)^(0.635));
Q_1_5 = 24.66*(DA_sq_mi^0.648)*((pct_impervious+1)^(0.631));
Q_2 = 37.01*(DA_sq_mi^0.635)*((pct_impervious+1)^(0.588));
Q_5 = 94.76*(DA_sq_mi^0.624)*((pct_impervious+1)^(0.499));
Q_10 = 169.2*(DA_sq_mi^0.622)*((pct_impervious+1)^(0.435));
Q_25 = 341.0*(DA_sq_mi^0.619)*((pct_impervious+1)^(0.349));
Q_50 = 562.4*(DA_sq_mi^0.619)*((pct_impervious+1)^(0.284));
regression_peak_Q = zeros(1,7);
regression_peak_Q(1,1) = Q_1_25;
regression_peak_Q(1,2) = Q_1_5;
regression_peak_Q(1,3) = Q_2;
regression_peak_Q(1,4) = Q_5;
regression_peak_Q(1,5) = Q_10;
regression_peak_Q(1,6) = Q_25;
regression_peak_Q(1,7) = Q_50;






