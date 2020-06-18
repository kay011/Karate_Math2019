function f=fobjprintf(x,loc,nodetype,nodehealth)

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

%进行概率推算
iters = 100;
FailedCount = zeros(1,length(xr));
AllCount = zeros(1,length(xr));


for it=1:iters
    Err = [0 0];
    flag = 0;
    AllDis = 0;
    JzC = 0;
    ErrRecode2 = [];
    ErrRecode1 = [];
    for ii=1:length(xr)-1
        Dis1 = norm(loc(xr(ii),:)-loc(xr(ii+1),:));
        AllDis = AllDis+Dis1;
        Err = Err+ds*Dis1;
        ErrRecode1 = [ErrRecode1;Err];
        %判断误差是否超过范围
        AllCount(ii) =  AllCount(ii)+1;
        if (max(Err)>ss)
            flag=1;
            FailedCount(ii) = FailedCount(ii)+1;
            break;
        end
        
        %垂直误差校正
        if (nodetype(xr(ii+1))==1)
            JzC = JzC+1;
            if(Err(1)<a1 && Err(2)<a2)  
                if (nodehealth(xr(ii+1))==1 && rand<0.2)
                    Err(1)=min(Err(1),5);
                else
                    Err(1)=0;
                end
            end
        %水平误差校正
        elseif (nodetype(xr(ii+1))==2)
            JzC = JzC+1;
            if(Err(1)<b1 && Err(2)<b2)                
                if (nodehealth(xr(ii+1))==1 && rand<0.2)
                    Err(2)=min(Err(2),5);
                else
                    Err(2)=0;
                end
            end
        end
         ErrRecode2 = [ErrRecode2;Err];
    end
end

%进行约束检查
Err = [0 0];
flag = 0;
AllDis = 0;
JzC = 0;

Failporb = FailedCount./AllCount;
FailporbAll = sum(FailedCount)/iters;
fprintf('当前解的失败概率为：%02f% \n',FailporbAll*100);
fprintf('%d:经过校准节点%d,距离%02f，误差[%02f,%02f]\n',0,1,0,Err(1),Err(2));
for ii=1:length(xr)-1
    Dis1 = norm(loc(xr(ii),:)-loc(xr(ii+1),:));
    AllDis = AllDis+Dis1;
    Err = Err+ds*Dis1;
    
    %判断误差是否超过范围
    if (max(Err)>ss)
        flag=1;
        break;
    end
    
    %判断转弯半径是否正常
    if (ii>2)
        R = RCAL(loc(xr(ii-1),:),loc(xr(ii),:),loc(xr(ii+1),:));
        if (R<maxR || isnan(R))
            flag=1;
            break;
        end
    end
    
    
    %垂直误差校正
    if (nodetype(xr(ii+1))==1)
        JzC = JzC+1;
        if(Err(1)<a1 && Err(2)<a2)
            Err(1)=0;
        else
            aa=1;
        end
        %水平误差校正
    elseif (nodetype(xr(ii+1))==2)
        JzC = JzC+1;
        if(Err(1)<b1 && Err(2)<b2)
            Err(2)=0;
        else
            aa=1;
        end
    end
    
    fprintf('%d:经过校准节点%d,距离%1f，误差[%1f,%1f]，出现失败概率%02f\n',ii,xr(ii+1),Dis1,Err(1),Err(2),Failporb(ii));
end

if (flag==0)
    f = [AllDis JzC];
else
    f = [inf inf];
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