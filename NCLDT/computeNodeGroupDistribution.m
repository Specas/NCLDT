function [] = computeNodeGroupDistribution(Tm, R)

%Classifying each of the 'm' nodes added in each step
Cp = 0;
Cn = 0;
Dp = 0;
Dn = 0;

for i=1:size(Tm, 1)
    qi = Tm(i, :);
    
    

