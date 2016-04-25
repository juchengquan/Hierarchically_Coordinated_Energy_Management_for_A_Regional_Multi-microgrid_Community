function MG_out = cal_SOC_EV( MG )
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

A_min = MG.A.EV_SOC_in;
A_max = MG.A.EV_SOC_out;

Accu_SOC = reshape([A_min; A_max]*MG.x,MG.horizon,2*MG.numofEV);

MG.SOC_List = ( -Accu_SOC( 1:MG.horizon, 1:MG.numofEV)+repmat(MG.ES.SOC_0(1:MG.numofEV), MG.horizon, 1) ) ./ ...
    repmat(MG.ES.cap(1:MG.numofEV), MG.horizon, 1) .* 100 ;
MG.SOC_List = [MG.ES.SOC_0(1:MG.numofEV)./MG.ES.cap(1:MG.numofEV) .*100; MG.SOC_List ] .* MG.timespan/60;



MG_out = MG;
end

