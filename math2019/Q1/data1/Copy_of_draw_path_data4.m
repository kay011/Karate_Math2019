
% ��ͼ1 
%% ���ݼ���
% ��ȡ����У׼��
% point_0 = xlsread('0.xlsx'); % ˮƽУ׼��
% point_1 = xlsread('1.xlsx'); % ��ֱУ׼��
clear;clc;
% ����ѡȡ��У׼��
load('yueshu.mat');
Point_H = [];
Point_V = [];

for i=1:size(circle_inner_points_err,1)
    if(circle_inner_points_err(i,4) == 0)
        Point_H(end+1,:) = circle_inner_points_err(i,1:3);
    else
        Point_V(end+1,:) = circle_inner_points_err(i,1:3);
    end
end
        
%% ��ͼ����
% 0 ����ˮƽ���У׼�㣬�û�ɫ��ʾ
% 1 ����ֱ���У׼�㣬����ɫ��ʾ
figure();
%%
[x,y,z]=sphere(30);%30�ǻ�����������ľ�γ������...30�Ļ�����30������, 30��γ��

x=0+30000*x;           % Բ��:(4,2,0)   �뾶:7
y=50000+30000*y;
z=5000+30000*z;
cdata=cat(3,zeros(size(x)),ones(size(x)),zeros(size(x)));%��ɫ
surf(x,y,z,cdata);
axis equal
alpha(0.2);         %����͸����
shading flat       %ȥ����Щ��
%shading interp
hold on;
%% ɢ��ͼ
% scatter3(point_0(:,1),point_0(:,2),point_0(:,3),'b.');
% hold on;
% scatter3(point_1(:,1),point_1(:,2),point_1(:,3),'r.');
% hold on;
% ��ʼ��A
Point_A = [0.00, 50000.00, 5000.00];
scatter3(Point_A(1),Point_A(2),Point_A(3),'ro');
hold on;
% �յ�B
Point_B = [100000.00, 59652.34, 5022.00];
scatter3(100000.00,59652.34,5022.00,'mo');
hold on;
% ��ѡ·��У׼��
scatter3(Point_H(:,1),Point_H(:,2),Point_H(:,3),'b.');
hold on;
% scatter3(Point_V(:,1),Point_V(:,2),Point_V(:,3),'r.');
% hold on;
%% ����ͼ
Routes = [Point_A;Point_B];
plot3(Routes(:,1),Routes(:,2),Routes(:,3),'k-');
next_opt_Point = [ 9523, 50387, 3644 ,0];
Routes = [Point_A;next_opt_Point(:,1:3)];
plot3(Routes(:,1),Routes(:,2),Routes(:,3),'r-');
hold on;
ciyou_point = [3243.68880766171,38498.0154367019,7139.20521212522,0;
    1243.64469581529,39083.6469397951,1035.18039815804,0;
    9360.96598514233,35467.0714497972,9888.28614069443,0;
    16612.2732018317,46538.5665294772,9942.56660161132,0;
    13232.2219481959,47865.8597255863,381.357685746021,0;
    15328.8208171990,55095.1836348767,3085.60798962814,0];
for i=1:size(ciyou_point,1)
    Route = [Point_A;ciyou_point(i,1:3)];
    plot3(Route(:,1),Route(:,2),Route(:,3),'c--');
    hold on; 
end



set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);
set(gca,'xtick',0:10000:100000);
set(gca,'ytick',0:10000:100000);
set(gca,'ztick',0:10000:30000);
%% ����
title('����������Χ�ڿ��Ե����У����','Fontsize',16);
%% �����᷶Χ
axis([0 100000 0, 100000 0 30000])
%% ������label
xlabel('X��');
ylabel('Y��');
zlabel('Z��');
%% ͼ��
legend('�ٽ���','��ʼ��','�յ�','У׼��','��ʼ�㵽�յ�ֱ��·��','����·��','���������������ѡ·��');

