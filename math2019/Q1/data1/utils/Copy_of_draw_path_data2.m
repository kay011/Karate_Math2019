
% ��ͼ1 
%% ���ݼ���
% ��ȡ����У׼��
% point_0 = xlsread('0.xlsx'); % ˮƽУ׼��
% point_1 = xlsread('1.xlsx'); % ��ֱУ׼��

% ����ѡȡ��У׼��
load('circle.mat');
Point_H = [];
Point_V = [];

for i=1:size(circle_inner_points,1)
    if(circle_inner_points(i,4) == 0)
        Point_H(end+1,:) = circle_inner_points(i,1:3);
    else
        Point_V(end+1,:) = circle_inner_points(i,1:3);
    end
end
        
%% ��ͼ����
% 0 ����ˮƽ���У׼�㣬�û�ɫ��ʾ
% 1 ����ֱ���У׼�㣬����ɫ��ʾ
figure();
%%
[x,y,z]=sphere(30);%30�ǻ�����������ľ�γ������...30�Ļ�����30������, 30��γ��

x=0+30000*x;           % Բ��:(4,2,0)   �뾶:7
y=50000+30000*y;
z=5000+30000*z;
cdata=cat(3,zeros(size(x)),ones(size(x)),zeros(size(x)));%��ɫ
surf(x,y,z,cdata);
axis equal
alpha(0.2);         %����͸����
shading flat       %ȥ����Щ��
%shading interp
hold on;
%% ɢ��ͼ
% scatter3(point_0(:,1),point_0(:,2),point_0(:,3),'b.');
% hold on;
% scatter3(point_1(:,1),point_1(:,2),point_1(:,3),'r.');
% hold on;
% ��ʼ��A
Point_A = [0.00, 50000.00, 5000.00];
scatter3(Point_A(1),Point_A(2),Point_A(3),'ro');
hold on;
% �յ�B
Point_B = [100000.00, 59652.34, 5022.00];
scatter3(100000.00,59652.34,5022.00,'mo');
hold on;
% ��ѡ·��У׼��
scatter3(Point_H(:,1),Point_H(:,2),Point_H(:,3),'b.');
hold on;
scatter3(Point_V(:,1),Point_V(:,2),Point_V(:,3),'r.');
hold on;
%% ����ͼ
% Routes = [Point_A;arr_res(:,1:3);Point_B];
% plot3(Routes(:,1),Routes(:,2),Routes(:,3),'k-');
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',1.5);
set(gca,'xtick',0:10000:100000);
set(gca,'ytick',0:10000:100000);
set(gca,'ztick',0:10000:30000);
%% ����
title('����������Χ�ڿ��Ե����У����','Fontsize',16);
%% �����᷶Χ
axis([0 100000 0, 100000 0 30000])
%% ������label
xlabel('X��');
ylabel('Y��');
zlabel('Z��');
%% ͼ��
legend('�ٽ���','��ʼ��','�յ�','�ɵ����ˮƽУ׼��','�ɵ���Ĵ�ֱУ׼��');

