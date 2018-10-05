function t = topnodes(branch)
%ENDNODES Function to calculate the source/top nodes of a radial 
% distribution network

t= [];
bus = unique(branch(:, 2));

for i=1:length(bus)
    d=0;
    
    for j=1:length(branch(:,3))
        
        if  branch(j,3)==bus(i)  % if there are any upstream line
            d=1;
        end
    end
    
    % no upstream line --> add to topnode
    if d==0
        t =[t bus(i)];
    end
end


end

