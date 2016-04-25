function MG_out = Eq_L2_flg( MG )
%UNTITLED9 Summary of this function goes here
%   Detailed explanation goes here

%% Variables indices:
%MG.UG_in, MG.UG_out, MG.UG_flg;
%MG.CL_in, MG.CL_out, MG.CL_flg;
%MG.ES_in, MG.ES_out, MG.ES_flg;
%MG.RE_in, (flg)
%MG.L0_out; (flg)
%MG.L1_out; (flg)
%MG.L2_out; (flg)
%MG.L2_ind_s; MG.L2_ind_e;
if MG.numofL2 >=1
    numofRows = MG.numofL2;
    %UG:
    Aeq_UG_in  = zeros(numofRows, MG.horizon*MG.numofUG);
    Aeq_UG_out = zeros(numofRows, MG.horizon*MG.numofUG);
    Aeq_UG_flg = zeros(numofRows, MG.horizon*MG.numofUG);
    %CL:
    Aeq_CL_in  = zeros(numofRows, MG.horizon*MG.numofCL);
    Aeq_CL_out = zeros(numofRows, MG.horizon*MG.numofCL);
    Aeq_CL_flg = zeros(numofRows, MG.horizon*MG.numofCL);
    %ES: 
    Aeq_ES_in  = zeros(numofRows, MG.horizon*MG.numofES);
    Aeq_ES_out = zeros(numofRows, MG.horizon*MG.numofES);
    Aeq_ES_flg = zeros(numofRows, MG.horizon*MG.numofES);
    %EV: 
    Aeq_EV_in  = zeros(numofRows, MG.horizon*MG.numofEV);
    Aeq_EV_out = zeros(numofRows, MG.horizon*MG.numofEV);
    Aeq_EV_flg = zeros(numofRows, MG.horizon*MG.numofEV);
    %RE: (flg)
    Aeq_RE_in  = zeros(numofRows, MG.horizon*MG.numofRE);
    %L0: (flg)
    Aeq_L0_in  = zeros(numofRows, MG.horizon*MG.numofL0);
    %L1: (flg)   ----should meet the operation time intervals
    Aeq_L1_in  = zeros(numofRows, MG.horizon*MG.numofL1);
    %L2: (flg)
    Aeq_L2_itl = MG.L2.value(1:MG.horizon, 1:numofRows)<0;
    Aeq_L2_in = [];
    for i = 1:1:numofRows
        Aeq_L2_in = blkdiag(Aeq_L2_in, Aeq_L2_itl(1:MG.horizon,i)');
    end
    %L2: (flg_s)(flg_e)
    Aeq_L2_flg_s = zeros(numofRows, (MG.horizon+1)*MG.numofL2);
    Aeq_L2_flg_e = zeros(numofRows, (MG.horizon+1)*MG.numofL2);

    %Indicator for L2: should meet the operation time intervals


    Aeq = [ ...
        Aeq_UG_in, Aeq_UG_out, Aeq_UG_flg, ...
        Aeq_CL_in, Aeq_CL_out, Aeq_CL_flg, ...
        Aeq_ES_in, Aeq_ES_out, Aeq_ES_flg, ...
        Aeq_EV_in, Aeq_EV_out, Aeq_EV_flg, ...
        Aeq_RE_in, ...
        Aeq_L0_in, ...
        Aeq_L1_in, ...
        Aeq_L2_in, ...
        Aeq_L2_flg_s, Aeq_L2_flg_e ];


    beq = (MG.L2.avbl_hours(1:MG.numofL2))';

    %Indicator for L2 ends2
    MG.Aeq.L2_flg = Aeq;
    MG.beq.L2_flg = beq;

    MG.Aeq.all = [ MG.Aeq.all; Aeq ];
    MG.beq.all = [ MG.beq.all; beq ];
else
end

MG_out = MG;
end

