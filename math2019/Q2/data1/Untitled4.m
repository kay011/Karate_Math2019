 
Point_A = [33,44,55];
Point_B = [44,34,67];
coff = 2;
[Point_A_right, Point_B_left] = searchPoint(Point_A, Point_B, coff);

scatter3(Point_A(1),Point_A(2),Point_A(3),'bo');
hold on;
scatter3(Point_A_right(1),Point_A_right(2),Point_A_right(3),'bo');
hold on;
scatter3(Point_B(1),Point_B(2),Point_B(3),'r*');
hold on;
scatter3(Point_B_left(1),Point_B_left(2),Point_B_left(3),'r*');
hold on;
plot3([Point_A(1),Point_B(1)],[Point_A(2),Point_B(2)],[Point_A(3),Point_B(3)],'k-');
hold on;
plot3([Point_A(1),Point_A_right(1)],[Point_A(2),Point_A_right(2)],[Point_A(3),Point_A_right(3)],'r-');
hold on;