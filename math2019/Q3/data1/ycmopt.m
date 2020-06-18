function [chromosome]=ycmopt(obj,obj2,loc,nodetype,MaxR,M,V,gen)

%种群个数
pop = 1000;

%% Initialize the population
% Population is initialized with random values which are within the
%初始化种群
[chromosome,LocDis] = initialize_variables(pop, M, V,obj,obj2,loc,nodetype',MaxR);
%% Sort the initialized population
% Sort the population using non-domination-sort. This returns two columns
chromosome = non_domination_sort_mod(chromosome, M, V);
%% Start the evolution process
% The following are performed in each generation
for i = 1 : gen
    % Select the parents
    % pool - size of the mating pool. It is common to have this to be half the
    %        population size.
    % tour - Tournament size. Original NSGA-II uses a binary tournament
    %        selection, but to see the effect of tournament size this is kept
    %        arbitary, to be choosen by the user.
    pool = round(pop/2);
    tour = 2;
    
    % Selection process
    parent_chromosome = tournament_selection(chromosome, pool, tour);
    
    % Perfrom crossover and Mutation operator
    offspring_chromosome = ...
        genetic_operator(parent_chromosome, ...
        M, V,obj,LocDis,MaxR);
    
    % Intermediate population
    [main_pop,temp] = size(chromosome);
    [offspring_pop,temp] = size(offspring_chromosome);
    
    % temp is a dummy variable.
    clear temp
    % intermediate_chromosome is a concatenation of current population and
    % the offspring population.
    intermediate_chromosome(1:main_pop,:) = chromosome;
    intermediate_chromosome(main_pop + 1 : main_pop + offspring_pop,1 : M+V) = ...
        offspring_chromosome;
    
    % Non-domination-sort of intermediate population
    intermediate_chromosome = ...
        non_domination_sort_mod(intermediate_chromosome, M, V);
    
    % Perform Selection
    chromosome = replace_chromosome(intermediate_chromosome, M, V, pop);
    if ~mod(i,10)
        clc
        fprintf('%d generations completed\n',i);
    end
    
    figure(1);clf;hold on;
    if M == 2
        Ind = find(chromosome(:,V + 3)==1);
        plot(chromosome(Ind,V + 1),chromosome(Ind,V + 2),'ro'); 
        xlabel('距离');
        ylabel('校准次数');
    elseif M == 3
         Ind = find(chromosome(:,V + 4)==1);
        plot3(chromosome(Ind,V + 1),chromosome(Ind,V + 2),chromosome(Ind,V + 3),'ro'); 
        xlabel('距离');
        ylabel('校准次数');
        zlabel('等效失败概率');
    end
    pause(0.1);
    
end

%% Result
% Save the result in ASCII text format.
chromosome = chromosome(Ind,:);
save results chromosome
