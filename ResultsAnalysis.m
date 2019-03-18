clear all
%% Loading results
load('results5.mat')

InPhaseRes = [];
OutPhaseRes=[];

A = results5;

%% Getting the in and out of Phase results 
for i = 1:size(A, 1)
    if A(i,1:4) == 0
        InPhaseRes = [InPhaseRes ; A(i,:)];
    else
        OutPhaseRes = [OutPhaseRes ; A(i,:)];
    end
end

Case1 = [];
Case2 = [];
Case3 = [];
Case4 = [];
Case5 = [];
Case6_other = [];
X = [0, 0, 180, 180];

for i=1:length(OutPhaseRes)
    if isequal(round(OutPhaseRes(i,1:4),3),X)
        Case1 = [Case1;OutPhaseRes(i,:)];
    elseif round(OutPhaseRes(i,3),3) == 180 & round(OutPhaseRes(i,2),3)+180 == round(OutPhaseRes(i,4),3)
        Case2 = [Case2;OutPhaseRes(i,:)];
    elseif round(OutPhaseRes(i,1:2),3) == 0 & round(OutPhaseRes(i,3:4),3) ~= 0
        Case3 = [Case3;OutPhaseRes(i,:)];
    elseif round(OutPhaseRes(i,2),3) ~= 0 & round(OutPhaseRes(i,3),3) == round(OutPhaseRes(i,4),3)
        Case4 = [Case4;OutPhaseRes(i,:)];
    elseif round(OutPhaseRes(i,1:3),3) == 0 & round(OutPhaseRes(i,4),3) ~= 0
        Case5 = [Case5;OutPhaseRes(i,:)];
    else
        Case6_other = [Case6_other;OutPhaseRes(i,:)];
    end
end


