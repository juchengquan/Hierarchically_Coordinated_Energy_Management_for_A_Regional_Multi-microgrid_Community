function MG_Group = initial_MG( G  )
%% Variables indices:
%MG.UG_in, MG.UG_out, MG.UG_flg;
%MG.CL_in, MG.CL_out, MG.CL_flg;
%MG.ES_in, MG.ES_out, MG.ES_flg;
%MG.RE_in, (flg)
%MG.L0_out; (flg)
%MG.L1_out; (flg)
%MG.L2_out; (flg)
%MG.L2_ind_s; MG.L2_ind_e;

%% Components New
MG_Group = cell(G.numofMG,1);
numofIndex = 1;
for i = 1:1:G.t1_h1
    MG_Group{numofIndex} = mg_house1( i, G.data.t1_h1);
    numofIndex = numofIndex + 1;
end
for i = 1:1:G.t1_h2
    MG_Group{numofIndex} = mg_house2( i, G.data.t1_h2);
    numofIndex = numofIndex + 1;
end
for i = 1:1:G.t2_MG
    MG_Group{numofIndex} = mg_aprt( i, G.data.t2);
    numofIndex = numofIndex + 1;
end
for i = 1:1:G.t3_MG
    MG_Group{numofIndex} = mg_res( i, G.data.t3);
    numofIndex = numofIndex + 1;
end



for i = 1:1:G.numofMG
MG = MG_Group{i,1};
    %% Indicate the intcon:
    MG.intcon = [ 
        MG.horizon*(2*MG.numofUG)+1:MG.horizon*(3*MG.numofUG), ... %UG
        MG.horizon*(3*MG.numofUG+2*MG.numofCL)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL), ... %CL
        MG.horizon*(3*MG.numofUG+3*MG.numofCL+2*MG.numofES)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES), ... %ES
        MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+2*MG.numofEV)+1:MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV), ... %EV
        MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV)+1: ...
        MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV+MG.numofRE+MG.numofL0+MG.numofL1+MG.numofL2)+ ...%RE,L0,L1,L2, and
        MG.numofL2*(MG.horizon+1) + MG.numofL2*(MG.horizon+1) ... %L2_s, L2_e
        ];
    %% Constraint Variables (ititialization of matricies)
    MG.A.all = [];
    MG.b.all = [];
    MG.Aeq.all = [];
    MG.beq.all = [];
    MG.lb = [];
    MG.ub = [];
    
   %% 
    % Aggregate the names
    MG = add_name (MG);

    %Reshape the contraints for ES: SOC to capacity
    MG.ES.SOC_min = MG.ES.SOC_range(1).*MG.ES.cap./MG.timespan.*60;
    MG.ES.SOC_max = MG.ES.SOC_range(2).*MG.ES.cap./MG.timespan.*60;
    MG.ES.SOC_0 = MG.ES.SOC_ST(1).*MG.ES.cap./MG.timespan.*60;
    MG.ES.SOC_T = MG.ES.SOC_ST(2).*MG.ES.cap./MG.timespan.*60;
    if MG.numofEV >=1
    %Reshape the contraints for EV: SOC to capacity
    MG.EV.SOC_min = MG.EV.SOC_range(1).*MG.EV.cap./MG.timespan.*60;
    MG.EV.SOC_max = MG.EV.SOC_range(2).*MG.EV.cap./MG.timespan.*60;
    MG.EV.SOC = MG.EV.SOC.*MG.EV.cap./MG.timespan.*60;
    end

MG_Group{i,1} = MG;
end

end
