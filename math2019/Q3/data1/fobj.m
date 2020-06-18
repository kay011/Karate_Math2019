function f=fobj(x,loc,nodetype,nodehealth)

a1 = 25;
a2 = 15;
b1 = 20;
b2 = 25;
ss = 30;
ds = 1e-3;
maxR = 200;

Ind1 = 1;
Ind2 = find(x==size(loc,1));
xr = [1 x(Ind1:Ind2)];


%进行约束检查
Err = [0 0];
Errbad = Err;
flag = 0;
AllDis = 0;
JzC = 0;
ErrFailed = zeros(length(xr),2);
FailedContiunsA = 0;
FailedContiunsB = 0;
failprob = 0;
successprob =1;
for ii=1:length(xr)-1
    %判断转弯半径是否正常
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
    Errbad = Errbad+ds*Dis1;
    %判断误差是否超过范围
    if (max(Err)>ss)
        flag=1;
        break;
    end
        
    %垂直误差校正
    if (nodetype(xr(ii+1))==1)
        JzC = JzC+1;
        ErrFailed(ii,:) = [Errbad(1)>a1 Errbad(2)>a2];
        if (sum(ErrFailed(ii,:))>0)
            failprob=failprob+successprob*0.2;
            successprob = 1-failprob;
        end
        if(Err(1)<a1 && Err(2)<a2)
            Err(1)=0;
            if (nodehealth(xr(ii+1))==1)
                 Errbad = [min(Errbad(1),5) Errbad(2)];
                 FailedContiunsA = FailedContiunsA+1;
            else
                Errbad = [0 Errbad(2)];
                FailedContiunsA = 0;
            end
        end
    %水平误差校正
    elseif (nodetype(xr(ii+1))==2)
         JzC = JzC+1;
         ErrFailed(ii,:) = [Errbad(1)>b1 Errbad(2)>b2];
          if (sum(ErrFailed(ii,:))>0)
              failprob=failprob+successprob*0.2;
              successprob = 1-failprob;
          end
         if(Err(1)<b1 && Err(2)<b2)
            Err(2)=0;
            if (nodehealth(xr(ii+1))==1)
                Errbad = [Errbad(1) min(Errbad(2),5)];
                 FailedContiunsB = FailedContiunsB+1;
            else
                Errbad = [Errbad(1) 0];
                FailedContiunsB = 0;
            end
         end 
    end
    
    %为了简化处理
    %增加约束不允许连续两次失败的情况
    if (FailedContiunsA>=3 || FailedContiunsB>=3)
        flag = 1;
        break;        
    end    
end

if (flag==0)
    f = [AllDis JzC failprob];
else
    f = [inf inf inf];
end


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