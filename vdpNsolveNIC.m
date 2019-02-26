function [phaseDifMatrix] = vdpNsolveNIC(n, t)

clf;

if nargin == 0   % if the number of inputs equals 0
    n = 4;
    t = [0 10000];
end

phaseDifMatrix = [];
initialCondMatrix = [0,0,0,0,0,0,0,0];
initialCondRepeatMatrix = [];
time = 0;

for j = -3.25:0.5:3.25
    for k = -3.25:0.5:3.25
        for l = -3.25:0.5:3.25
            for m = -3.25:0.5:3.25
                
                initialCond = [0;j;0;k;0;l;0;m];
                
                if sum(ismember(sort(initialCondMatrix,2),sort(initialCond'),'rows'))>0
                    initialCondRepeatMatrix = [initialCondRepeatMatrix; initialCond'];
                else
                    
                    initialCondMatrix = [initialCondMatrix; initialCond'];
                    
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
%                     if tp1-tp2<0.0001 && tp2-tp3<0.0001 && tp3-tp4<0.0001
%                     else
%                         'Error with time periods, not the same'
%                         TimePeriods = [tp1, tp2, tp3, tp4]
%                     end
                    
                    %% Not Rounding phases to the nearest 1 degree
                    
                    PhDi2 = ((te(2,end)-te(1,end))*360/tp1);
                    PhDi3 = ((te(3,end)-te(1,end))*360/tp1);
                    PhDi4 = ((te(4,end)-te(1,end))*360/tp1);
                    
                    phaseDif = [0, PhDi2, PhDi3, PhDi4, initialCond'];
                    phaseDifMatrix = [phaseDifMatrix; phaseDif];
                end
                time = time + 1
            end
        end
    end
end
end