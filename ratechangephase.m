y1=zeros(1,length(x)-1);
y2=zeros(1,length(x)-1);
y3=zeros(1,length(x)-1);


for i = 1:length(x)-1
    y1(i)=x(1,i+1)-x(1,i);
    y2(i)=x(2,i+1)-x(2,i);
    y3(i)=x(3,i+1)-x(3,i);
end
y=[y1;y2;y3];