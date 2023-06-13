% arrays_to_store_data determines the number of 
% time steps in the simulation and creates arrays to save the stored
% deposits
%
total_num_contacts = length(contact_calendar_dates);% 
num_simulated_layers = total_num_contacts-1;
layer_z = zeros(1,total_num_contacts);% to store elevations of contacts
stored_mass = zeros(1,total_num_contacts); % total stored mass 
floodplain_elevation = zeros(1,total_num_contacts); % floodplain elevation 
% also define array to store newly computed layer thicknesses
thickness_of_each_layer = zeros(1,num_simulated_layers);
mass_of_each_layer = zeros(1,num_simulated_layers);
eroded_mass_per_time_step_per_layer = zeros(1,num_simulated_layers); 
residence_time = zeros(1,num_simulated_layers); % a layer attribute
final_age_pdf = zeros(1,num_simulated_layers); % a layer attribute
final_mean_layer_age_pdf=zeros(1,num_simulated_layers);% a layer attribute
pct_forest_per_time_step = zeros(1,total_num_contacts);
sediment_rating_curve_multiplier = zeros(1,total_num_contacts);
r_parameter = zeros(1,total_num_contacts);
imperviousness_by_time_step = zeros(1,total_num_contacts);

