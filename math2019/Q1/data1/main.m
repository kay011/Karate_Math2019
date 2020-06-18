% ���غ�ѡ��
clear;
clc;
point_0 = xlsread('0.xlsx');
point_1 = xlsread('1.xlsx'); 
point(1:306,:)=point_0;
point(307:611,:)=point_1;

A = [0, 50000, 5000];
B = [100000.00,59652.34,5022.00];
start_x = A(1);
start_y = A(2);
start_z = A(3);
end_x = B(1);
end_y = B(2);
end_z = B(3);
arr_res = [];
% ���� ��ǰ����յ��ˮƽ����
dist_b1 = sqrt((end_x - start_x)^2 + (end_y - start_y)^2 + (end_z - start_z)^2);
% ���� ��ǰ����յ��ˮƽ����
%dist_b2 = abs(end_z - start_z);
% ���� ��ǰ�㵽�յ�����
err_RH = dist_b1 * 0.001;
% ���� ��ǰ�㵽�յ�����
err_RV = dist_b1 * 0.001;
% �������
theta = 30; 
adjust_point_arr = point;
RH = 30000;
RV = 30000;
% �����ǰ�㵽�յ������Ѿ�����Ҫ��������ѭ��
% ���������Ҫ�󣬾���ҪѰ�����У����

sum_err_RH = 0;
sum_err_RV = 0;
alpha1 = 25;
alpha2 = 15;
beta1 = 20;
beta2 = 25;
first_flag = 1;
last_mod = 0;
while( err_RH > theta || err_RV > theta)
    % ѡ��ǰ����У����
    
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
    
    %�����Ƿ�����´�ѭ��
    dist_b1 = sqrt((end_x - start_x)^2 + (end_y - start_y)^2 + (end_z - start_z)^2);
%     dist_b2 = abs(end_z - start_z);
    dist_b2 = dist_b1;
    err_RH = dist_b1 * 0.001 + sum_err_RH;
    err_RV = dist_b2 * 0.001 + sum_err_RV;
    first_flag = first_flag+1;
    
end
save('data1_paths.mat','arr_res');
