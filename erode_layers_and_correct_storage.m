% erode layers and correct_storage erodes sediment in each time step 
% by age category and adjusts layer elevations and stored mass
% for erosion.
%
% sediment is eroded according to the function of r_ep(age).  In some
% cases, r_ep may be treated as a constant.
%
% store erosion in the variable eroded_mass_per_time_step_per_layer,
% which is initially filled with zero values in the routine 
% "arrays_to_store_data.m".
%
%
% loop over all previously deposited layers
for k = 2:1:j % k is the contact # for each layer, k-1 is the layer #
    % use the mean layer age to compute rep
    age_lower = contact_ages(k-1) - contact_ages(j);
    age_upper = contact_ages(k  ) - contact_ages(j);
    mean_age = (age_lower + age_upper)/2;
    % now compute rep from database of rep values vs age
    rep = interp1(contact_ages,rep_data,mean_age);
    rep = rep*r_parameter(1,j); % r varies with year and is independent
                                % of age, here denoted by k
    eroded_mass_per_time_step_per_layer(k-1) = ...
        mass_of_each_layer(k-1)*rep*erosion_dt;
    % correct stored mass for erosion
    mass_of_each_layer(k-1) = mass_of_each_layer(k-1) - ...
        eroded_mass_per_time_step_per_layer(k-1);
    if mass_of_each_layer(k-1) < 0
        mass_of_each_layer_(k-1) = 0;
    end
    % compute thickness of eroded layer and recompute layer_z
    thickness_of_each_layer(k-1) = mass_of_each_layer(k-1)/(1-porosity);
    layer_z(k) = layer_z(k-1) + thickness_of_each_layer(k-1);
end
mass_eroded = sum(eroded_mass_per_time_step_per_layer);
stored_mass(j) = stored_mass(j-1)... 
    + mass_deposited - mass_eroded;
floodplain_elevation(j) = layer_z(j);