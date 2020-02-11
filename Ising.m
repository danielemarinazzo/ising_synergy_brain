function [spinConfig] = Ising(J, beta, confNum, termIter, spinInit)
% Simulate Ising dynamics using metropolis algorithm
% At each iteratioin each spin has the chance to flip exactly one time

%   J           -   Coupling matrix
%   beta        -   1/kT 
%   confNum     -   Number of configurations to save
%   termIter    -   Iterations for the thermalization procedure
%   decorrIter  -   Decorrelation steps: number of iterations between a
%                   saved configuration and the next
%   spinInit    -   Starting spin configuration (optional)

N = size(J,1);

% If the initial spin configuration is not given initialize the spins with
% random values
if ~exist('spinInit','var') || isempty(spinInit)
  spinInit =  sign(0.5 - rand(N,1));
end

% Spin configuration that will be updated
spin = spinInit;

% Matrix for the spin configurations to save for the statistics 
spinConfig = zeros(confNum, N, 'int8');

% Thermalize
for i = 1:termIter
    indices = randperm(N);
    for j = 1:N
        randIndex = indices(j);
        deltaE = spin(randIndex) * 2 * sum(J(:,randIndex) .* spin);
        prob = exp(-deltaE * beta);

        if rand() <= prob/(1+prob)
            spin(randIndex) = -spin(randIndex) ;
        end
    end        
end
    
% Start saving configurations
for n = 1:confNum    
    indices = randperm(N);
    for j = 1:N
        randIndex = indices(j);
        deltaE = spin(randIndex) * 2 * sum(J(:,randIndex) .* spin);
        prob = exp(-deltaE * beta);

        if rand() <= prob/(1+prob)
            spin(randIndex) = -spin(randIndex) ;
        end
    end        
    spinConfig(n,:) = int8(spin);
end


end

