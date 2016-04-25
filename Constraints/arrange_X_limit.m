function MG_out = arrange_X_limit( MG )
%REARRANGE_X This function re-arranges the dicision variables in one array.
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
%%

%% UG
MG.lb.UG_in = zeros(MG.horizon*MG.numofUG, 1);
MG.ub.UG_in = reshape( repmat(MG.UG.ub(1:MG.numofUG), MG.horizon, 1), [], 1 );

MG.lb.UG_out = reshape( repmat(MG.UG.lb(1:MG.numofUG), MG.horizon, 1), [], 1 );
MG.ub.UG_out = zeros(MG.horizon*MG.numofUG, 1);

MG.lb.UG_flg = zeros(MG.horizon*MG.numofUG, 1);
MG.ub.UG_flg =  ones(MG.horizon*MG.numofUG, 1);

%MG.price.UG_in = reshape( MG.price.UG_in, [], 1 );
%MG.price.UG_out = reshape( MG.price.UG_out, [], 1 );
%% CL
MG.lb.CL_in = zeros(MG.horizon*MG.numofCL, 1);
MG.ub.CL_in = reshape( repmat(MG.CL.ub(1:MG.numofCL), MG.horizon, 1), [], 1 );
%MG.ub.CL_in = MG.CL.ub;

MG.lb.CL_out = reshape( repmat(MG.CL.lb(1:MG.numofCL), MG.horizon, 1), [], 1 );
MG.ub.CL_out = zeros(MG.horizon*MG.numofCL, 1);
%MG.lb.CL_out = MG.CL.lb ;

MG.lb.CL_flg = zeros(MG.horizon*MG.numofCL, 1);
MG.ub.CL_flg = ones(MG.horizon*MG.numofCL, 1);
%price
%MG.price.CL_in = reshape( repmat( MG.price.CL_in, 1, MG.numofCL ), [], 1);
%MG.price.CL_out = reshape( repmat( MG.price.CL_out, 1, MG.numofCL ), [], 1);
%% ES
if MG.numofES >=1
MG.lb.ES_in = zeros(MG.horizon*MG.numofES, 1);
MG.ub.ES_in = reshape( repmat(MG.ES.ub(1:MG.numofES), MG.horizon, 1), [], 1 );

MG.lb.ES_out = reshape( repmat(MG.ES.lb(1:MG.numofES), MG.horizon, 1), [], 1 );
MG.ub.ES_out = zeros(MG.horizon*MG.numofES, 1);

MG.lb.ES_flg = zeros(MG.horizon*MG.numofES, 1);
MG.ub.ES_flg = ones(MG.horizon*MG.numofES, 1);
    %price
MG.ES.price_in = reshape( repmat( MG.ES.price_in(1:MG.numofES), MG.horizon, 1 ), [], 1);
MG.ES.price_out = reshape( repmat( MG.ES.price_out(1:MG.numofES), MG.horizon, 1 ), [], 1);
else   
end
%% EV
if MG.numofEV >=1
    MG = set_EV_op_limit(MG);
    MG.EV.price_in = reshape( repmat( MG.EV.price_in(1:MG.numofES), MG.horizon, 1 ), [], 1);
    MG.EV.price_out = reshape( repmat( MG.EV.price_out(1:MG.numofES), MG.horizon, 1 ), [], 1);
else
    %{
    MG.ub.EV_out = [];
    MG.lb.EV_out = [];
    MG.ub.EV_in = [];
    MG.lb.EV_in = [];
    MG.EV.price_in = [];
    MG.EV.price_out = [];
    %}
end
    MG.lb.EV_flg = zeros(MG.horizon*MG.numofEV, 1);
    MG.ub.EV_flg = ones(MG.horizon*MG.numofEV, 1);
    
%% RE flag: should be always 1
MG.lb.RE_flg = reshape(ones(MG.horizon, MG.numofRE), [],1);
MG.ub.RE_flg = reshape(ones(MG.horizon, MG.numofRE), [],1);
%% L0 flag: should be always 1
MG.lb.L0_flg = reshape(ones(MG.horizon, MG.numofL0), [],1);
MG.ub.L0_flg = reshape(ones(MG.horizon, MG.numofL0), [],1);
%% L1 flag
if MG.numofL1 >=1
    MG.lb.L1_flg = reshape(zeros(MG.horizon, MG.numofL1), [],1);
    MG.ub.L1_flg = reshape(MG.L1.value(1:MG.horizon, 1:MG.numofL1)<0, [],1);
end
%% L2 flag 
if MG.numofL2 >=1
    MG.lb.L2_flg = reshape(zeros(MG.horizon, MG.numofL2), [],1);
    MG.ub.L2_flg = reshape(MG.L2.value(1:MG.horizon, 1:MG.numofL2)<0, [],1);
end
%L2_flg_s
MG.lb.L2_flg_s = reshape(zeros(MG.horizon+1, MG.numofL2), [],1);
MG.ub.L2_flg_s = reshape(ones(MG.horizon+1, MG.numofL2), [],1);
%L2_flg_e
MG.lb.L2_flg_e = -reshape(ones(MG.horizon+1, MG.numofL2), [],1);
MG.ub.L2_flg_e = reshape(zeros(MG.horizon+1, MG.numofL2), [],1);

MG_out=MG;
end

