clear all
initialCondMatrix = [0,0,0,0,0,0,0,0];
A=[];
B=[];
time=0
for j = -2.25:0.5:2.25
    for k = -2.25:0.5:2.25
        for l = -2.25:0.5:2.25
            for m = -2.25:0.5:2.25
                
                initialCond = [j;0;k;0;l;0;m;0];
                initialCond2 = [j,0,k,0,l,0,m,0; k,0,l,0,m,0,j,0;...
                    l,0,m,0,j,0,k,0; m,0,j,0,k,0,l,0; m,0,l,0,k,0,j,0;...
                    l,0,k,0,j,0,m,0;k,0,j,0,m,0,l,0;j,0,m,0,l,0,k,0];

                
                initialCondCheck = [];
                for i=1:size(initialCond2,1)
                    initialCondCheck = [initialCondCheck;sum(ismember(initialCondMatrix,initialCond2(i,:),'rows'))];
                end
                if sum(initialCondCheck)>0
                    A = [A,initialCond];
                else
                    B = [B,initialCond];
                    initialCondMatrix = [initialCondMatrix; initialCond'];
                end
            end
        end
    end
time=time+1
end