clear,clc
x = [0 .31667 .60074 .82298];
y = [1 .88546 .56806 .12054];
z = [1 .79944 .27822 -.3546];
l = length(x);
sp = spline(1:l,[x;y;z],1:.1:l);
plot3(x,y,z,'ro',sp(1,:),sp(2,:),sp(3,:),'linewidth',1.5)
grid on