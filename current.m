function  [Ibr, out] = current(V, bus, branch)
%CURRENT Function to calculate the current of the branch for the voltage
% and load

% number of branches
nbr = length(branch(:, 1));

Ibr = zeros(nbr, 1); % initialize branch current
t = branch(:, 3);  % to buses

% currents with just the load and voltage
for i = 1:nbr
    Ibr(i, 1) = conj(complex(bus(t(i),2), bus(t(i),3)))/(V(t(i)));
end

% add current upstream
%----------------------

branch2 = branch;

% get the end nodes
e_nodes = endnodes(branch);

while ~isempty(e_nodes)

    for i = 1:length(e_nodes)
        
        % branch current contributed by e_node
        Ibr_e = Ibr(t == e_nodes(i));

        % node connected to the end node
        node = branch(t ==e_nodes(i),2);

        % add current
        Ibr(t==node) = Ibr(t==node) + Ibr_e;

    end
    
   % remove end nodes and start all over again
   for i = 1:length(e_nodes)
    branch2(branch2(:, 3) == e_nodes(i), :) =[];
   end
   
   e_nodes = endnodes(branch2);
 
   
end

out = [branch(:, 2:3), Ibr];

end

