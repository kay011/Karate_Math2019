% function smoothFunc(Routes)
    % 计算向量
%     Point_A = Routes(2,:);
%     Point_B = Routes(3,:);
%     Point_C = Routes(4,:);
    %coff = 100;
%     [Point_A_right, Point_B_left,~] = searchPoint(Point_A, Point_B, coff);
%     [Point_B_right, Point_C_left,~] = searchPoint(Point_B, Point_C, coff);
    Point_A = [33,44,55];
    Point_B = [44,34,67];
    coff = 2;
    [Point_A_right, Point_B_left,~,~] = searchPoint(Point_A, Point_B, coff);
%     ThreePoint2Circle(Point_B_left, Point_B, Point_B_right);
     % 在Point_B_left 与Point_B 之间画弧线
     % 在Point_B 与Point_B_right之间画弧线
     [tmp1, tmp2,tmp3, tmp4, tmp5,tmp6,tmp7, norm_Vec,Vecc] = searchPoint2(Point_B_left, Point_B,coff*0.2);
     t1 = (tmp1-Point_B_left) / norm_Vec;
     t2 = (tmp2-Point_B_left) / norm_Vec;
     t3 = (tmp3-Point_B_left) / norm_Vec;
     t4 = (tmp4-Point_B_left) / norm_Vec;
     t5 = (tmp5-Point_B_left) / norm_Vec;
     t6 = (tmp6-Point_B_left) / norm_Vec;
     t7 = (tmp7-Point_B_left) / norm_Vec;
     % t1,t2是个数字
     t10 = Vecc /norm_Vec;
     t = [0, t1/t10, t2/t10,t3/t10,t4/t10,t5/t10,t6/t10,t7/t10, 1];
     y = sin(pi*t);
     T1 = y(2);
     T2 = y(3);
     T3 = y(4);
     T4 = y(5);
     T5 = y(6);
     T6 = y(7);
     T7 = y(8);
     trans_tmp1 = T1 * norm_Vec + Point_B_left;
     trans_tmp2 = T2 * norm_Vec + Point_B_left;
     trans_tmp3 = T3 * norm_Vec + Point_B_left;
     trans_tmp4 = T4 * norm_Vec + Point_B_left;
     trans_tmp5 = T5 * norm_Vec + Point_B_left;
     trans_tmp6 = T6 * norm_Vec + Point_B_left;
     trans_tmp7 = T7 * norm_Vec + Point_B_left;
     arr_res = [Point_B_left;trans_tmp1;trans_tmp2;trans_tmp3 ;trans_tmp4 ;trans_tmp5 ;trans_tmp6;trans_tmp7;Point_B];
     
     plot3(arr_res(:,1),arr_res(:,2), arr_res(:,3));
     
     
     
     


    
    
%     plot3(Routes(:,1),Routes(:,2),Routes(:,3),'k-');
% end

