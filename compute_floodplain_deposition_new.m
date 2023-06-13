% compute_floodplain_deposition determines how much sediment is deposited
% during a specific overbank flow
%
compute_overbank_flow_duration
%
% rating curve to compute suspended sediment concentration
%
Cs_mgperl = 610*...
    (three_month_peak_Q_cms/(0.0283*Q_1_25))^(1.101); %scaled relation
Cs_mgperl = Cs_mgperl*sediment_rating_curve_multiplier(1,j);
Cs = (Cs_mgperl*1E-6)/2.65; % convert to concentration by volume
%
% now compute thickness deposited during the event
%
overbank_duration_seconds = overbank_duration_days*24*60*60;
thickness_deposited_in_one_flood = Vs*Cs*overbank_duration_seconds/...
    (1-porosity);
% also compute the mass of sediment deposited in kg for sediment
% budgeting
if sediment_budget == 1
  Cs_kgpercum = 0.001*Cs_mgperl;
  floodplain_deposition_kg = ...
    Cs_kgpercum*Vs*floodplain_width*reach_length*overbank_duration_seconds;
end