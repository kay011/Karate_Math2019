function R = RCAL(l1,l2,l3)

acc = [l1 1;l2 1;l3 1];
A1 = det(acc(:,2:end));
B1 = -det(acc(:,[1 3 4]));
C1 = det(acc(:,[1 2 4]));
D1 = -det(acc(:,[1 2 3]));

D2 = l1(1)^2-sum(l2.^2);
D3 = l1(1)^2-sum(l3.^2);
ABC2 = 2*[l2-l1];
ABC3 = 2*[l3-l1];

Acc = [A1 B1 C1;ABC2;ABC3];
l4 = -inv(Acc)*[D1;D2;D3];
R=norm(l1-l4');

end