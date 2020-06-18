function [ a,b,c,d,e,f,g,norm_Vec,Vec] = searchPoint2(Point_A, Point_B, coff)
    %% 方向向量
    Vec = [Point_B(1) - Point_A(1), Point_B(2) - Point_A(2),Point_B(3) - Point_A(3)];
    %% 求取单位向量
    norm_Vec = Vec / norm(Vec);
    a = Point_A + norm_Vec * coff;
    b= Point_A + norm_Vec * coff*2;
    c = Point_A + norm_Vec * coff*3;
    d = Point_A + norm_Vec * coff*4;
    e = Point_A + norm_Vec * coff*5;
    f = Point_A + norm_Vec * coff*6;
    g = Point_A + norm_Vec * coff*7;
    

end