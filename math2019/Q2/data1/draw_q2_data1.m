clear;clc;
%% ��ͼ
%% ���ݼ���
% ��ȡ����У׼��
point_0 = xlsread('0.xlsx'); % ˮƽУ׼��
point_1 = xlsread('1.xlsx'); % ��ֱУ׼��

% ����ѡȡ��У׼��
load('data1_paths.mat');
%% ��ͼ����
% 0 ����ˮƽ���У׼�㣬�û�ɫ��ʾ
% 1 ����ֱ���У׼�㣬����ɫ��ʾ
figure();
%% ɢ��ͼ
scatter3(point_0(:,1),point_0(:,2),point_0(:,3),'b.');
hold on;
scatter3(point_1(:,1),point_1(:,2),point_1(:,3),'y.');
hold on;
% ��ʼ��A
Point_A = [0.00, 50000.00, 5000.00];
scatter3(Point_A(1),Point_A(2),Point_A(3),'ro');
hold on;
% �յ�B
Point_B = [100000.00, 59652.34, 5022.00];
scatter3(100000.00,59652.34,5022.00,'mo');
hold on;
scatter3(arr_res(:,1),arr_res(:,2),arr_res(:,3),'.');
hold on;
%% ����ͼ
Routes = [Point_A;arr_res(:,1:3);Point_B];
%plot3(Routes(:,1),Routes(:,2),Routes(:,3),'k-');
%% ����2��ƽ��
smoothFunc3(Routes);
%% 
set(findobj(get(gca,'Children'),'LineWidth',0.5),'LineWidth',2);
set(gca,'xtick',0:10000:100000);
set(gca,'ytick',0:10000:100000);
set(gca,'ztick',0:10000:30000);
%% ����
title('�����������滮');
%% �����᷶Χ
axis([0 100000 0, 100000 0 30000])
%% ������label
xlabel('X��');
ylabel('Y��');
zlabel('Z��');
%% ͼ��
legend('��ֱУ׼��','ˮƽУ׼��','��ʼ��','�յ�','��ѡ������','����ֱ��·��','��������·��');

