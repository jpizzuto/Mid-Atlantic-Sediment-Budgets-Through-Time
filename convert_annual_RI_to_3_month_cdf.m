% convert_annual_RI_to_3_month_cdf determines the cdf values for the
% annual recurrence intervals used by the Maryland Peak Discharge
% Regression equations
PDcdf_1_25 = ((1.25-1)/1.25)^0.25;
PDcdf_1_5 = ((1.5-1)/1.5)^0.25;
PDcdf_2 = ((2-1)/2)^0.25;
PDcdf_5 = ((5-1)/5)^0.25;
PDcdf_10 = ((10-1)/10)^0.25;
PDcdf_25 = ((25-1)/25)^0.25;
PDcdf_50 = ((50-1)/50)^0.25;
regression_peak_Q_cdf = zeros(1,7);
regression_peak_Q_cdf(1,1) = PDcdf_1_25;
regression_peak_Q_cdf(1,2) = PDcdf_1_5;
regression_peak_Q_cdf(1,3) = PDcdf_2;
regression_peak_Q_cdf(1,4) = PDcdf_5;
regression_peak_Q_cdf(1,5) = PDcdf_10;
regression_peak_Q_cdf(1,6) = PDcdf_25;
regression_peak_Q_cdf(1,7) = PDcdf_50;