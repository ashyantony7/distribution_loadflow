function [T_Bus, T_Branch] = display_results(V, feeder_V, Ibr, branch)
%DISPLAY OF RESULTS

%Plot the voltage Profiles at all buses
   figure(1)
   plot(abs(V)/feeder_V,':bs','MarkerFaceColor',[1 0 0]);
   title('Bus voltages p.u');
   xlim([0 length(V)]);
   xlabel('bus numbers');
   ylabel('Voltage (p.u)');
   title('Voltage at all nodes');
   
    T_Bus = table((1:length(V))',abs(V)/feeder_V, angle(V));
    T_Bus.Properties.VariableNames= {'Bus', 'Voltage','Angle'};
    T_Bus.Properties.VariableUnits = {'','V (p.u)','Radians' };
    
    % calculate losses
    Real_loss = (real(Ibr(:)).^2).*branch(:,4)/1000;
    Reactive_loss = (imag(Ibr(:)).^2).*branch(:,5)/1000;
    
    % add the Line level results to a table
    fprintf('\n Branch Results');
    T_Branch = table(branch(:,2), branch(:, 3), abs(Ibr(:)), real(Ibr(:).*V(branch(:,2)))/1000, Real_loss, Reactive_loss);
    T_Branch.Properties.VariableNames= {'From_Bus', 'To_Bus','Current', 'Line_Power', 'Real_loss', 'Reactive_loss'};
    T_Branch.Properties.VariableUnits = {'','','A','W','kW','kVAR'};
end
           
    
    
    
    
    
