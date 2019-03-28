function [] = vdp4solve()

%does't quite seem to work y(1)=y(3) and y(2)=y(4)

a = -2;
b = 2;
initialCond = (b-a).*rand(8,1) + a;

[t,y] = ode23(@vdp4,[0 60],initialCond);

% [t,y] = ode23(@vdp4,[0 20],[2;0;1;0;0;0;-1;0]);

% [pks1 loc1] = findpeaks(y(:,1));
% [pks2 loc2] = findpeaks(y(:,3));
% [pks3 loc3] = findpeaks(y(:,5));
% [pks4 loc4] = findpeaks(y(:,7));
% 
% %loc = [loc1, loc2, loc3, loc4] DIMETIONS DONT ALWAYS work
% %pks = [pks1, pks2, pks3, pks4]
% y2 = y(20:end)


figure(1)
plot(t,y(:,1),'-o', t,y(:,3),'-o', t,y(:,5),'-o', t,y(:,7),'-o')
title('Solution of van der Pol Equation (e = 5) with ODE23');
xlabel('Time t');
ylabel('Solution x');
legend('x_1','x_2', 'x_3','x_4')

figure(2)
plot(t,y(:,2),'-o', t,y(:,4),'-o', t,y(:,6),'-o', t,y(:,8),'-o')
title('Solution of van der Pol Equation (e = 5) with ODE23');
xlabel('Time t');
ylabel('Solution x');
legend('x_1','x_2', 'x_3','x_4')

figure(3)
plot(y(:,1),y(:,2),'-o', y(:,3),y(:,4),'-o', y(:,5),y(:,6),'-o', y(:,7),y(:,8),'-o')
title('Solution of van der Pol Equation (e = 5) with ODE23');
xlabel('solution x');
ylabel('Xdiff');
legend('x_1', 'x_2', 'x_3', 'x_4')
end
