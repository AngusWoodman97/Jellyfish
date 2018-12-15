function dydt = vdp1(t,y)

dydt = zeros(2,1);
dydt(1) = y(1)+2*y(2);
dydt(2) = 3*y(1)+2*y(2);

end

