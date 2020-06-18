
% 画图1 
%% 数据加载
% 读取所有校准点
% point_0 = xlsread('0.xlsx'); % 水平校准点
% point_1 = xlsread('1.xlsx'); % 垂直校准点
clear;clc;
% 加载选取的校准点
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
        
%% 绘图部分
% 0 代表水平误差校准点，用黄色表示
% 1 代表垂直误差校准点，用蓝色表示
figure();
%%
[x,y,z]=sphere(30);%30是画出来的球面的经纬分面数...30的话就是30个经度, 30个纬度

x=0+30000*x;           % 圆心:(4,2,0)   半径:7
y=50000+30000*y;
z=5000+30000*z;
cdata=cat(3,zeros(size(x)),ones(size(x)),zeros(size(x)));%绿色
surf(x,y,z,cdata);
axis equal
alpha(0.2);         %设置透明度
shading flat       %去掉那些线
%shading interp
hold on;
%% 散点图
% scatter3(point_0(:,1),point_0(:,2),point_0(:,3),'b.');
% hold on;
% scatter3(point_1(:,1),point_1(:,2),point_1(:,3),'r.');
% hold on;
% 起始点A
Point_A = [0.00, 50000.00, 5000.00];
scatter3(Point_A(1),Point_A(2),Point_A(3),'ro');
hold on;
% 终点B
Point_B = [100000.00, 59652.34, 5022.00];
scatter3(100000.00,59652.34,5022.00,'mo');
hold on;
% 所选路径校准点
scatter3(Point_H(:,1),Point_H(:,2),Point_H(:,3),'b.');
hold on;
% scatter3(Point_V(:,1),Point_V(:,2),Point_V(:,3),'r.');
% hold on;
%% 航迹图
Routes = [Point_A;Point_B];
plot3(Routes(:,1),Routes(:,2),Routes(:,3),'k-');
next_opt_Point = [ 9523, 50387, 3644 ,0];
hold on;
scatter3(next_opt_Point(1),next_opt_Point(2),next_opt_Point(3),'bo');
hold on;
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
%% 标题
title('飞行器在误差范围内可以到达的校正点','Fontsize',16);
%% 坐标轴范围
axis([0 100000 0, 100000 0 30000])
%% 坐标轴label
xlabel('X轴');
ylabel('Y轴');
zlabel('Z轴');
%% 图例
legend('临界区','起始点','终点','校准点','起始点到终点直线路径','最优路径','满足条件的其余可选路径');

