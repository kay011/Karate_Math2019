clear;clc;
%% 画图
%% 数据加载
% 读取所有校准点
point_0 = xlsread('0.xlsx'); % 水平校准点
point_1 = xlsread('1.xlsx'); % 垂直校准点

% 加载选取的校准点
load('data1_paths.mat');
%% 绘图部分
% 0 代表水平误差校准点，用黄色表示
% 1 代表垂直误差校准点，用蓝色表示
figure();
%% 散点图
scatter3(point_0(:,1),point_0(:,2),point_0(:,3),'b.');
hold on;
scatter3(point_1(:,1),point_1(:,2),point_1(:,3),'y.');
hold on;
% 起始点A
Point_A = [0.00, 50000.00, 5000.00];
scatter3(Point_A(1),Point_A(2),Point_A(3),'ro');
hold on;
% 终点B
Point_B = [100000.00, 59652.34, 5022.00];
scatter3(100000.00,59652.34,5022.00,'mo');
hold on;
scatter3(arr_res(:,1),arr_res(:,2),arr_res(:,3),'.');
hold on;
%% 航迹图
Routes = [Point_A;arr_res(:,1:3);Point_B];
%plot3(Routes(:,1),Routes(:,2),Routes(:,3),'k-');
%% 问题2的平滑
smoothFunc3(Routes);
%% 
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'xtick',0:10000:100000);
set(gca,'ytick',0:10000:100000);
set(gca,'ztick',0:10000:30000);
%% 标题
title('飞行器航迹规划');
%% 坐标轴范围
axis([0 100000 0, 100000 0 30000])
%% 坐标轴label
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
%% 图例
legend('垂直校准点','水平校准点','起始点','终点','所选航迹点','航线直线路径','航线曲线路径');

