% pick_forest_and_drainage_area selects the % forest cover in 1950 and 
% drainage basin area from uniformly distributed random numbers over
% a range
%
% % forest is then determined for each time step
%
drainage_area = unifrnd(26,260); % select drainage basin area in sq km
% from 26-160 km^2 (equivalent to 10-100 mi^2)
pct_forest_1950 = unifrnd(20,40); % select % forest between 20-40% for
                                  % 1950                                 
%
% define breakpoints for changing % forest values
% during presettlement and legacy time periods
%
year_break_points =[1750 1810 1830 1860 1880 1950];
pct_forest_break_points = [95 78 57 48 pct_forest_1950/2 pct_forest_1950];
%
% loop through break points, connecting % forest with straight lines
% between break points up to 1950
%
% begin by setting all % forest values = presettlement value of 95%
pct_forest_per_time_step(1,:) = pct_forest_break_points(1,1);
for point_num = 2:6
    % compute rate of change of pct forest with year in interval
    dy = pct_forest_break_points(point_num) - ...
        pct_forest_break_points(point_num-1);
    dx = year_break_points(point_num) - ...
        year_break_points(point_num-1);
    % find years corresponding to break point time interval
    year_indices = find(contact_calendar_dates > ...
                        year_break_points(point_num-1) &...
                        contact_calendar_dates <= ...
                        year_break_points(point_num));
    pct_forest_per_time_step(1,year_indices) = ...
        (dy/dx).*(contact_calendar_dates(year_indices) - ...
        year_break_points(point_num-1)) + ...
        pct_forest_break_points(1,point_num - 1);
end
% set pct forest for years > 1950
year_indices = find(contact_calendar_dates > year_break_points(1,6));
pct_forest_per_time_step(1,year_indices) = pct_forest_1950;
     