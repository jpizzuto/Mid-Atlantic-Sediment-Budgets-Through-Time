function y = find_closest_year(years,target_year)
% computes the index of "years" closest to the "target_year")
target_jj = 10000;
minimum_difference = 10000;
number = length(years);
for jj = 1:number
    difference = abs(years(1,jj) - target_year);
    if difference < minimum_difference
        minimum_difference = difference;
        target_jj = jj;
    end
end
y = years(target_jj);
end

