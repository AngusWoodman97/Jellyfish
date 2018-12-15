function [] = vdp1solve()
clear all

[x, y]= meshgrid(-3:0.4:3, -12:2:12);
w = 1;
e = 5;
px=y;
py=e.*(1-x.^2).*w.*y-x.*w.^2;
hold on
figure(1)
quiver(x,y,px,py,4)

[t,l] = ode23(@vdp1,[0 40],[-1; 5]);
plot(l(:,1),l(:,2),'-o')

% [t,l] = ode23(@vdp1,[0 40],[-2; 7]);
% plot(l(:,1),l(:,2),'-o')
% 
% [t,l] = ode23(@vdp1,[0 40],[1; -5]);
% plot(l(:,1),l(:,2),'-o')
% 
% [t,l] = ode23(@vdp1,[0 40],[2; -7]);
% plot(l(:,1),l(:,2),'-o')

title('Solution of a single van der Pol oscillator');
xlabel('x');
ylabel('xdot');
legend('Vector Field','x_1','x_2','x_3','x_4')
figure(2)
plot(t,l(:,1),'-o')

function dydt = vdp1(t,x)

dydt = [x(2); e*(1-x(1)^2)*w*x(2)-x(1)*w^2];

end

end


