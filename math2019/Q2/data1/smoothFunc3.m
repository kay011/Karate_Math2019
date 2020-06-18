function smoothFunc3(Routes)
    coff = 300;
    size_R = size(Routes,1);
    start_Point = Routes(1,:);
    
    for i=1:size(Routes,1)
        if( i <= (size_R - 2))
            Point_last = Routes(i,:); % A
            Point_next = Routes(i+1,:); % B
            Point_next_next = Routes(i+2,:); % C
            [Point_last_right, Point_next_left] = searchPoint(Point_last, Point_next, coff);
            [Point_next_right, Point_next_next_left] = searchPoint(Point_next, Point_next_next,coff);
            x = [Point_next_left(1), Point_next(1), Point_next_right(1)];
            y = [Point_next_left(2), Point_next(2), Point_next_right(2)];
            z = [Point_next_left(3), Point_next(3), Point_next_right(3)];
            %% 连接直线
            
            plot3([start_Point(1), Point_next_left(1)],[start_Point(2), Point_next_left(2)],[start_Point(3), Point_next_left(3)],'k-');
            hold on;
            
            
            %%
            l = length(x);
            sp = spline(1:l,[x;y;z],1:.1:l);
            plot3(x,y,z,'r-',sp(1,:),sp(2,:),sp(3,:));
            hold on;
            
            start_Point = Point_next_right;
            
        end

    end
    plot3([start_Point(1), Routes(end,1)],[start_Point(2), Routes(end,2)],[start_Point(3), Routes(end,3)],'k-');
    hold on;
    
        

      
end

