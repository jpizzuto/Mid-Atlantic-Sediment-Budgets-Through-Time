% is_flow_overbank computes water surface elevation and determines
% if floodplain is inundated
%
% variables: floodplain_elevation(i),g,three_month_Q_cms,slope,Cf,width_m
overbank = 0;
%
% compute Cf based on current floodplain elevation
%
bankfull_depth = layer_z(j-1) + bed_relief;
Cf = friction_factor(n,bankfull_depth,g);
% steady uniform flow in a rectangular channel
water_surface_elevation = ...
    ((three_month_peak_Q_cms/width_m)*sqrt(Cf/(g*slope)))^(2/3);
if water_surface_elevation > bankfull_depth
    overbank = 1;
end
