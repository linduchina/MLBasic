function [maxGain, splitVal] = FeatureGain(x,y)
if x == x(1)
    maxGain = -1;
    splitVal = -1;
    return;
end
[my_data,r_ind] = sortrows([x,y],1);
ll = length(x);
sum_vector = zeros(ll - 1,1);
sum_y = sum(y);
temp = nan ;
sum_vector(1) = my_data(1,2);
for i = 2:ll-1
    sum_vector(i) = sum_vector(i-1) + my_data(i,2); 
end
GainV = zeros(ll-1,1);
for i = 1:ll-1
    if my_data(i,1) == temp
        GainV(i) = GainV(i - 1);
        GainV(i - 1) = nan;
        continue;
    end
     GainV(i) = sum_vector(i)*sum_vector(i)/(i) +(sum_y - sum_vector(i))*(sum_y - sum_vector(i)) / ((ll - i));   
     temp = my_data(i,1);
end
if my_data(ll,1) == my_data(ll-1,1)
    GainV(ll-1) = 0;
end
[maxGain,index] = max(GainV);
maxGain = (maxGain - sum_y*sum_y /(ll));
splitVal = (r_ind(index));
end