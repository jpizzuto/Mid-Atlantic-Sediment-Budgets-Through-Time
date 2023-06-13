% compute_peak_Q_exceedence_curve uses the drainage basin area
% and % Forest as predictors of the peak Q exceedence curve
% for mid-Atlantic watersheds
%
% Maryland peak Q regression equations are used to determine
% peak Q for return periods between 1.25 and 50 years.
%
% The minimum 3-month peak Q is determined from a regression 
% relationship fit to data from Maryland (and the South River).
%
% Between the 3-month minimum Q and the 1.25 year return period
% peak Q, the exceedence curve is assumed to be exponential
%
%
% Basic data
%
DA_sq_mi = 0.386192*drainage_area;
Lime = 0; % % limestone
pct_forest = pct_forest_per_time_step(j);
pct_impervious = imperviousness_by_time_step(j);
% Use regression results to predict 3-month return period Q (here, min_Q)
if pct_impervious > 10
 min_Q_cms=drainage_area*(4.59749E-6*(pct_impervious^(3.101)));
else
 min_Q_cms=drainage_area*(0.7119*(pct_forest+1)^(-1.129));
end
%
% Md regression equations for peak Q > 1.25 year return period
%
if pct_impervious < 10 
	Maryland_Annual_Peak_Q_regression_equations
   else
	Maryland_Annual_Peak_Q_regression_equations_urban  
end
% convert to cms
regression_peak_Q_cms = 0.0283*regression_peak_Q;
% compute 3-month recurrence cdf
convert_annual_RI_to_3_month_cdf
% convert cdf to exceedence
regression_exceedence = 1-regression_peak_Q_cdf;
% create exceedence array for "low flows"
exceedence = 1:-0.01:0.33; % 68 "low flow" exceedence values
% compute mean Q for low flow exponential exceedence
% see notes on E Exceedence with Exponential Scaling
mean_Q_cms = ...
    (regression_peak_Q_cms(1,1)-min_Q_cms)/(-log(0.33126));
%
% now compute the Q values associated with the exponential exceedence
% curve
%
peak_Q_cms = (-log(exceedence))*mean_Q_cms + min_Q_cms;
peak_Q_cms(1,69:75) = regression_peak_Q_cms;
peak_Q_cms(1,76) = 1.1*peak_Q_cms(1,75);
exceedence(1,69:75) = regression_exceedence;
exceedence(1,76) = 0; % to avoid selecting NAN peak Q