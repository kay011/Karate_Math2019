function smoothFunc2(Routes)

    % º∆À„œÚ¡ø
    Point_A = Routes(2,:);
    Point_B = Routes(3,:);
    Point_C = Routes(4,:);
    coff = 100;
    [Point_A_right, Point_B_left] = searchPoint(Point_A, Point_B, coff);
    [Point_B_right, Point_C_left] = searchPoint(Point_B, Point_C, coff);
    x = [Point_B_left(1),Point_B(1), Point_B_right(1)];
    y = [Point_B_left(2),Point_B(2), Point_B_right(2)];
    z = [Point_B_left(3),Point_B(3), Point_B_right(3)];
    l = length(x);
    sp = spline(1:l,[x;y;z],1:.1:l);
    plot3(x,y,z,'ro',sp(1,:),sp(2,:),sp(3,:),'linewidth',1.5);
      
end

