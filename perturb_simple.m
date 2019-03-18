function [ph_list_full] = perturb_simple(n, t)

clf;

itera = 10000;
itera2 = 10000;

if nargin == 0   % if the number of inputs equals 0
    n = 4;
    t = [0 itera];
end

tic

%% Initial Conditions (random or chosen)

% a1 = -2;
% b1 = 2;
%initialCond = (b1-a1).*rand(2*n,1) + a1; 

initialCond = [0;-2.25;0;-1.25;0;1.75;0;1.75];

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

%% Phase change graph

tp1_list=te(1,2:end)-te(1,1:end-1);
tp2_list=te(2,2:end)-te(1,2:end);
tp3_list=te(3,2:end)-te(1,2:end);
tp4_list=te(4,2:end)-te(1,2:end);

phd2_list=tp2_list./tp1_list.*360;
phd3_list=tp3_list./tp1_list.*360;
phd4_list=tp4_list./tp1_list.*360;

ph_list_full = [phd2_list; phd3_list; phd4_list];

toc
tic

%% Perturb
J = y;
T = t;
t = [0 itera2];

initialCond = J(end,:) + [rand/1000,rand/1000,rand/1000,rand/1000,rand/1000,rand/1000,rand/1000,rand/1000];

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

%% Phase change graph

tp1_list=te(1,2:end)-te(1,1:end-1);
tp2_list=te(2,2:end)-te(1,2:end);
tp3_list=te(3,2:end)-te(1,2:end);
tp4_list=te(4,2:end)-te(1,2:end);

phd22_list= [phd2_list, tp2_list./tp1_list.*360];
phd33_list= [phd3_list, tp3_list./tp1_list.*360];
phd44_list=[phd4_list, tp4_list./tp1_list.*360];

ph_list_full = [phd22_list; phd33_list; phd44_list];

hold on
plot(phd22_list,'b')
plot(phd33_list,'g')
plot(phd44_list,'r')

%% Rounding phases to the nearest 1 degree

PhDi2 = ((te(2,end)-te(1,end))*360/tp1);
PhDi3 = ((te(3,end)-te(1,end))*360/tp1);
PhDi4 = ((te(4,end)-te(1,end))*360/tp1);

phaseDif = [0, PhDi2, PhDi3, PhDi4];%, initialCond']

toc
end