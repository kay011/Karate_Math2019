function [opt_c,cur_err_RH,cur_err_RV,arr_sort_angle] = InitMethod(start_x, start_y, start_z, end_x, end_y, end_z,adjust_point_arr,alpha1, alpha2, beta1, beta2, RH, RV,sum_err_RH, sum_err_RV,first_flag,last_mod)
    
   
    s = [start_x, start_y, start_z];                  % 前一个点坐标
    v=[end_x-start_x, end_y-start_y,end_z-start_z];  % 方向向量
    
    %% 遍历所有校准点
    circle_inner_points_err =[];
    for point_index=1:size(adjust_point_arr,1)
        point = adjust_point_arr(point_index,:);
        % 计算c与初始点的水平距离       
        Range_H = sqrt((point(1) - start_x)^2 + (point(2) - start_y)^2 +(point(3) - start_z)^2);
        Range_V = Range_H;      
        err_RH = Range_H * 0.001 + sum_err_RH;
        err_RV = Range_V * 0.001 + sum_err_RV;
        if((err_RH <= alpha2 && err_RV <= alpha1) ||(err_RH <= beta2 && err_RV <= beta1) )
            if(s == point(1:3))
                continue;
            end
            % 可以垂直校正的校准点
            circle_inner_points_err(end+1,:) = point;
        end
    end
    %% 计算夹角
    min_angle = 360;
    arr_1=[];
    arr_0=[];
    arr_angle_sort = [];
    for i=1:size(circle_inner_points_err,1)
        if(first_flag == 1)
             v_i = circle_inner_points_err(i,:);
       
            B = v_i(1:3) - s;
            angle=acos(dot(v,B)/(norm(v)*norm(B)))/pi*180;
            %angle = subspace(v',B');
            if(angle < min_angle)
                 min_angle = angle;
                opt_c = v_i;
            end
            arr_sort_angle(i,1) = angle;
            arr_sort_angle(i,1:4) = opt_c;
        else
            if(last_mod == 1)
                v_i = circle_inner_points_err(i,:);
                if(v_i(4) == 0)
                    arr_0(end+1,:) = v_i;
                end
            elseif(last_mod == 0)
                v_i = circle_inner_points_err(i,:);
                if(v_i(4) == 1)
                    arr_1(end+1,:) = v_i;
                end
            
            end
        end 
    end
    if first_flag ~= 1
        if(last_mod == 1)
            for i=1:size(arr_0,1)
                v_i = arr_0(i,:);

                B = v_i(1:3) - s;
                angle=acos(dot(v,B)/(norm(v)*norm(B)))/pi*180;
                %angle = subspace(v',B');
                if(angle < min_angle)
                     min_angle = angle;
                    opt_c = v_i;
                end
                arr_sort_angle(i,1) = angle;
                arr_sort_angle(i,1:4) = opt_c;
            end
        else
            for i=1:size(arr_1,1)
                v_i = arr_1(i,:);

                B = v_i(1:3) - s;
                angle=acos(dot(v,B)/(norm(v)*norm(B)))/pi*180;
                % angle = subspace(v',B');
                if(angle < min_angle)
                     min_angle = angle;
                    opt_c = v_i;
                end
                arr_sort_angle(i,1) = angle;
                arr_sort_angle(i,1:4) = opt_c;
            end
        end
    end   
%     Range_cur_HV =  sqrt((opt_c(1) - start_x)^2 + (opt_c(2) - start_y)^2 + (opt_c(3) - start_z)^2);
%     cur_err_RH = Range_cur_HV * 0.001;
%     cur_err_RV = cur_err_RH;
end

