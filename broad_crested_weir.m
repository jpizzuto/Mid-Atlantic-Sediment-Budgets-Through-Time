% Broad_crested_weir computes the depth, velocity and shear stress
% just upstream of a broad crested weir.
%
% written by Jim Pizzuto on April 3, 2015; modified and improved
% July 2022
overbank = 0;
q = three_month_peak_Q_cms/width_m; % unit water discharge m^3/m/s
hd = (q/sqrt(g))^(2/3); % this is the water depth over the dam (m)
% vd = q/hd; % velocity at the dam not needed
x0 = [dam_height+hd 20]; % force subcritical flow solution upstream
                         % to avoid spurious supercritical answer
water_surface_elevation = fzero(@(x) (q-sqrt(g)*...
    ((2/3)*((q^2/((x^2)*2*g))+ x - dam_height))^(3/2)),...
    x0);
if water_surface_elevation > floodplain_elevation(j-1)
    overbank = 1;
end

