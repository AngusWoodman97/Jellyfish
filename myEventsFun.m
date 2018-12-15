function [position,isterminal,direction] = myEventsFun(t,y)
position = [y(1);y(3);y(5);y(7)]; % The value that we want to be zero
isterminal = [0;0;0;0];  % Halt integration 
direction = [1;1;1;1];   % The zero can be approached from either direction
end

