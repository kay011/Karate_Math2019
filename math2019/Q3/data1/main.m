clear ;clc;close all;

gen = 5;
load case1
MaxR = 29000/2;

%% 改进解
obj= @(x) fobj(x,loc,nodetype,nodehealth);
obj2= @(x) fobj2(x,loc,nodetype,nodehealth);

V = 612;M =3;
[chromosome]=ycmopt(obj,obj2,loc,nodetype,MaxR,M,V,gen);

[~,SI]=sort(chromosome(:,M+V));
chromosome = chromosome(SI,:);
Ind = find(chromosome(:,V+2)==12,1);
fprintf('-------------------------\n改进后的解\n');
fobjprintf(chromosome(Ind,:),loc,nodetype,nodehealth);

figure(21);
% clf;hold on;
plot3(loc(2:end-1,1),loc(2:end-1,2),loc(2:end-1,3),'b.');
hold on
plot3(loc([1 end],1),loc([1 end],2),loc([1 end],3),'r*');
Ind2= find(chromosome(Ind,1:V)==0,1)-1;
plot3(loc([1 chromosome(Ind,1:Ind2)],1),...
    loc([1 chromosome(Ind,1:Ind2)],2),...
    loc([1 chromosome(Ind,1:Ind2)],3),'r-*');
legend('校准点','起始点');

%% 原始解
obj= @(x) fobjold(x,loc,nodetype);
obj2= @(x) fobj2old(x,loc,nodetype);
V = 612;M =2;
[chromosomeold]=ycmopt(obj,obj2,loc,nodetype,MaxR,M,V,gen);
[~,SI]=sort(chromosomeold(:,M+V));
chromosomeold = chromosomeold(SI,:);
Ind = find(chromosomeold(:,V+2)==12,1);
fprintf('-------------------------\n改进前的解\n');
fobjprintf(chromosomeold(Ind,:),loc,nodetype,nodehealth);

figure(22);
% clf;hold on;
plot3(loc(2:end-1,1),loc(2:end-1,2),loc(2:end-1,3),'b.');
hold on
plot3(loc([1 end],1),loc([1 end],2),loc([1 end],3),'r*');
Ind2= find(chromosomeold(Ind,1:V)==0,1)-1;
plot3(loc([1 chromosomeold(Ind,1:Ind2)],1),...
    loc([1 chromosomeold(Ind,1:Ind2)],2),...
    loc([1 chromosomeold(Ind,1:Ind2)],3),'r-*');
legend('校准点','起始点');