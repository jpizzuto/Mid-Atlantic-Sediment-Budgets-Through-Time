% MAFSBETT (Mid-Atlantic_floodplain_sediment_budgets_through_time) 
% models channel sediment transport, 
% floodplain deposition, and floodplain erosion starting from any year after 7550 B.P. 
% to any year up to 2017.
%
% first clear workspace
clear
%
tic % have MATLAB keep track of run time
sediment_budget = 0; % =1 computes sediment budget between
                     % years specified in the script
                     % select_time_domain_and_time_parameters
plot_graphs_on_screen = 1; % =1 prints 4 graphs of model results
                     % showing floodplain elevation and residence time
                     % through time, and also age pdf and age exceedence
                     % at the end of model run.  Pauses after each
                     % plot - hit return to continue.
%
%
% randomly select basal pre-Settlement age by drawing random numbers from
% the observed smoothed distribution of basal age. 
% Input the ENDING DATE for the simulation.
% Define erosion and deposition time step parameters, ensuring that the
% duration is evenly divisible by all time steps.  Set ages and dates for
% stored sediment layer contacts.
select_time_domain_and_time_parameters
%
% compute rep values, store in array rep_data
%
compute_two_function_rep
%
% create arrays to store data
%
arrays_to_store_data
%
% introduce sediment rating curve multiplier and erosion rate
% parameter multiplier "r_parameter" through time
%
sed_rating_curve_and_erosion_multipliers_through_time
%
% select forest % through time and drainage basin area (sq km) by 
% picking random numbers
%
pick_forest_and_drainage_area 
%
% Determine initial channel morphology and related variables
channel_morphology % remember to recompute Cf as depth varies
%
% Specify imperviousness through time from 1950 to 2017.
%
imperviousness_through_time_backwards; % 
%
% Is simulated location within backwater influence of colonial mill dam?
% (the script is_a_milldam_in_reach determines if milldam_influence = 1
% or 0
milldam_frequency = 0.5; % milldams per km
%
% determine x location, drainage areas, and slopes of milldam locations
milldam_x_coordinates
%                        
% Define settling velocity of suspended sediment
%
grain_size_and_settling_velocity
%
%
num_floods = 0; % count # of overbank events
if sediment_budget == 1
    % total sediment flux during simulation in megagrams
    sed_transported_Mg = 0; 
    % total floodplain deposition & erosion during simulation in megagrams
    floodplain_deposition_Mg = 0;
    floodplain_erosion_Mg = 0;
end  
%
% loop from start_year to end_year in 3 month increments
%
for j = 2:1:total_num_contacts % 
        j % this prints time step number on the screen so progress can
          % be viewed
%for j = 2:10
    thickness_deposited_since_last_erosion = 0;
    for flood_num_between_erosion = 1:num_floods_between_erosion_events
        % select three_month_peak_Q (m^3/s) discharge from cdf
        discharge_from_exceedence_curve
        % is three_month_Q_cms an overbank event?
        if contact_calendar_dates(j) < milldam_construction_year || ...
                contact_calendar_dates(j) > milldam_demise_year
            is_flow_overbank % steady uniform flow w/o milldam
        else
           if contact_calendar_dates(j) == milldam_construction_year || ...
                    contact_calendar_dates(j) == ...
                    milldam_height_adjustment_year
                is_a_milldam_in_reach % 
           end
            if milldam_influence == 0
                is_flow_overbank %
            else
                broad_crested_weir %
            end
        end
        if sediment_budget == 1 % compute sediment flux in kg during event
            if contact_calendar_dates(j) >= sediment_budget_start_year ...
               && contact_calendar_dates(j) <= sediment_budget_end_year
                compute_sediment_flux
            % increment total, convert to Mg with 0.001 conversion factor
            % for kg to Mg
                sed_transported_Mg = ...
                    sediment_transported_kg*0.001 + sed_transported_Mg; 
            end
        end
        % if overbank flow compute duration of overbank flow and 
        % overbank deposition
        thickness_deposited_in_one_flood = 0;
        if overbank == 1
            num_floods = num_floods+1; % update number of floods
            % compute thickness_deposited
            compute_floodplain_deposition_new 
            if sediment_budget == 1
               if contact_calendar_dates(j) >= sediment_budget_start_year
               floodplain_deposition_Mg = 0.001*floodplain_deposition_kg...
                                            + floodplain_deposition_Mg;
               end                         
            end
        end
        thickness_deposited_since_last_erosion = ...
            thickness_deposited_since_last_erosion + ...
            thickness_deposited_in_one_flood;
    end
    % increment elevation z store new layer thickness and mass
    layer_z(j) = layer_z(j-1) + ...
        thickness_deposited_since_last_erosion;
    thickness_of_each_layer(j-1) = ...
        thickness_deposited_since_last_erosion;
    % "mass" here is really the volume per unit area, not the mass
    mass_deposited = ...
        thickness_deposited_since_last_erosion*(1-porosity);
    mass_of_each_layer(j-1) = mass_deposited;
    % compute volume per area eroded in each age category
    erode_layers_and_correct_storage
    if sediment_budget == 1
        if contact_calendar_dates(j) >= sediment_budget_start_year ...
           && contact_calendar_dates(j) <= sediment_budget_end_year
        mass_eroded_kg = mass_eroded*floodplain_width*reach_length*2650;
        floodplain_erosion_Mg = ...
            floodplain_erosion_Mg + 0.001*mass_eroded_kg;
        end
    end
    % compute residence time of eroded sediment
    compute_residence_time 
end
if sediment_budget == 1
        sediment_budget_duration = sediment_budget_end_year - ...
            sediment_budget_start_year;
        ann_sed_flux_Mg = sed_transported_Mg/sediment_budget_duration;
        ann_floodplain_deposition_Mg = ...
            floodplain_deposition_Mg/sediment_budget_duration;
        ann_floodplain_erosion_Mg = ...
            floodplain_erosion_Mg/sediment_budget_duration;
        sed_bud_end_j = ...
            find(contact_calendar_dates == sediment_budget_end_year);
        lateral_erosion_rate_cm_per_yr = (ann_floodplain_erosion_Mg...
            /(floodplain_elevation(sed_bud_end_j)...
            -floodplain_elevation(1)))...
            *(100/(2.65*reach_length*(1-porosity)));
end
floods_per_year = num_floods/(end_year-start_year);
if plot_graphs_on_screen ==1
    plot(contact_calendar_dates,floodplain_elevation),...
        xlabel('Year'),...
        ylabel('Floodplain Elevation (m)')
    pause
    plot(contact_calendar_dates(1,2:total_num_contacts),...
        residence_time),...
        xlabel('Year'),...
        ylabel('Residence Time (yrs)')
    pause
%
% compute age pdf at end of simulation
%
    final_age_pdf = ...
        mass_of_each_layer/(stored_mass(num_simulated_layers)*erosion_dt);
    final_age_pdf = flip(final_age_pdf);
    contact_ages_from_0_25 = flip(contact_ages(1,1:total_num_contacts-1));
    plot(contact_ages_from_0_25,final_age_pdf),...
        xlabel('Age (years)'),...
        ylabel('Age pdf (1/yrs)'),...
        title('Age pdf')
    pause
%
% compute age cdf at the end of simulation and plot survivor function
%
    final_layer_mass_from_1950 = flip(mass_of_each_layer);
    cum_layer_mass_from_1950 = cumsum(final_layer_mass_from_1950);
    final_age_cdf=cum_layer_mass_from_1950/(max(cum_layer_mass_from_1950));
    final_age_cdf(1,2:total_num_contacts) = final_age_cdf;
    final_age_cdf(1,1) = 0;
    contact_ages_from_0(1,2:total_num_contacts) = contact_ages_from_0_25;
    contact_ages_from_0(1,1) = 0;
    semilogy(contact_ages_from_0,1-final_age_cdf),...
        xlabel('Age (years)'),...
        ylabel('Exceedence'),...
        title('Age exceedence')
end
toc
    

