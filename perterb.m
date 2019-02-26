function [] = perterb(n, t)

clf;

itera = 8000;
petb = 0.00001;

if nargin == 0   % if the number of inputs equals 0
    n = 4;
    t = [0 itera];
end

time = 0;

%% Initial Conditions (random or chosen)

% a1 = -2;
% b1 = 2;
%initialCond = (b1-a1).*rand(2*n,1) + a1; 

initialCond = [0;-3.25;0;0.25;0;-0.25;0;3.25];

%% ODE solver

options = odeset('Events',@myEventsFun);
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
% if tp1-tp2<0.00001 && tp2-tp3<0.00001 && tp3-tp4<0.00001
% else
%     'time periods not the same'
%  %   format long
%     TimePeriods = [tp1, tp2, tp3, tp4]
% end

%% Phase change whole

tp1_list=te(1,2:end)-te(1,1:end-1);
tp2_list=te(2,2:end)-te(1,2:end);
tp3_list=te(3,2:end)-te(1,2:end);
tp4_list=te(4,2:end)-te(1,2:end);

phd2_list=tp2_list./tp1_list.*360;
phd3_list=tp3_list./tp1_list.*360;
phd4_list=tp4_list./tp1_list.*360;

%% Perterb and do agian

%for i=1:4

t = [0 itera];

initialCond = y(end,:) + [petb, 0, 0, 0, 0, 0, 0, 0];
% initialCond = y(end,:) + [0, petb, 0, 0, 0, 0, 0, 0];
% initialCond = y(end,:) + [petb, 0, petb, 0, petb, 0, petb, 0];
% initialCond = y(end,:) + [0, petb, 0, petb, 0, petb, 0, petb];

%% ODE solver

options = odeset('Events',@myEventsFun);
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

% if tp1-tp2<0.00001 && tp2-tp3<0.00001 && tp3-tp4<0.00001
% else
%     'time periods not the same'
% %    format long
%     TimePeriods = [tp1, tp2, tp3, tp4]
% end

%% Phase change whole Plot

tp1_list=te(1,2:end)-te(1,1:end-1);
tp2_list=te(2,2:end)-te(1,2:end);
tp3_list=te(3,2:end)-te(1,2:end);
tp4_list=te(4,2:end)-te(1,2:end);

phd2_list= [phd2_list, tp2_list./tp1_list.*360];
phd3_list= [phd3_list, tp3_list./tp1_list.*360];
phd4_list=[phd4_list, tp4_list./tp1_list.*360];

%ph_list_full = [phd2_list; phd3_list; phd4_list];
%end
hold on
plot(phd2_list,'b')
plot(phd3_list,'g')
plot(phd4_list,'r')
end