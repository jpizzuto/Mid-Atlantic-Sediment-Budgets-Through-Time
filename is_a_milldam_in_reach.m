% is_a_milldam_in_reach determines if the simulation reach is influenced by 
% a colonial era milldam
%
% the outcome is a value of milldam_influence = 0 or 1
% if milldam_influence == 1
% dam_height = 0.8*floodplain height at the time of determination
%
%
milldam_backwater_lengths = ...
    (floodplain_elevation(j-1)./milldam_slopes)/1000; % in km
% next determine the upstream coordinate of backwater influence
milldam_x_upstream_backwater = milldam_x_coordinate - ...
    milldam_backwater_lengths; % minus because x decreases upstream
% check to see if backwater from any of the dams extends to the 
% next dam upstream; if so, abort with error message
for k1 = 2:number_of_milldams
    if milldam_x_upstream_backwater(1,k1-1) < ...
            milldam_x_coordinate(1,k1)
        'backwater impinges upstream at dam'
        k1
        error('backwater extends beyond next dam; too many dams')
    end
end
%
% now search coords of backwater influence to determine if simulation
% site is behind a mill dam
milldam_influence = 0;
for k1 = 1:number_of_milldams
    if simulation_site_x <= milldam_x_coordinate(1,k1)
        if simulation_site_x >= milldam_x_upstream_backwater(1,k1)
            milldam_influence = 1;
        end
    end
end
%
% extent of backwater influence computed for exploration; not
% needed for general simulations so can be commented out
%
total_backwater_length = sum(milldam_backwater_lengths);
fraction_of_reach_influenced_by_milldams = ...
    total_backwater_length/domain_channel_length;
%
% set initial dam_height if milldam_influence == 1
%
if milldam_influence == 1
    dam_height = 0.8*floodplain_elevation(j-1);
end
