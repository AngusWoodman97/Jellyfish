function dydt = vdpN2(t,x)

A = 2;
B = 0;
w = 1;
e = 5;
n=4;

dydt = zeros(2*n,1);

yDot = zeros(n,1);
xDot = zeros(n,1);

for i = 1:n
    if i == 1
        sumA = sum([-2*x(1) x(3) x(2*n-1)]);
        sumB = sum([-2*x(2) x(4) x(n)]);
    elseif i == n
        sumA = sum([-2*x(2*n-1) x(2*n-3) x(1)]);
        sumB = sum([-2*x(2*n) x(2*n-2) x(2)]);
    else
        sumA = sum([-2*x(2*i-1) x(2*i-3) x(2*i+1)]);
        sumB = sum([-2*x(2*i) x(2*i-2) x(2*i+2)]);
    end
    xDot(i) = x(2*i);
    yDot(i) = A*(sumA)+B*(sumB)-e*((x(2*i-1))^2-1)*w*x(2*i)-(w^2)*x(2*i-1);
end

dydt(2:2:end) = yDot;
dydt(1:2:end-1) = xDot;

end