function [flag,leastR]=fobj2old(x,loc,nodetype)

a1 = 25;
a2 = 15;
b1 = 20;
b2 = 25;
ss = 30;
ds = 1e-3;
maxR = 200;

xr = [1 x];

%����Լ�����
Err = [0 0];
flag = 0;
AllDis = 0;
JzC = 0;
for ii=1:length(xr)-1
     if (ii>=2)
        R = RCAL(loc(xr(ii-1),:),loc(xr(ii),:),loc(xr(ii+1),:));
        if (R<maxR || isnan(R))
            flag=1;
            break;
        end
    end
    
    if (ii>=length(xr)-1)
        Dis1 = norm(loc(xr(ii),:)-loc(xr(ii+1),:));
    else
        Dis1 = jdfly2(loc(xr(ii),:),loc(xr(ii+1),:),loc(xr(ii+2),:),maxR);
    end
    
    AllDis = AllDis+Dis1;
    Err = Err+ds*Dis1;
    
    %�ж�����Ƿ񳬹���Χ
    if (max(Err)>ss)
        flag=1;
        break;
    end
    
    %��ֱ���У��
    if (nodetype(xr(ii+1))==1)
        JzC = JzC+1;
        if(Err(1)<a1 && Err(2)<a2)
            Err(1)=0;            
        else
            flag=1;break;
        end
        %ˮƽ���У��
    elseif (nodetype(xr(ii+1))==2)
        JzC = JzC+1;
        if(Err(1)<b1 && Err(2)<b2)
            Err(2)=0;            
        else
            flag=1;break;
        end
    end   
end

leastR1 = min([25 15]-Err)/ds;
leastR2 = min([20 25]-Err)/ds;

leastR = [leastR1 leastR2];
end

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