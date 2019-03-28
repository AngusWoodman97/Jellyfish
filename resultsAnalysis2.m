clear all
%% Loading results
load('df2_results1')
load('df2_results2')
load('df2_results3')
load('df2_results4')
load('df2_results5')
load('df2_results6')
load('df2_results7')
load('df2_results8')

InPhaseRes = [];
OutPhaseRes=[];
Case1 = [];
Case2 = [];
Case3 = [];
Case4 = [];
Case5 = [];
Case6_other = [];
X = [0, 0, 180, 180];

A = [df2_results8];%;df2_results2;df2_results3;df2_results4];

%% Getting the in and out of Phase results 
for i = 1:size(A, 1)
    if A(i,1:4) == 0
        InPhaseRes = [InPhaseRes ; A(i,:)];
    else
        OutPhaseRes = [OutPhaseRes ; A(i,:)];
    end
end

for i=1:size(OutPhaseRes,1)
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

%% Graph for results1
% Z = sort(Case1(:,6:2:12),2);
% N = sort(InPhaseRes(:,6:2:12),2);
% hold on
% ax = gca;
% ax.FontSize = 14;
% % ax.XAxisLocation = 'origin';
% % ax.YAxisLocation = 'origin';
% plot(Z(:,1),Z(:,3),'*r')
% plot(Z(:,3),Z(:,1),'*r')
% plot(N(:,1),N(:,3),'*b')
% plot(N(:,3),N(:,1),'*b')
% %title('B=-0.1');
% xlabel('$\dot{x}(0)_{1,2}$','interpreter','latex');
% ylabel('$\dot{x}(0)_{3,4}$','interpreter','latex');

%% Graph for results2

% Z = sort(Case1(:,6:2:12),2);
% N = sort(Case2(:,6:2:12),2);
% hold on
% ax = gca;
% ax.FontSize = 14;
% % ax.XAxisLocation = 'origin';
% % ax.YAxisLocation = 'origin';
% plot(Z(:,3),Z(:,4),'*r')
% plot(Z(:,4),Z(:,3),'*r')
% plot(N(:,3),N(:,4),'*g')
% plot(N(:,4),N(:,3),'*g')
% xlabel('$\dot{x}(0)_{1} = -\dot{x}(0)_{2}$','interpreter','latex');
% ylabel('$\dot{x}(0)_{3} = -\dot{x}(0)_{4}$','interpreter','latex');

%% Graph for results3
% Z = sort(Case1(:,5:2:12),2);
% N = sort(InPhaseRes(:,5:2:12),2);
% hold on
% ax = gca;
% ax.FontSize = 16;
% % ax.XAxisLocation = 'origin';
% % ax.YAxisLocation = 'origin';
% plot(Z(:,1),Z(:,3),'*r')
% plot(Z(:,3),Z(:,1),'*r')
% plot(N(:,1),N(:,3),'*b')
% plot(N(:,3),N(:,1),'*b')
% xlabel('$x(0)_{1,2}$','interpreter','latex');
% ylabel('$x(0)_{3,4}$','interpreter','latex');

%% Graph for results4

Z = sort(Case1(:,5:2:12),2);
N = sort(Case2(:,5:2:12),2);
M = sort(Case6_other(:,5:2:12),2);
hold on
ax = gca;
ax.FontSize = 16;
% ax.XAxisLocation = 'origin';
% ax.YAxisLocation = 'origin';
plot(Z(:,3),Z(:,4),'*r')
plot(Z(:,4),Z(:,3),'*r')
plot(N(:,3),N(:,4),'*g')
plot(N(:,4),N(:,3),'*g')
plot(M(:,3),M(:,4),'*g')
plot(M(:,4),M(:,3),'*g')
xlabel('$x(0)_{1} = x(0)_{2}$','interpreter','latex');
ylabel('$x(0)_{3} = x(0)_{4}$','interpreter','latex');



