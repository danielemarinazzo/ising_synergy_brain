function [te, synergy, redundancy, te1, te2] = TE_Full_3(prob)
% Evaluate TE and information decomposition quantities (bits)
% It only works with two drivers and one target time series
%
% Inputs:
%    prob - Multivariate probability vector.
%           It needs to have 4 dimensions, corresponding to the time series
%           ordered as follows: [source1,source2,target,targetFuture]
%
% Outputs:
%    te1, te2               - Pairwise TE from both drivers
%    te                     - Bivariate TE
%    synergy, redundancy    - Information decomposition quantities (unique
%                             information can be calculated from the
%                             pairwise TE and the redundancy)

% Avoid NaN if some probabilities are zero
pX1X2YZ = prob + eps;

% Marginalize probabilities 
pX1X2Y = sum(pX1X2YZ,4);
pYZ = sum(sum(pX1X2YZ,1),2);
pY = sum(pYZ,4);

pX1YZ = sum(pX1X2YZ,2);
pX2YZ = sum(pX1X2YZ,1);

pX1Y = sum(pX1YZ,4);
pX2Y = sum(pX2YZ,4);

% Evaluate entropies
sX1X2YZ =  sum(sum(sum(sum(pX1X2YZ .* log(pX1X2YZ)))));
sX1YZ =  sum(sum(sum(pX1YZ .* log(pX1YZ))));
sX2YZ =  sum(sum(sum(pX2YZ .* log(pX2YZ))));
sX1X2Y = sum(sum(sum(pX1X2Y .* log(pX1X2Y))));
sX1Y = sum(sum(sum(pX1Y .* log(pX1Y))));
sX2Y = sum(sum(sum(pX2Y .* log(pX2Y))));
sYZ = sum(sum(pYZ .* log(pYZ)));
sY = sum(pY .* log(pY));

% Evaluate TE
te = (sX1X2YZ + sY - sX1X2Y - sYZ) / log(2);
te1 = (sX1YZ + sY - sX1Y - sYZ) / log(2);
te2 = (sX2YZ + sY - sX2Y - sYZ) / log(2);

% Information decomposition        
red = max(te1,te2);
synergy = te - red;
redundancy = te1 + te2 + synergy - te;

end

