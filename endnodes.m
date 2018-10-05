function e = endnodes(branch)
%ENDNODES Function to calculate the end nodes of a radial 
% distribution network

e= [];
bus = unique(branch(:, 3));

for i=1:length(bus)
    d=0;
    
    for j=1:length(branch(:,2))
        
        if  branch(j,2)==bus(i)  % if there are any downstream line
            d=1;
        end
    end
    
    % no downstream line --> add to endnode
    if d==0
        e =[e bus(i)];
    end
end


end

