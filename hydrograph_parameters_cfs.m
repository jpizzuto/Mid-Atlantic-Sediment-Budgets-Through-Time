function [coefficient,exponent] = ...
    hydrograph_parameters_cfs(pct_imperv,pct_forest)
%
% hydrograph_parameters computes the coefficient and exponent of the
% hydrograph shape function power law using regression results
% This version has revised equations and parameters based on the 20 %
% cdf (80% exceedence) event threshold discharge
if pct_imperv > 10
    exponent = 0.8919 + 0.01566*(pct_imperv); 
    coefficient = 7.472 + 0.007442*(exp(0.1434*pct_imperv));
else
    exponent = 1.501 - 0.00628*(pct_forest+1);
    coefficient = 8.525 - 0.03833*(pct_forest+1);
end