function  [V, out] = voltages(init_V, Ibr, bus, branch)
% VOLTAGES Function to calculate the voltages from the currents and
% impedance of the network

% number of buses
nbus = length(bus(:,1));

% intialize voltages
V = complex(ones(nbus,1)*init_V);
f = branch(:, 2);    % from and to buses
t = branch(:, 3);

branch2 = branch;

% get the top nodes
t_nodes = topnodes(branch);
t_nodes_tot = t_nodes;   

while ~(isempty(t_nodes))
    
    % voltage with the currents
    for i = 1:nbus

        if ~any(t_nodes_tot == i)  % exclude top nodes

            % fetch the upstream node
            node = branch(t == i,2);

            % fetch resistance and reactance of the lines
            R = branch(t==i,4); 
            X = branch(t==i,5);

            % voltage at the node = voltage at up node - voltage drop
            V(i) = V(node)- Ibr(t==i)*(complex(R, X));
        end

    end
    
    % remove branches with topnodes
    for i = 1:length(t_nodes)
        branch2(branch2(:, 2) == t_nodes(i), :) =[];
    end
    t_nodes = topnodes(branch2);  % new top nodes at this level
    
    % total top node voltages calculated till now
    t_nodes_tot = union(t_nodes_tot, t_nodes);

end

out = [(1:nbus)' V];

end

