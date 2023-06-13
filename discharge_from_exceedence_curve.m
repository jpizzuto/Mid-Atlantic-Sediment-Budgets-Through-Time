% discharge_from_exceedence_curve computes the 3-month peak flow duration
% curve and randomly selects a value
%
% first compute exceedence curve
%
compute_peak_Q_exceedence_curve
%
% pick random peak Q value
%
three_month_peak_Q_cms = pick_random_value(peak_Q_cms',exceedence');