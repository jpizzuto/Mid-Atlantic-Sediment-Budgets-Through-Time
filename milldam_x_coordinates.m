% milldam_x_coordinates determines the locations of mill dams
% along the river
%
% locations are specified as distance from the drainage divide, 
% following Hack's Law 
%
% important variables: milldam_x_coordinate,milldam_drainage_areas_sq_km,
%                      milldam_slopes
domain_channel_length = 35.7 - 9.0; % in km
number_of_milldams = floor(milldam_frequency*domain_channel_length); 
                        % number of milldams along the "main channel"
                        % of the study drainage basin area (as an integer)
milldam_spacing = domain_channel_length/(number_of_milldams+1); % km
milldam_x_coordinate = zeros(1,number_of_milldams); % km
% recursively locate x coord (km) of milldams from downstream to upstream
downstream_coordinate = 35.7;
for ii = 1:number_of_milldams
    milldam_x_coordinate(1,ii) = downstream_coordinate - milldam_spacing;
    downstream_coordinate = milldam_x_coordinate(1,ii);
end
% compute milldam drainage areas and slopes
% compute drainage areas using Hack's Law in km (from (3))
milldam_drainage_areas_sq_km = (milldam_x_coordinate/1.27).^(1/0.6);
milldam_slopes = 0.0330*(milldam_drainage_areas_sq_km).^(-0.42);
%
% compute x coordinate of simulation site from Hack's Law (see (3))
%
simulation_site_x = 1.27*(drainage_area^(0.6));
%