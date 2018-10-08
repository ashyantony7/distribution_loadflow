function [losses, I_loss] = calc_loss(Ibr, V, branch)
%LOSSES Function to calculate the losses of the system
% and the loss current

R = branch(:,4);
X = branch(:,5);

losses = (Ibr.^2).*complex(R,X);

I_loss = losses./V(branch(:,2));

end