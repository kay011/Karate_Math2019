% ���غ�ѡ��
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
% ���� ��ǰ����յ��ˮƽ����
dist_b1 = sqrt((end_x - start_x)^2 + (end_y - start_y)^2 + (end_z - start_z)^2);
% ���� ��ǰ����յ��ˮƽ����
%dist_b2 = abs(end_z - start_z);
% ���� ��ǰ�㵽�յ�����
err_RH = dist_b1 * 0.001;
% ���� ��ǰ�㵽�յ�����
err_RV = dist_b1 * 0.001;
% �������
theta = 20; 
adjust_point_arr = point_2;
RH = 30000;
RV = 30000;
% �����ǰ�㵽�յ������Ѿ�����Ҫ��������ѭ��
% ���������Ҫ�󣬾���ҪѰ�����У����

sum_err_RH = 0;
sum_err_RV = 0;
alpha1 = 20;
alpha2 = 10;
beta1 = 15;
beta2 = 20;
first_flag = 1;
last_mod = 0;
% last_point_arr = [angle, x,y,z,type]
last_point_arr = [];
while( err_RH > theta || err_RV > theta)
    
    if(first_flag ~= 1)
        for i=1:size(last_point_arr, 1)
            start_x = last_point_arr(i,2);
            start_y = last_point_arr(i,3);
            start_z = last_point_arr(i,4);
            [next_point_arr] = find_next_point_arr(start_x, start_y, start_z, end_x, end_y, end_z,adjust_point_arr,alpha1, alpha2, beta1, beta2, RH, RV, sum_err_RH, sum_err_RV,first_flag,last_mod);
            if(size(next_point_arr,1) > 0)
                opt_c = next_point_arr(1,2:5);               
                last_point_arr = next_point_arr;
                
                break;
            end
            
            %Ѱ�Ҵ��Ž�
            
        end
    else
        [next_point_arr] = find_next_point_arr(start_x, start_y, start_z, end_x, end_y, end_z,adjust_point_arr,alpha1, alpha2, beta1, beta2, RH, RV, sum_err_RH, sum_err_RV,first_flag,last_mod);
         opt_c = next_point_arr(1,2:5);
         last_point_arr = next_point_arr;
    end
    opt_c
    Range_cur_HV =  sqrt((opt_c(1) - start_x)^2 + (opt_c(2) - start_y)^2 + (opt_c(3) - start_z)^2);
    cur_err_RH = Range_cur_HV * 0.001;
    cur_err_RV = cur_err_RH;
    
    if opt_c(4) == 1
        sum_err_RV = 0;
        sum_err_RH = sum_err_RH + cur_err_RH;
        last_mod = 1;
    
    elseif opt_c(4) == 0
        sum_err_RH = 0;
        sum_err_RV = sum_err_RV + cur_err_RV;
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
    err_RH = dist_b1 * 0.001 +  sum_err_RH;
    err_RV = dist_b2 * 0.001 +  sum_err_RV;
    first_flag = first_flag+1;
    
end
save('data2_paths.mat','arr_res');
