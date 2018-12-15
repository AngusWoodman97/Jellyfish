function [] = vdpNsolve(n, t)

%TWO MODES - in phase and out of phase for different IC. out of phase takes
%a lot longer to get to the same time period!

clf;

if nargin == 0   % if the number of inputs equals 0
    n = 4;
    t = [0 200];
end

a1 = -2;
b1 = 2;
%initialCond = (b1-a1).*rand(2*n,1) + a1; % Random IC
        
        %val = 1
        %initialCond = [0;val;0;-val;0;val;0;-val]; % IC set x = 0, xDot = pairs in opposite directions (I THINK)
        initialCond = [-1;0;-1;0;1;0;1;0]; % IC set xDot = 0, x = pairs in opposite directions (I THINK)
% phaseDifMatrix = [];
% time = 0;
%for j = -3.25:0.5:3.25
%    for k = -3.25:0.5:3.25
        
%        initialCond = [0;j;0;j;0;k;0;k];
        
        options = odeset('Events',@myEventsFun);
        [t,y,te,ye,ie] = ode23(@vdpN,t,initialCond, options);
        %[t,y] = ode23(@vdpN,t,initialCond);
        %[t,y] = ode23(@vdpN2,t,initialCond);
        
        % while % while ie is not a multiple of 4
        for i = 1:length(ie)-4
            if ie(i+1) == ie(i)+1
                if ie(i+2) == ie(i)+2
                    if ie(i+3) == ie(i)+3
                        ie = ie(i:end);
                        te = te(i:end);
                        break
                    end
                end
            end
        end
        
        if mod(length(ie),4) ~= 0
            ie = ie(mod(length(ie),4)+1:end);
            te = te(mod(length(te),4)+1:end);
        end
        
%         if ie(end) == 0
%             'not in right order'
%         end
        
        te = reshape(te,4,size(te,1)/4);
        %te = round(te,4)
        
        tp1 = te(1,end)-te(1,end-1);
        tp2 = te(2,end)-te(2,end-1);
        tp3 = te(3,end)-te(3,end-1);
        tp4 = te(4,end)-te(4,end-1);
        
        if tp1-tp2<0.0001 && tp2-tp3<0.0001 && tp3-tp4<0.0001
        else
            'Error with time periods, not the same'
        end
        
        PhDi2 = round((te(2,end)-te(1,end))*360/tp1);
        PhDi3 = round((te(3,end)-te(1,end))*360/tp1);
        PhDi4 = round((te(4,end)-te(1,end))*360/tp1);
        
        phaseDif = [0, PhDi2, PhDi3, PhDi4];%, initialCond'];
   %     phaseDifMatrix = [phaseDifMatrix; phaseDif];
        
  %  end
  %  time = time + 1
%end


xAxis = 1:4;
figure(1)
stem(xAxis,phaseDif);
axis([0.5 4.5 0 360])
title('Phase Graph');
xlabel('Oscillator');
ylabel('Phase angle');


% % Need to work out a way of outputting the phase of these oscillators!!!!!
% if abs(te(1, end)-te(3, end))<0.00001 && abs(te(2, end)-te(4, end))<0.00001
%     'all in phase'
% else
%     'not all in Phase'
% end

%%
% for j = 1:2:2*n
%     hold on
%     figure(2)
%     plot(t,y(:,j),'-o')
%     title('Solution of van der Pol Equation (e = 5) with ODE23');
%     xlabel('Time t');
%     ylabel('Solution x');
%     
% 
%     hold on
%     figure(3)
%     plot(y(:,j),y(:,j+1),'-o')
%     title('Solution of van der Pol Equation (e = 5) with ODE23');
%     xlabel('solution x');
%     ylabel('Xdiff');
%     
% end

end
