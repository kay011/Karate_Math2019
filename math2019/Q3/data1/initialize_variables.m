function [f,LocDis] = initialize_variables(N, M, V,obj,obj2,loc,nodetype,MaxR)



K = M + V;
LocDis = zeros(V+1,V+1);

for ii=1:V+1
    zz1 = loc;
    zz2 = kron(ones(V+1,1),loc(ii,:));
    Dis1 = sum(abs(zz1-zz2).^2,2).^0.5;
    LocDis(:,ii)=Dis1;
end
LocDis2=LocDis;
LocDis(LocDis>MaxR)=Inf;
f = zeros(N,M+V);
%% Initialize each chromosome
% For each chromosome perform the following (N is the population size)
for i = 1 : N
    flagf = 0;
    while (flagf==0)
        Sind = 1;
        TravBuf = [Sind];
        NodeState=zeros(1,V+1);
        flagerr = 0;
        nodetypeprv = 0;
        lestR = [MaxR MaxR];
        while(sum(NodeState)<V && flagerr==0)
            Nind = TravBuf(end);
            NodeState(Nind)=1;
            Neigh00 = find(NodeState==0 & LocDis(Nind,:)<0.95*lestR(1) & nodetype==1 &(LocDis(Nind,:)<0.85*MaxR | LocDis(Nind,:)==min(LocDis(Nind,:))));           
            Neigh01 = find(NodeState==0 & LocDis(Nind,:)<0.95*lestR(2) & nodetype==2 &(LocDis(Nind,:)<0.85*MaxR | LocDis(Nind,:)==min(LocDis(Nind,:))));
            Neigh = union(Neigh00,Neigh01);
            if (length(Neigh)==1)
                TravBuf = [TravBuf Neigh];
                [flag,lestR] =obj2(TravBuf(2:end));
                if (flag==1)
                    flagerr = 1;
                    break;
                end
            elseif (isempty(Neigh))
                break;
            else
                NowDis =  LocDis2(Nind,end);
                NextDis =  LocDis2(Neigh,end);
                
                Ind2 = NextDis<NowDis;
                Neigh2 = Neigh(Ind2);
                if(rand<0.75 && length(Neigh2)>=1)
                    Ind = randi([1 length(Neigh2)]);
                    NewId=Neigh2(Ind);
                else
                    Ind = randi([1 length(Neigh)]);
                    NewId=Neigh(Ind);
                end
                
                flag = 1;
                if (NowDis<MaxR*0.8)
                    TravBufTmp = [TravBuf V+1];
                    flag = obj2(TravBufTmp(2:end));
                end
                
                if (flag==1)
                    TravBufTmp = [TravBuf NewId];
                    [flag,lestR] = obj2(TravBufTmp(2:end));
                    if (flag==1)
                        aa=1;
                    end
                else
                    TravBufOut = TravBufTmp(2:end);
                    flagf = 1;
                    break;
                end
                if (flag==1)
                    flagerr = 1;
                    break;
                else
                    TravBuf = TravBufTmp;
                    TravBufOut = TravBufTmp(2:end);
                end
            end
        end
       
    end
    f(i,1:length(TravBufOut))=TravBufOut;
    f(i,V + 1: K) = obj(f(i,:));
    
end
