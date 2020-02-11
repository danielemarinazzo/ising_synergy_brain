function prob = JointProbability(data)
% Estimate multivariate probability
% Only works with series having values equal to 0 and 1
% There are no limitations on the number of time series used (for the
% triplet information decomposition only 4 series are used)
%
% Inputs:
%    data - Data matrix (T x N)
%           T = length of the time series, N = number of time series
%
% Outputs:
%    prob - Multivariate probability vector. It has a number of dimensions
%           equal to the number of timeseries. Each dimension has fixed
%           length of 2, the first index corresponds to the probability that 
%           the associated variable has value 0, the second to the
%           probability of having value 1.


[T,N] = size(data);

% Interpret each row vector as a decimal number
dec = b2d(data);

% Count the occurrences of each number
edges = 0:2^N;
counts = histcounts(dec,edges);
prob = reshape(counts / T, 2*ones(1,N));

% Flipping is needed to get the right corrispondence with the time series
prob = permute(prob, N:-1:1);

end

