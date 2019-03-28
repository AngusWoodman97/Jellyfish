function [phaseDif] = vdpNsolveGraphs(n, t)

clf;

if nargin == 0   % if the number of inputs equals 0
    n = 4;
    t = [0 200];
end

tic

time = 0;

%% Initial Conditions (random or chosen)

% a1 = -2;
% b1 = 2;
%initialCond = (b1-a1).*rand(2*n,1) + a1;

%initialCond = [2.022;0;2.022;0;-0.70485;1.31125;-0.70485;1.31125]; %TRYING
%to fix to shifted solution
%initialCond = [1;1;1;1;1;1;1;1];
initialCond = [-2.25;0;-2.25;0;2.25;0;-1.25;0];

%% ODE solver

options = odeset('RelTol',10^-8,'AbsTol',10^-11,'Events',@myEventsFun);
[t,y,te,ye,ie] = ode23(@vdpN2,t,initialCond, options);

%% Checking order of ie & te has the first oscillator first 

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
     ie = ie(1:end-mod(length(ie),4));
     te = te(1:end-mod(length(te),4));
end
te = reshape(te,4,size(te,1)/4);
ie = reshape(ie,4,size(ie,1)/4);

%% checking the difference in the time periods of the oscilators

tp1 = te(1,end)-te(1,end-1);
tp2 = te(2,end)-te(2,end-1);
tp3 = te(3,end)-te(3,end-1);
tp4 = te(4,end)-te(4,end-1);

% if tp1-tp2<0.000001 && tp2-tp3<0.000001 && tp3-tp4<0.000001
% else
%     'time periods not the same'
%     format long
%     TimePeriods = [tp1, tp2, tp3, tp4]
% end

%% Rounding phases to the nearest 1 degree

PhDi2 = ((te(2,end)-te(1,end))*360/tp1);
PhDi3 = ((te(3,end)-te(1,end))*360/tp1);
PhDi4 = ((te(4,end)-te(1,end))*360/tp1);

phaseDif = [0, PhDi2, PhDi3, PhDi4]%, initialCond']

%% Phase change graph

tp1_list=te(1,2:end)-te(1,1:end-1);
tp2_list=te(2,2:end)-te(1,2:end);
tp3_list=te(3,2:end)-te(1,2:end);
tp4_list=te(4,2:end)-te(1,2:end);

phd2_list=tp2_list./tp1_list.*360;
phd3_list=tp3_list./tp1_list.*360;
phd4_list=tp4_list./tp1_list.*360;

ph_list_full = [phd2_list; phd3_list; phd4_list];

hold on
figure(1)
plot(phd2_list,'b')
plot(phd3_list,'g')
plot(phd4_list,'r')
hold off
%% Figures

xAxis = 1:4;
figure(2)
stem(xAxis,phaseDif);
axis([0.5 4.5 0 360])
title('Phase Graph');
xlabel('Oscillator');
ylabel('Phase angle');


for j = 1:2:2*n
    hold on
    figure(3)
    plot(t,y(:,j),'-o')
    title('Solution of van der Pol Equation (e = 5) with ODE23');
    xlabel('Time t');
    ylabel('Solution x');
    
    
    hold on
    figure(4)
    plot(y(:,j),y(:,j+1),'-o')
    title('Solution of van der Pol Equation (e = 5) with ODE23');
ax = gca;
ax.XAxisLocation = 'origin';
ax.YAxisLocation = 'origin';
%     xlabel('solution x');
%     ylabel('Xdiff');
    
end
toc
end