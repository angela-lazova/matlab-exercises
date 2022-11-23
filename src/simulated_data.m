% 
% This function simulates normally distributed random data based on
% specified mean, strandard deviation and sample size.
% Input
% * mean:      the mean of the normally distributed data we want to 
% generate. 
% * strd: the standard deviation of the normally distributed data we want
% to generate. 
% * N: the sample size of the generated data.
%
% Output: 
% * fullm: dsiplays the full matrix.
% * splitm1: a new matrix with values higher than the first matrix's
% median.
% * splitm2: a new matrix with values lower than the first matrix's
% median.

function [fullm, splitm1, splitm2 ] = simulated_data(mean, strd, N)
r = normrnd(mean,strd,N,1);
fullm = r;
splitm1 = [];
splitm2 = [];
medianm = median(r); 
for i = 1:length(r)
    if r(i) >= medianm
        splitm1 = [splitm1, r(i)];
    else
        splitm2 = [splitm2, r(i)];
    end
end
end
