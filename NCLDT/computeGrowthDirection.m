%Function to compute the direction of growth using the sizes of sets eta
%and mu

%INPUTS:
%size_eta: size of the set eta
%size_mu: size of the set mu
%wt: wt unit vector
%ws: ws unit vector
%k1: Very large positive number (NCLDT parameter)
%k2: Very small positive number (NCLDT parameter)

%OUTPUTS:
%wtc: Current direction of growth

function wt_current = computeGrowthDirection(size_eta, size_mu, wt, ws, k1, k2)

m = min(size_eta, size_mu);
M = max(size_eta, size_mu);

h1 = (size_mu*(exp(-k1*m)))/M;
h2 = size_eta/(size_eta + k2);

X = (h2 * size_eta)/(size_eta + (1 - h2)*size_mu);
Y = (h1 * size_mu)/(size_eta + size_mu);

wt_current = X*wt + Y*ws;

