clear;
clc;

load('finQ3_data2.mat');
point_0 = xlsread('data2.xlsx');



scatter3(point_0(:,1),point_0(:,2),point_0(:,3),'.','b')
hold on;
% scatter3(point_1(:,1),point_1(:,2),point_1(:,3),'.','r')
% hold on;
scatter3(0.00,50000.00,5000.00,'r')
hold on;
scatter3(100000.00,74860.55 ,5499.61,'ro')

hold on;
scatter3(arr_res(:,1),arr_res(:,2),arr_res(:,3),'bo');
hold on;
plot3(arr_res(:,1),arr_res(:,2),arr_res(:,3));