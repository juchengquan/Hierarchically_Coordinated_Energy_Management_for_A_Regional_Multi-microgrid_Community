clear;clc;
load('G');
G = globalSetting();

%%
MG_Group = initial_MG(G);
%% 
parTime = tic();
for M_index = 1:G.numofMG;
    MG = MG_Group{M_index, 1};
    %% Add All constraints:
    MG = AddAllConstraints( MG );
    %% Objective function
    MG = AddObjFunction( MG, G ); 
    %% Calculation: MILP
    MG.processTime = tic;
    [MG.x,fval,exitflag,output] = intlinprog(MG.f, MG.intcon,...
        MG.A.all, MG.b.all,...
        MG.Aeq.all, MG.beq.all, ...
        MG.lb.all, MG.ub.all);
    MG.processTime = toc( MG.processTime );
    %% Shape the results
    MG = shapeResults( MG );
    MG = cal_SOC(MG);
    %MG = cal_SOC_EV(MG);
    MG.timeframe = ( linspace(0, 24, MG.horizon) )';
    MG.resultTable = array2table([MG.timeframe, MG.result ], ...
        'VariableNames',MG.nameall);

    
    MG_Group{M_index, 1} =formalize2G( MG, G );
    
end
clear MG;
parTime = toc(parTime);

W = cell(G.horizon,1);
W_0 = genLocation(G.numofMG);
for i = 1:G.horizon
    W{i,1} = W_0;
end

MG_out = zeros(G.horizon, G.numofMG);
for i = 1:G.numofMG
    MG_out(:,i) = MG_Group{i,1}.result2G(:,1);
end
%Make pairings
T = G.horizon;
Final = cell(T,1);
for t = 1:1:T
   [~,~,~,Final{t,1}] = make_output(W{t,1},MG_out(t,:) );
end


MG_out_add = zeros(T,G.numofMG);
for t = 1:1:T
    MG_out_add(t,:) =  sum( Final{t,1}, 1);
end

MG_p = MG_out + MG_out_add;
%Total exchanged energy
MG_out_p = sum( (MG_out_add>0).*MG_out_add, 2 );

