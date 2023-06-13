% channel_morphology selects morphological variables to 
% begin computations.
%
% variables defined include width, slope, roughness, and bank height_1950
% and porosity
porosity = 0.4;
% regression equation from MD Piedmont stream survey for width (m)
width_m = 3.14*(drainage_area^(0.39));
slope = 0.0330*(drainage_area^(-0.42)); 
bed_relief = 0.2; % 
if sediment_budget == 1
    reach_length = 1000; % for sediment budget computations
    load 'Valley_Width_Data.csv';
    floodplain_width = pick_random_value(Valley_Width_Data(:,1)',...
        Valley_Width_Data(:,2)');    
end
%
% initial floodplain thickness = 0, so bankfull_depth = bed_relief
%
bankfull_depth = bed_relief;
% Compute friction coefficient Cf from constant Manning's n and varying
% depth
n = 0.035; % constant Manning's n
g = 9.8; % acceleration of gravity
Cf = friction_factor(n,bankfull_depth,g);

