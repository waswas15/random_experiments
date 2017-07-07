% Generalized Benford's law distribution fitted to world countries
% populations
% Data source : Wikipedia

clear all
clc
d = xlsread('countries_populations.csv');
d = d(:,3); % keep relavent information only
max_pow = 9;
pows = logspace(max_pow,1,max_pow);
fd_data = []; % for storing first digit values
for i = 1 : max_pow
    pow = pows(i);
    d1 = d(d>=pow)/pow; 
    fd_data = [fd_data;floor(d1)];
    d = d(d<pow); % keep smaller valus only
end
h = histogram(fd_data,'Normalization','probability');
xdata = [1:9];
ydata = h.Values; % probability of each bin
fun = @(param,x) param(1)*log(1 + (1./(param(2) + x.^(param(3)))));
x0 = [0.1,0.1,0.1];
x = lsqcurvefit(fun,x0,xdata,ydata);
hold on
plot(fun(x,xdata))
hold off
title('Generalized Benford''s law fitted to World countries populations')