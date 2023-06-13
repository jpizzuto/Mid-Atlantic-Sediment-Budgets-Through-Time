% compute_two_function_rep computes the erosion exposure function
% and rate constant
% as a function of the age of the layer being eroded
% 
% This version uses a constant initial rep that transitions to a 
% power-law
%
%
initial_rep = 1/600;
power_law_offset = 1000;
power_law_exponent = 1;
switch_age = 640;
switch_constant = 0.01;
logistic_switch = 1./(1+exp(switch_constant*(switch_age - contact_ages)));
% power function
%
power = ((contact_ages + power_law_offset)./power_law_offset)...
    .^(-power_law_exponent);
rep_data = initial_rep.*(1-logistic_switch) + ...
      initial_rep.*logistic_switch.*(power);
