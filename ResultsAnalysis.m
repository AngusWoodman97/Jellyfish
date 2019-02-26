clear all
%% Loading results
load('results1.mat')

InPhaseRes = [];
halfPhase = [];
OutPhaseRes=[];

A = results1;

%% Trying to remove results with the same IC's but in different order (could just do that when setting the ic's in the first place)
% for j = 1:size(A, 1)
%     if sum(ismember(A(:,5:12),A(j,5:12)),2) == 8
%         j
%     end
% end

%% Getting the in and out of Phase results 
for i = 1:size(A, 1)
    if A(i,1:4) == 0
        InPhaseRes = [InPhaseRes ; A(i,:)];
%      elseif sum(A(i,1:4))==360
%          halfPhase = [halfPhase ; A(i,:)];
    else
        OutPhaseRes = [OutPhaseRes ; A(i,:)];
    end
end

