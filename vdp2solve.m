function [] = vdp2solve()

[a, b]= meshgrid(-4:0.4:4, -8:0.8:8);
[c, d]= meshgrid(-4:0.4:4, -8:0.8:8);

A = 2;
B = 0;
w = 1;
e = 5;

pa = b;
pb = A*(c-a)+B*(d-b)-e*((a^2)-1)*w*b-a*w^2;
pc = d;
pd = A*(a-c)+B*(b-d)-e*((a^2)-1)*w*d-c*w^2;

hold on
figure(1)
quiver(a,b,pa,pb,5)
quiver(c,d,pc,pd,5)

[t,y] = ode23(@vdp2,[0 20],[2; 0; 1; 3]);

function dydt = vdp2(t,x)

%does't quite seem to work y(1)=y(3) and y(2)=y(4)

%dydt = [x(2); e*(1-x(1)^2)*w*x(2)-x(1)*w^2];
dydt = zeros(4,1);

dydt(1) = x(2);
dydt(2) = A*(x(3)-x(1))+B*(x(4)-x(2))-e*((x(1)^2)-1)*w*x(2)-x(1)*w^2;
dydt(3) = x(4);
dydt(4) = A*(x(1)-x(3))+B*(x(2)-x(4))-e*((x(1)^2)-1)*w*x(4)-x(3)*w^2;

end

% figure(1)
% plot(t,y(:,1),'-o', t,y(:,2),'-o', t,y(:,3),'-o', t,y(:,4),'-o')
% title('Solution of van der Pol Equation (e = 5) with ODE23');
% xlabel('Time t');
% ylabel('Solution x');
% legend('x_1','y_1', 'x_2','y_2')

plot(y(:,1),y(:,2),'-o', y(:,3),y(:,4),'-o')
title('Solution of van der Pol Equation (e = 5) with ODE23');
xlabel('solution x');
ylabel('Xdiff');
legend('x_1', 'x_2')
end
