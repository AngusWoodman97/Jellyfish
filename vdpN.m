function dydt = vdpN(t,x)


A = 2;
B = 0.1;
w = 1;
e = 5;
n=numel(x)/2;

dydt = zeros(2*n,1);

yDot = zeros(n,1);
xDot = zeros(n,1);
ALst = zeros(n,1);
BLst = zeros(n,1);

for i = 1:n
    ALst(i) = x(2*i-1);
    BLst(i) = x(2*i);
end

sumA = sum(ALst);
sumB = sum(BLst);

for i = 1:n
    xDot(i) = x(2*i);
    yDot(i) = e*A*(sumA-n*ALst(i))+e*B*(sumB-n*BLst(i))-e*((x(2*i-1))^2-1)*w*x(2*i)-(w^2)*x(2*i-1);
end

dydt(2:2:end) = yDot;
dydt(1:2:end-1) = xDot;

end