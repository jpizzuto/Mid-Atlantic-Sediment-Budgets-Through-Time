% sed_rating_curve_multiplier_though_time.m assigns values to the 
% sediment rating curve multiplier for each deposited contact
%
% sediment sediment rating curve multipliers for each time period
%
% calibrated ranges for the sediment rating curve multipliers
%   pre-settlement: 7.5 phi: 0.05 - 0.06; 7.7 phi: 0.06-0.08 
%   legacy: 7.5 phi: 0.25; 7.7 phi: 0.35
pre_settlement_sediment_rating_curve_multiplier = 0.05;
legacy_sediment_rating_curve_multiplier = 0.25;
modern_sediment_rating_curve_multiplier = 1;
% erosion parameter "r" for each time period
pre_settlement_erosion_multiplier = 1;
legacy_erosion_multiplier = 1;
modern_erosion_multiplier = 1;
% assign presettlement multipliers
presettlement_indices = find(contact_calendar_dates <= 1750);
sediment_rating_curve_multiplier(presettlement_indices) = ...
    pre_settlement_sediment_rating_curve_multiplier;
r_parameter(presettlement_indices) = pre_settlement_erosion_multiplier;
if end_year > 1750
    legacy_indices = find(contact_calendar_dates <= 1950);
    legacy_indices = find(contact_calendar_dates(legacy_indices) >= 1750);
    sediment_rating_curve_multiplier(legacy_indices) = ...
        legacy_sediment_rating_curve_multiplier;
    r_parameter(legacy_indices) = legacy_erosion_multiplier;
end
if end_year > 1950
    modern_indices = find(contact_calendar_dates >= 1950);
    sediment_rating_curve_multiplier(modern_indices) = ...
        modern_sediment_rating_curve_multiplier;
    r_parameter(modern_indices) = modern_erosion_multiplier;
end


