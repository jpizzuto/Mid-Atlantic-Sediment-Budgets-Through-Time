% compute_sediment_flux.m computes the sediment flux during the current
% event in kg
%
% first compute sediment concentration in mg/l using scaled rating curve
Cs_mgperl = 610*...
    (three_month_peak_Q_cms/(0.0283*Q_1_25))^(1.101); %scaled relation
Cs_mgperl = Cs_mgperl*sediment_rating_curve_multiplier(1,j);
%
% convert Cs_mgperl to kg/m^3 (see notes in the sediment budget folder
% for derivation of the conversion factor)
Cs_kgpercum = 0.001*Cs_mgperl;
%
% call compute_overbank_flow_duration to determine duration of peak Q
%
compute_overbank_flow_duration
%
% convert duration of peak Q from days to seconds
%
peak_Q_duration_seconds = peak_Q_duration_days*24*3600;
sediment_transported_kg = ...
    Cs_kgpercum*three_month_peak_Q_cms*peak_Q_duration_seconds;