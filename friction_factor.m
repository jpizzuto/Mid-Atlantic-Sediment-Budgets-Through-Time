function y = friction_factor(n,depth,g)
% computes the value of Cf given n = 0.035, depth, and g
y = ((n^2)/(depth^(1/3)))*g;
end

