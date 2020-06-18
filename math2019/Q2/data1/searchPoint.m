function [Point_A_right, Point_B_left] = searchPoint(Point_A, Point_B, coff)
    %% 方向向量
    Vec = [Point_B(1) - Point_A(1), Point_B(2) - Point_A(2),Point_B(3) - Point_A(3)];
    %% 求取单位向量
    norm_Vec = Vec / norm(Vec);
    Point_A_right = Point_A + norm_Vec * coff;
    Point_B_left = Point_B - norm_Vec * coff;

end