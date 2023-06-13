% grain_size_and_settling_velocity.m adds these variables
grain_size_phi = 7.5; % 
grain_size_mm = (1/2)^(grain_size_phi);
grain_size_m = grain_size_mm/1000;
Vs = (1.65*9.8/(18*1E-6))*(grain_size_m^2); % Stokes Law - m/s