function MG_out = Eq_L2_continuous( MG )
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here

numofRows = (MG.horizon+1)*MG.numofL2;
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
%L1: (flg)
Aeq_L1_in  = zeros(numofRows, MG.horizon*MG.numofL1);
%L2: (flg)
Aeq_L2_in = [];
for i = 1:1:MG.numofL2
    Aeq_L2_in = blkdiag(Aeq_L2_in,  [eye(MG.horizon); zeros(1, MG.horizon)]- [zeros(1, MG.horizon) ;eye(MG.horizon)] );
end
%L2: (flg_s)(flg_e)
Aeq_L2_flg_s = -eye( numofRows );
Aeq_L2_flg_e = -eye( numofRows );


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

beq =  zeros( numofRows , 1);

%
MG.Aeq.L2_flg_cont = Aeq;
MG.beq.L2_flg_cont = beq;

MG.Aeq.all = [ MG.Aeq.all; Aeq ];
MG.beq.all = [ MG.beq.all; beq ];

MG_out = MG;
end

