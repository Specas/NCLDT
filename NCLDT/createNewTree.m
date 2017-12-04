%Function to create a new tree node



function [] = createNewTree(q_start,q_end, alpha_init,epsilon_max_init,epsilon_min_init,m_init,rho_init,obstacle_coords, ndim, lim)

%Global parameters for each tree
global T Tm path wt ws wt_current rho_current alpha  epsilon_min epsilon_max
global eta mu eta_size mu_size
global m q_root q_target q_pivot

%Initializng paramters for each tree
Tm{end+1} = [];
path{end+1} = [];

mu{end+1} = [];
eta{end+1} = [];
eta_size{end+1} = 0;
mu_size{end+1} = 0;

%Sampling new root node for the tree
q_root{end+1} = sampleConfigurationFree(obstacle_coords, ndim, lim);
T{end+1} = q_root{end};

wt{end+1} = (q_end - q_root{end})/norm(q_end - q_root{end});
ws{end+1} = -(q_start - q_root{end})/norm(q_start - q_root{end});

q_target{end+1} = q_end;

%Current direction of growth
wt_current{end+1} = wt{end};

%Variable along which you sample
q_pivot{end+1} = q_root{end};

%Current obstacle search radius=
rho_current{end+1} = rho_init;

alpha{end+1} = alpha_init;
epsilon_min{end+1}= epsilon_min_init;
epsilon_max{end+1}= epsilon_max_init;
m{end+1} = m_init;
end

