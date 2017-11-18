    function conf = compute_conf( uh, xr )
%UNTITLED3 Summary of this function goes here
%   Detailed explanation goes here
global ng xg;
if size(xr, 2) > 1
    xr = xr';
end
conf = (1/ng)*zeros(ng, 1);
for i=1:ng %directedness based confidence function. 
    normxs = (xg(:, i) - xr)/(norm((xg(:, i) - xr)) + realmin); %ith goal position;
    normuh = uh/(norm(uh) + 10^-3); %add realmin to avoid divide by zero errors. 
    disp(normuh);
    costh = dot(normxs, normuh);
    if acos(costh) > pi/2 
        conf(i) = 0;
    else
        conf(i) = (1 + costh)/2;
    end
%     disp(acos(costh));
end
% conf = conf/sum(conf);
% conf = zeros(ng, 1);
% disp(conf);
end

