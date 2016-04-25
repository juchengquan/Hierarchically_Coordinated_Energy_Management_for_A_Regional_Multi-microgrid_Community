function MG_out = Ineq_ES_SOC( MG )
%UNTITLED10 Summary of this function goes here
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

numofRows = MG.horizon*MG.numofES;
%ES SOC
A_ES = [];
for i = 1:1:MG.numofES
    A_ES = blkdiag(A_ES, tril(ones(MG.horizon),0));
end

%UG:
A_UG_in  = zeros(numofRows, MG.horizon*MG.numofUG);
A_UG_out = zeros(numofRows, MG.horizon*MG.numofUG);
A_UG_flg = zeros(numofRows, MG.horizon*MG.numofUG);
%CL:
A_CL_in  = zeros(numofRows, MG.horizon*MG.numofCL);
A_CL_out = zeros(numofRows, MG.horizon*MG.numofCL);
A_CL_flg = zeros(numofRows, MG.horizon*MG.numofCL);
%ES: 
A_ES = [];
for i = 1:1:MG.numofES
    A_ES = blkdiag(A_ES, tril(ones(MG.horizon),0));
end
A_ES_in  = A_ES; 
A_ES_out = A_ES; 
A_ES_flg = zeros(numofRows, MG.horizon*MG.numofES);
%EV: 
A_EV_in  = zeros(numofRows, MG.horizon*MG.numofEV);
A_EV_out = zeros(numofRows, MG.horizon*MG.numofEV);
A_EV_flg = zeros(numofRows, MG.horizon*MG.numofEV);
%RE: (flg)
A_RE_in  = zeros(numofRows, MG.horizon*MG.numofRE);
%L0: (flg)
A_L0_in  = zeros(numofRows, MG.horizon*MG.numofL0);
%L1: (flg)
A_L1_in  = zeros(numofRows, MG.horizon*MG.numofL1);
%L2: (flg)
A_L2_in  = zeros(numofRows, MG.horizon*MG.numofL2);
%L2: (flg_s) (flg_e)
A_L2_flg_s = zeros(numofRows, (MG.horizon+1)*MG.numofL2);
A_L2_flg_e = zeros(numofRows, (MG.horizon+1)*MG.numofL2);

A_min = [ ...
    A_UG_in, A_UG_out, A_UG_flg, ...
    A_CL_in, A_CL_out, A_CL_flg, ...
    A_ES_in, A_ES_out, A_ES_flg, ...
    A_EV_in, A_EV_out, A_EV_flg, ...
    A_RE_in, ...
    A_L0_in, ...
    A_L1_in, ...
    A_L2_in, ...
    A_L2_flg_s, A_L2_flg_e ];
A_max = -A_min;

b_min = reshape( repmat(-MG.ES.SOC_min(1:MG.numofES)+MG.ES.SOC_0(1:MG.numofES), MG.horizon, 1), [], 1);
b_max = reshape( repmat( MG.ES.SOC_max(1:MG.numofES)-MG.ES.SOC_0(1:MG.numofES), MG.horizon, 1), [], 1);


MG.A.ES_SOC_in  = A_min;
MG.A.ES_SOC_out = A_max;
MG.b.ES_SOC_in = b_min;
MG.b.ES_SOC_in = b_max;

MG.A.all = [ MG.A.all; A_min; A_max ];
MG.b.all = [ MG.b.all; b_min; b_max ];

MG_out = MG;
end

