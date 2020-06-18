function [RA,locrec] = jdfly(loc1,loc2,loc3,R)
%�滮���˶��켣Ϊȷ��B��Բ�ģ���BC���У���A��BԲ���ߣ�Bֱ�ߵ�C

%��������
zz= [loc1-loc2;loc2-loc3;];
zz1=zz(1:2,1:2);
zz2=zz(1:2,3);
zz = -inv(zz1)*zz2;
zz = [zz;1];

%loc1-A,loc2-b,loc3-c
%���뷨��zz��bc��ֱ�ķ�������
vec1 = [loc2-loc3;];
vec2 = [zz';];

aa=[vec1;vec2];
aa1=aa(1:2,1:2);
aa2=aa(1:2,3);
aa = -inv(aa1)*aa2;
aa = [aa;1];
aa=aa'/norm(aa);

%�ҵ�Բ��
yuanxin1 = loc2+aa*R;
yuanxin2 = loc2-aa*R;

%ȷ��Բ����
sample = (0:0.01:2*pi);Lena = length(sample);
ang1 = acos(abs(zz(3))/norm(zz(1:3)));
if (zz(1)<0)
    ang2 = atan(-(zz(2))/(zz(1)));
else
    ang2 = -atan(-(zz(2))/(zz(1)));
end
P = [R*cos(sample)' R*sin(sample)'  zeros(size(sample))'];
dir = [0 1 0];Pr=rot3d(P,[0,0,0],dir,ang1);
dir=[0 0 1];Pr2=rot3d(Pr,[0,0,0],dir,ang2);

Pr21=Pr2+kron(ones(size(sample))',yuanxin1);
Pr22=Pr2+kron(ones(size(sample))',yuanxin2);

[~,Ind1] = min(sum(Pr21-kron(ones(size(sample))',loc2),2).^2);


%�ҵ�A��Բ�ĵ��е�%
Dis11 = sqrt(norm(loc1-yuanxin1)^2-R^2);
Disa = sum((Pr21-kron(ones(size(sample))',loc1)).^2,2).^0.5;
for ii=1:2
    [~,Indzz]=min(abs(Disa-Dis11));
    loc4 = Pr21(Indzz,:);
    vec1=loc4-loc2;
    vec2=loc3-loc2;
    vec3 = loc1-loc2;
    ang1=acos(vec1*vec2'/norm(vec1)/norm(vec2))/pi*180;
    ang11=acos(vec1*vec3'/norm(vec1)/norm(vec3))/pi*180;
    if(ang1>90&& ang11<90)
        break;
    else
        Disa(mod(Indzz+(-10:10)-1,Lena)+1)=Inf;
    end
end
if(ang1<90 || ang11>90)
    [~,Ind1] = min(sum(Pr22-kron(ones(size(sample))',loc2),2).^2);
    Dis12 = sqrt(norm(loc1-yuanxin2)^2-R^2);
    Disa = sum((Pr22-kron(ones(size(sample))',loc1)).^2,2).^0.5;
    for ii=1:2
        [~,Indzz2]=min(abs(Disa-Dis12));
        loc4 = Pr22(Indzz2,:);
        vec1=loc4-loc2;
        vec2=loc3-loc2;
        vec3 = loc1-loc2;
         ang2=acos(vec1*vec2'/norm(vec1)/norm(vec2))/pi*180;
        ang21=acos(vec1*vec3'/norm(vec1)/norm(vec3))/pi*180;
        if(ang2>90&& ang21<90)
            break;
        else
            Disa(mod(Indzz2+(-10:10)-1,Lena)+1)=Inf;
        end
    end
end

if (ang1>90&& ang11<90)
    IndL = abs(Indzz-Ind1);
    if (IndL<Lena/2)
        if (Indzz>Ind1)
            Ind =Indzz:-1:Ind1;
        else
            Ind =Indzz:1:Ind1;
        end
    else
        if  (Indzz>Ind1)
            Ind = mod((Indzz:(Ind1+Lena)-1),Lena)+1;
        else
             Ind = mod((Ind1:(Indzz+Lena)-1),Lena)+1;
             Ind = Ind(end:-1:1);
        end
    end
    RA = Dis11+length(Ind)/Lena*2*pi*R;
    locrec = [loc1;Pr21(Ind,:);];
elseif(ang2>90&& ang21<90)
    IndL = abs(Indzz2-Ind1);
    if (IndL<Lena/2)
        if (Indzz2>Ind1)
            Ind =Indzz2:-1:Ind1;
        else
            Ind =Indzz2:1:Ind1;
        end
    else
        if  (Indzz2>Ind1)
            Ind = mod((Indzz2:(Ind1+Lena)-1),Lena)+1;
        else
             Ind = mod((Ind1:(Indzz2+Lena)-1),Lena)+1;
             Ind = Ind(end:-1:1);
        end
    end
    RA = Dis12+length(Ind)/Lena*2*pi*R;
    locrec = [loc1;Pr22(Ind,:);];
else
    RA = Inf;
    locrec = 0;
end
figure(1);clf;hold on;
plot3(Pr21(:,1),Pr21(:,2),Pr21(:,3),'-r')
plot3(Pr22(:,1),Pr22(:,2),Pr22(:,3),'-b')
plot3(loc1(1),loc1(2),loc1(3),'ko');
plot3(loc2(1),loc2(2),loc2(3),'k>');
plot3(loc3(1),loc3(2),loc3(3),'ko');
locrec2=[locrec;loc3];
plot3(locrec2(:,1),locrec2(:,2),locrec2(:,3),'-m');
legend('Բ1','Բ2','A','B','C','A-B-C');


end


