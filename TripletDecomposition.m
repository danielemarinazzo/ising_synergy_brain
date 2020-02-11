function triplet_data = TripletDecomposition(source1,source2,target)
% Full information decomposition for two driver and one target time series
% Inputs:
%    source1 - First driver time series
%    source2 - Second driver time series
%    target  - Target time series
%
% Outputs:
%    triplet_data - Structure containing all bivariate and multivariate
%                   information quantities (pairwise TE from both drivers,
%                   bivariate TE, synergy, redundancy)

triplet_data = struct;

% Remap from (-1,1) to (0,1);
source1 = (source1 + 1)/2;
source2 = (source2 + 1)/2;
target = (target + 1)/2;

% Shift drivers and target one step in the past
source1 = circshift(source1,1,1);
source2 = circshift(source2,1,1);
targetPast = circshift(target,1,1);

% Trim the time series
target = target(2:end);
targetPast = targetPast(2:end);
source1 = source1(2:end);
source2 = source2(2:end);

% Concatenate into a single matrix
X = double([source1,source2,targetPast,target]);

% Get multivariate probability vector
prob = JointProbability(X);

% Evaluate information quantities
[te,s,r,te1,te2] = TE_Full_3(prob);   


triplet_data.synergy = s;
triplet_data.redundancy = r;
triplet_data.TE_tri = te;
triplet_data.TE_bi_s1 = te1;
triplet_data.TE_bi_s2 = te2;
   

end