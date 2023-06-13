% imperviousness_through_time_backwards determines % impervious 
% cover at each
% time step of the simulation from 1950-2017, starting with 2010 and
% working backwards through time
% first load imperviousness cdfs for 1970, 1984, 1997, and 2010
%
load_imperviousness_data
%
% pick random imperviousness values for 1970, 1984, 1997, and 2010
% 
imperv_2010= pick_random_value(Imperviousness_2010(:,1)',...
                    Imperviousness_2010(:,2)');              
imperv_1997 = 100;
while imperv_1997 > imperv_2010 % imperviousness must increase througn time
    imperv_1997 = pick_random_value(Imperviousness_1997(:,1)',...
                    Imperviousness_1997(:,2)');
end
imperv_1985 = 100;
while imperv_1985 > imperv_1997 % imperviousness must increase througn time
    imperv_1985 = pick_random_value(Imperviousness_1985(:,1)',...
                    Imperviousness_1985(:,2)');
end
imperv_1970 = 100;
while imperv_1970 > imperv_1985 % imperviousness must increase througn time
    imperv_1970 = pick_random_value(Imperviousness_1970(:,1)',...
                    Imperviousness_1970(:,2)');
end
%
% define data set for interpolating imperviousness 
%
xdata = [1950 1970 1985 1997 2010 2017];
ydata = [0 imperv_1970 imperv_1985 imperv_1997 imperv_2010 imperv_2010];
year_indices = find(contact_calendar_dates >= 1950);
imperviousness_by_time_step(1,year_indices) = ...
    interp1(xdata,ydata,contact_calendar_dates(1,year_indices));
