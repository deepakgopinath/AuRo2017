clear all; clc;
%%
load('user_vel_good.mat');
uvg = user_vel;
load('user_vel_bad.mat');
uvb = user_vel;

%% query time stamps

qts_good = load('gp_good_ts.mat');
qts_bad = load('gp_bad_ts.mat');

%% GOOD

x = uvg(end, :)'; %original ts
v = zeros(size(uvg,2), 1);
for i=1:size(uvg, 2)
    v(i) = norm(uvg(1:end-1, i));
end

v(v > 0) = 1;
xq = qts_good.gpg_ts;
vq = interp1(x,v,xq);

ts_line = xq(find(diff(vq) ~= 0) + 1); ts_line([8,10]) = [];
hold on;
for i=1:2:length(ts_line)
    line([ts_line(i), ts_line(i+1)], [0.1, 0.1], 'Color', 'k', 'LineWidth', 8);
end

%% BAD

x = uvb(end, :)'; %original ts
v = zeros(size(uvb,2), 1);
for i=1:size(uvb, 2)
    v(i) = norm(uvb(1:end-1, i));
end

v(v > 0) = 1;
xq = qts_bad.gpb_ts;
vq = interp1(x,v,xq);

ts_line = xq(find(diff(vq) ~= 0) + 1); 
hold on;
for i=1:2:length(ts_line)
    line([ts_line(i), ts_line(i+1)], [0.05, 0.05], 'Color', 'k', 'LineWidth', 8);
end
