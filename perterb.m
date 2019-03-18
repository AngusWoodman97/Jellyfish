function [ph_list_full_all] = perterb(n,t)

clf;
tic

itera = 100;

petb1 = [0.0001, 0.1];
% petb = [0, 0, 0, 0, 0, 0, petb1(1), 0;...
%      0, 0, 0, 0, 0, 0, petb1(2), 0;...
%      0, 0, 0, 0, 0, 0, 0, petb1(1);...
%      0, 0, 0, 0, 0, 0, 0, petb1(2)];
     
petb = [petb1(1), 0, 0, 0, 0, 0, 0, 0;...
    petb1(2), 0, 0, 0, 0, 0, 0, 0;...
    0, petb1(1), 0, 0, 0, 0, 0, 0;...
    0, petb1(2), 0, 0, 0, 0, 0, 0;...
    petb1(1), 0, petb1(1), 0, petb1(1), 0, petb1(1), 0;...
    petb1(2), 0, petb1(2), 0, petb1(2), 0, petb1(2), 0;...
    0, petb1(1), 0, petb1(1), 0, petb1(1), 0, petb1(1);...
    0, petb1(2), 0, petb1(2), 0, petb1(2), 0, petb1(2);...
    petb1(1), petb1(1), 0, 0, 0, 0, 0, 0;...
    petb1(2), petb1(2), 0, 0, 0, 0, 0, 0;...
    petb1(1), petb1(1), petb1(1), petb1(1), petb1(1), petb1(1), petb1(1), petb1(1);...
    petb1(2), petb1(2), petb1(2), petb1(2), petb1(2), petb1(2), petb1(2), petb1(2)];


if nargin == 0   % if the number of inputs equals 0
    n = 4;
    t = [0 itera];
end

time = 0;

ph_list_full_all = [];

%% Initial Conditions (random or chosen)

% a1 = -2;
% b1 = 2;
%initialCond = (b1-a1).*rand(2*n,1) + a1; 

initialCond = [0;-2.25;0;0.25;0;0.25;0;0.25];


%% ODE solver

options = odeset('RelTol',10^-8,'AbsTol',10^-11,'Events',@myEventsFun);
[t,y,te,ye,ie] = ode23(@vdpN,t,initialCond, options);

%% Checking order of ie & te has the first oscillator first (NOTE: is it always the first oscillator or does it just make sure they are in order?

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
te = reshape(te,4,size(te,1)/4);

%% Phase change whole

tp1_list=te(1,2:end)-te(1,1:end-1);
tp2_list=te(2,2:end)-te(1,2:end);
tp3_list=te(3,2:end)-te(1,2:end);
tp4_list=te(4,2:end)-te(1,2:end);

phd2_list=tp2_list./tp1_list.*360;
phd3_list=tp3_list./tp1_list.*360;
phd4_list=tp4_list./tp1_list.*360;

toc

%% Perterb and do agian
J = y;
T = t;

for i=1:length(petb)

t = [0 itera];

initialCond = J(end,:) + petb(i,:);


%% ODE solver

options = odeset('RelTol',10^-8,'AbsTol',10^-11,'Events',@myEventsFun);
[t,y,te,ye,ie] = ode23(@vdpN,t,initialCond, options);

%% Checking order of ie & te has the first oscillator first (NOTE: is it always the first oscillator or does it just make sure they are in order?

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
te = reshape(te,4,size(te,1)/4);

%% Phase change whole Plot

tp1_list=te(1,2:end)-te(1,1:end-1);
tp2_list=te(2,2:end)-te(1,2:end);
tp3_list=te(3,2:end)-te(1,2:end);
tp4_list=te(4,2:end)-te(1,2:end);

phd22_list= [phd2_list, tp2_list./tp1_list.*360];
phd33_list= [phd3_list, tp3_list./tp1_list.*360];
phd44_list=[phd4_list, tp4_list./tp1_list.*360];

% NEED TO CHANGE THIS SO IT ACCOUNTS FOR WHEN ph_list_full IS BIGGER THAN ph_list_full_all
ph_list_full = [phd22_list; phd33_list; phd44_list];
if length(ph_list_full) ~= length(ph_list_full_all)
    ph_list_full = [ph_list_full,zeros(3,length(ph_list_full_all)-length(ph_list_full))+1];
end
ph_list_full_all = [ph_list_full_all; ph_list_full];


%% GRAPHS
figure
hold on
plot(phd22_list,'b')
plot(phd33_list,'g')
plot(phd44_list,'r')
hold off

t2 = [T;t+itera];
y2 = [J;y];

% % below produces 4 graphs not 1????
% for j = 1:2:2*n
%     hold on
%     figure
%     plot(t2,y2(:,j),'-o')
%     title('Solution of van der Pol Equation (e = 5) with ODE23');
%     xlabel('Time t');
%     ylabel('Solution x');
%     
%     
% %     hold on
% %     figure(3)
% %     plot(y(:,j),y(:,j+1),'-o')
% %     title('Solution of van der Pol Equation (e = 5) with ODE23');
% %     xlabel('solution x');
% %     ylabel('Xdiff');
%     
% end

end

end