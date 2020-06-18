function f  = genetic_operator(parent_chromosome, M, V, obj,LocDis,MaxR)

%% function f  = genetic_operator(parent_chromosome, M, V, mu, mum, l_limit, u_limit)
%
% This function is utilized to produce offsprings from parent chromosomes.
% The genetic operators corssover and mutation which are carried out with
% slight modifications from the original design. For more information read
% the document enclosed.
%
% parent_chromosome - the set of selected chromosomes.
% M - number of objective functions
% V - number of decision varaiables
% mu - distribution index for crossover (read the enlcosed pdf file)
% mum - distribution index for mutation (read the enclosed pdf file)
% l_limit - a vector of lower limit for the corresponding decsion variables
% u_limit - a vector of upper limit for the corresponding decsion variables


[N,m] = size(parent_chromosome);

clear m
p = 1;
% Flags used to set if crossover and mutation were actually performed.
was_crossover = 0;
was_mutation = 0;
for i = 1 : N
    % With 90 % probability perform crossover
    if rand(1) < 0.7
        % Initialize the children to be null vector.
        child_1 = [];
        child_2 = [];
        % Select the first parent
        parent_1 = round(N*rand(1));
        if parent_1 < 1
            parent_1 = 1;
        end
        % Select the second parent
        parent_2 = round(N*rand(1));
        if parent_2 < 1
            parent_2 = 1;
        end
        % Make sure both the parents are not the same.
        count=1;
        while isequal(parent_chromosome(parent_1,:),parent_chromosome(parent_2,:)) && count<10
            parent_2 = round(N*rand(1));
            if parent_2 < 1
                parent_2 = 1;
            end
            count=count+1;
        end
        if (count>10)
            parent_1 = parent_chromosome(parent_1,:);
            parent_2 = parent_chromosome(parent_2,:);
            child_1 = parent_1;
            child_2 = parent_2;
             was_crossover = 1;
            was_mutation = 0;
            continue;
        end
        % Get the chromosome information for each randomnly selected
        % parents
        parent_1 = parent_chromosome(parent_1,:);
        parent_2 = parent_chromosome(parent_2,:);
        % Perform corssover for each decision variable in the chromosome.
        % phin = child_3(1:M2*N2);phin=reshape(phin,M2,N2);        
        Ind1 = parent_1(parent_1(1:V)~=0);Ind1=Ind1(2:end-1);
        Ind2 = parent_2(parent_2(1:V)~=0);Ind2=Ind2(2:end-1);
        [Ind1,Ind2]=meshgrid(Ind1,Ind2);
        Ind1 =Ind1(:);
        Ind2 =Ind2(:);
        Val = (Ind1-1)*(V+1)+Ind2;
        LocDis2 = LocDis(Val);
        Ind3 = find(LocDis2<0.25*MaxR);
        zz1= (MaxR./(LocDis2(Ind3)+0.05*MaxR));
        zz=cumsum(zz1)/sum(zz1);
        
        flag = 0;
        for it=1:min(10,length(zz))
            Ind0 = find(rand<zz,1);
            Ind11 = Ind1(Ind3(Ind0));
            Ind12 = Ind2(Ind3(Ind0));
            
            IndP1 = find(parent_1==Ind11);
            IndP2 = find(parent_2==Ind12);
            
            child_1= [parent_1(1:IndP1) parent_2(IndP2+1:V)];
            child_2= [parent_2(1:IndP2) parent_1(IndP1+1:V)];
            
            child_1 = child_1(child_1~=0);
            child_2 = child_2(child_2~=0);
            [child_10]=unique(child_1);
            [child_20]=unique(child_2);
            if (length(child_10)==length(child_1))
                child_1 = [child_1 zeros(1,M-length(child_1))];
                child_1(:,V + 1: M + V) = obj(child_1);
                if (child_1(:,V + 1)~=Inf);
                    flag=1;
                end
            else
                child_1 = parent_1;
            end
            if (length(child_20)==length(child_2))
                child_2 = [child_2 zeros(1,M-length(child_2))];
                child_2(:,V + 1: M + V) = obj(child_2);
                if (child_2(:,V + 1)~=Inf);
                    flag=1;
                end
            else
                child_2 = parent_2;
            end
            if (flag==1)
                break;
            end
        end
        
        if (flag==0)
            child_1 = parent_1;
            child_2 = parent_2;
        end
        % Evaluate the objective function for the offsprings and as before
        % concatenate the offspring chromosome with objective value.
        child_1(:,V + 1: M + V) = obj(child_1);
        child_2(:,V + 1: M + V) = obj(child_2);
        % Set the crossover flag. When crossover is performed two children
        % are generate, while when mutation is performed only only child is
        % generated.
        was_crossover = 1;
        was_mutation = 0;
        % With 10 % probability perform mutation. Mutation is based on
        % polynomial mutation.
    else
        % Select at random the parent.
        parent_3 = round(N*rand(1));
        if parent_3 < 1
            parent_3 = 1;
        end
        
        for it=1:10
            % Get the chromosome information for the randomnly selected parent.
            child_3 = parent_chromosome(parent_3,:);
            % Perform mutation on eact element of the selected parent.
            M2 = find(child_3(1:V)==0,1)-2;
            IndSel(1) = randi([1 M2],1,1);
            if (rand<0.5)
                IndSel(2) = min(ceil(IndSel(1)+rand*10),M2);
                IndSel2 = IndSel([2 1]);
                child_3(IndSel)=child_3(IndSel2);
            else
                child_3(IndSel(1))=[];
                child_3(V)=0;
            end
            child_3(:,V + 1: M + V) = obj(child_3);
            if (child_3(:,V + 1)~=Inf);
                break;
            end            
        end
        if (child_3(:,V + 1)==Inf)
             child_3 = parent_chromosome(parent_3,:);
        end
        % Evaluate the objective function for the offspring and as before
        % concatenate the offspring chromosome with objective value.
        child_3(:,V + 1: M + V) = obj(child_3);
        % Set the mutation flag
        was_mutation = 1;
        was_crossover = 0;
    end
    % Keep proper count and appropriately fill the child variable with all
    % the generated children for the particular generation.
    if was_crossover
        child(p,:) = child_1(1,1 : M + V);
        child(p+1,:) = child_2(1,1 : M + V);
        was_cossover = 0;
        p = p + 2;
    elseif was_mutation
        child(p,:) = child_3(1,1 : M + V);
        was_mutation = 0;
        p = p + 1;
    end
end
f = child;
