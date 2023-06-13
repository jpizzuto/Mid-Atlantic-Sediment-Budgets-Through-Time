% compute_overbank_flow_duration does what it says
% 
% compute bankfull discharge
Q_bankfull = width_m*floodplain_elevation(j)*...
    sqrt(g*floodplain_elevation(j)*slope/Cf);
% compute the 20th percentile cdf flow (80% exceedence)
twenty_pct_Q_cms = interp1(exceedence,peak_Q_cms,0.8);
%
% if bankfull is < threshold Q, set it = threshold Q
%
if Q_bankfull < twenty_pct_Q_cms
    Q_bankfull = twenty_pct_Q_cms;
end
%
% if 3-month_peak Q < threshold, set duration = minimum
% otherwise, compute according to formulas
if three_month_peak_Q_cms < twenty_pct_Q_cms
    overbank_duration_days = 1/24; % minimum duration = 1 hour (in units of days)
    peak_Q_duration_days = overbank_duration_days; % minimum duration
else
     Q_above_threshold_cfs = (three_month_peak_Q_cms - ...
         twenty_pct_Q_cms)/0.0283; 
     [duration_coefficient,duration_exponent] = ...
         hydrograph_parameters_cfs(pct_impervious,...
         pct_forest);
      peak_Q_duration_days = ...
   (Q_above_threshold_cfs/exp(duration_coefficient))^(1/duration_exponent);
% the next set of if statements limits peak_Q_duration to observed values
    if pct_impervious < 10
        max_peak_Q_duration_days = 0.1966*(pct_forest+1) - 3.535;
        if max_peak_Q_duration_days > 10
            max_peak_Q_duration_days = 10;
        end
        if peak_Q_duration_days > max_peak_Q_duration_days
            peak_Q_duration_days = max_peak_Q_duration_days;
        end
    else
        max_peak_Q_duration_days = 0.01347*drainage_area + 0.362;
        if max_peak_Q_duration_days > 1.6
            max_peak_Q_duration_days = 1.6;
        end
        if peak_Q_duration_days > max_peak_Q_duration_days
            peak_Q_duration_days = max_peak_Q_duration_days;
        end
    end 
      overbank_duration_days = peak_Q_duration_days*...
         ((three_month_peak_Q_cms - Q_bankfull)/...
          (three_month_peak_Q_cms - twenty_pct_Q_cms));
      if overbank_duration_days < 1/24
          overbank_duration_days = 1/24;
      end
end