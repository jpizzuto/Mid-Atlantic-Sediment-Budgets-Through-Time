% compute_residence_time computes the residence time at each time step
%
% the residence time is the average age of the eroded sediment
integral_sum = 0;
for k = 2:j
    age_1 = contact_ages(k-1) - contact_ages(j); % older contact age
    age_2 = contact_ages(k) - contact_ages(j); % younger contact age
    average_age = (age_1+age_2)/2;  
    d_age = age_1 - age_2;
    pdf = eroded_mass_per_time_step_per_layer(k-1)... 
        /(mass_eroded*d_age); % mass eroded from the layer erosion m-file   
    integral_sum = integral_sum + ...
            pdf*average_age*d_age;
end
residence_time(j-1) = integral_sum;
