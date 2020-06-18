function [length_sum] = getLength(arr_res)
    length_sum = 0;%计算路径长度
    A = [0, 50000, 5000];
    B = [100000.00,59652.34,5022.00];
    length_sum = length_sum +sqrt((A(1)-arr_res(1,1))^2+(A(2)-arr_res(1,2))^2+(A(3)-arr_res(1,3))^2);
    for i = 2:size(arr_res,1)
        t=sqrt((arr_res(i-1,1)-arr_res(i,1))^2+(arr_res(i-1,2)-arr_res(i,2))^2+(arr_res(i-1,3)-arr_res(i,3))^2);
        length_sum = length_sum +t;
    end
    length_sum = length_sum +sqrt((B(1)-arr_res(7,1))^2+(B(2)-arr_res(7,2))^2+(B(3)-arr_res(7,3))^2);
end