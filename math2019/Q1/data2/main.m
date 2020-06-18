% 加载候选点
clear;
clc;

point_2 = xlsread('data2.xlsx');


A = [0, 50000, 5000];
B = [100000.00,74860.55 ,5499.61 ];
start_x = A(1);
start_y = A(2);
start_z = A(3);
end_x = B(1);
end_y = B(2);
end_z = B(3);
arr_res = [];
% 计算 当前点和终点的水平距离
dist_b1 = sqrt((end_x - start_x)^2 + (end_y - start_y)^2 + (end_z - start_z)^2);
% 计算 当前点和终点的水平距离
%dist_b2 = abs(end_z - start_z);
% 计算 当前点到终点的误差
err_RH = dist_b1 * 0.001;
% 计算 当前点到终点的误差
err_RV = dist_b1 * 0.001;
% 误差上限
theta = 20; 
adjust_point_arr = point_2;
RH = 30000;
RV = 30000;
% 如果当前点到终点的误差已经满足要求，则跳出循环
% 如果不满足要求，就需要寻找误差校正点

sum_err_RH = 0;
sum_err_RV = 0;
alpha1 = 20;
alpha2 = 10;
beta1 = 15;
beta2 = 20;
first_flag = 1;
last_mod = 0;
while( err_RH > theta || err_RV > theta)
    % 选择当前最优校正点
    
    [opt_c, cur_err_RH, cur_err_RV] = InitMethod(start_x, start_y, start_z, end_x, end_y, end_z,adjust_point_arr,alpha1, alpha2, beta1, beta2, RH, RV, sum_err_RH, sum_err_RV,first_flag,last_mod);
    opt_c
    if opt_c(4) == 1
        sum_err_RV = 0;
        sum_err_RH = sum_err_RH + cur_err_RH;
        last_mod = 1;
    
    elseif opt_c(4) == 0
        sum_err_RH = 0;
        sum_err_RV = sum_err_RV + cur_err_RH;
        last_mod = 0;
    end
        
    arr_res(end+1,:) = opt_c;
    start_x =opt_c(1);
    start_y = opt_c(2);
    start_z = opt_c(3);
    
    %计算是否进行下次循环
    dist_b1 = sqrt((end_x - start_x)^2 + (end_y - start_y)^2 + (end_z - start_z)^2);
%     dist_b2 = abs(end_z - start_z);
    dist_b2 = dist_b1;
    err_RH = dist_b1 * 0.001 +  sum_err_RH;
    err_RV = dist_b2 * 0.001 +  sum_err_RV;
    first_flag = first_flag+1;
    
end
save('data2_paths.mat','arr_res');
