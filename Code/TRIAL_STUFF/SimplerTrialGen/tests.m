r = zeros(1000, 3);
for i=1:1000
    for j=1:3
       r(i, j) = randsample(2, 1);
    end
end