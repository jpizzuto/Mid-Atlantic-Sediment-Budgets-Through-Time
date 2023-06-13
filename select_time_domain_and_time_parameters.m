% select_time_domain_and_time_parameters.m randomly selects a maximum age
% to begin the simulation
%
% This version also ensures that the maximum age is evenly divisible by
% the erosion interval erosion_dt, and also determines the closest
% layer calendar years to years selected for mill dam construction
% (1800), height adjustment (1860), and demise (1910).  The latter
% is accomplished using a new function which searches for the 
% closest layer age to a specified year
load Presettlement_age_data_less_than_7547yrs.csv
%
observed_ages = Presettlement_age_data_less_than_7547yrs';
observed_ages = sort(observed_ages); % order from min to max
num_observed_ages = length(observed_ages);
% compute cdf from 0 to 1 for the age values
cdf = 0:1:num_observed_ages-1;
cdf = cdf/(num_observed_ages-1);
%
% randomly select a maximum age from the observed distribution of 
% basal ages
max_age = pick_random_value(observed_ages,cdf);
% round to nearest integer
max_age = round(max_age); % note that the erosion interval must divide
                          % evenly into the maximum age
%max_age = 1756;
%max_age = 7283 + 267; % 267 adjusts the analysis so the previous number
                     % is the number of years before 1750                   
deposition_dt = 0.25; % time step in years between floods
erosion_dt = 4; % time step in years between erosion events
num_floods_between_erosion_events = erosion_dt/deposition_dt; % integer!
%
end_year = 2017; % enter the final year of the simulation
start_year = end_year-max_age; % determine the initial year of the simulation
% now adjust the maximum age upwards so the simulation interval
% is evenly divisible by erosion_dt
simulation_duration = end_year - start_year;
divide = simulation_duration/erosion_dt;
divide_remainder = divide - floor(divide);
while divide_remainder > 0
    max_age = max_age + 1;
    start_year = end_year-max_age;
    simulation_duration = end_year - start_year;
    divide = simulation_duration/erosion_dt;
    divide_remainder = divide - floor(divide);
end
% define dates and ages for each contact in the simulation
contact_calendar_dates = start_year:erosion_dt:end_year;% dates of contacts
contact_ages = end_year - contact_calendar_dates; % ages of contacts
milldam_construction_year = ...
    find_closest_year(contact_calendar_dates,1800);
milldam_height_adjustment_year = ...
    find_closest_year(contact_calendar_dates,1860);
milldam_demise_year = ...
    find_closest_year(contact_calendar_dates,1910);
% specify beginning and ending years for sediment budget computations
% change the year in parens, ie., 
% xxx in find_closest_year(contact_calendar_dates,xxx)
sediment_budget_start_year = ...
    find_closest_year(contact_calendar_dates,1950);
sediment_budget_end_year =find_closest_year(contact_calendar_dates,2017);





