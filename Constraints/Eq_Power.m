function MG_out = Eq_Power ( MG )
%EQ_CONSTRAINTS Summary of this function goes here
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

numofRows = MG.horizon;
%UG:
Aeq_UG_in  = repmat(eye(numofRows), 1, MG.numofUG);
Aeq_UG_out = repmat(eye(numofRows), 1, MG.numofUG);
Aeq_UG_flg = repmat(zeros(numofRows), 1, MG.numofUG);
%CL:
Aeq_CL_in  = repmat(eye(numofRows), 1, MG.numofCL);
Aeq_CL_out = repmat(eye(numofRows), 1, MG.numofCL);
Aeq_CL_flg = repmat(zeros(numofRows), 1, MG.numofCL);
%ES: 
Aeq_ES_in  = repmat(eye(numofRows), 1, MG.numofES);
Aeq_ES_out = repmat(eye(numofRows), 1, MG.numofES);
Aeq_ES_flg = repmat(zeros(numofRows), 1, MG.numofES);
%EV: 
Aeq_EV_in  = repmat(eye(numofRows), 1, MG.numofEV);
Aeq_EV_out = repmat(eye(numofRows), 1, MG.numofEV);
Aeq_EV_flg = repmat(zeros(numofRows), 1, MG.numofEV);
%RE: (flg)
Aeq_RE_in  = repmat(zeros(numofRows), 1, MG.numofRE);
for i = 1:1:MG.numofRE
	Aeq_RE_in(:,numofRows*(i-1)+1:numofRows*i) = diag( MG.RE.value(1:MG.horizon,i) );
end
%Load0: (flg)
Aeq_L0_in  = repmat(zeros(numofRows), 1, MG.numofL0);
for i = 1:1:MG.numofL0
    Aeq_L0_in(:,numofRows*(i-1)+1:numofRows*i) = diag( MG.L0.value(1:MG.horizon,i) );
end
%Load1: (flg)
Aeq_L1_in  = repmat(zeros(MG.horizon), 1, MG.numofL1);
for i = 1:1:MG.numofL1
    Aeq_L1_in(:,MG.horizon*(i-1)+1:MG.horizon*i) = diag( MG.L1.value(1:MG.horizon,i) );
end
%Load2: (flg)
Aeq_L2_in  = repmat(zeros(numofRows), 1, MG.numofL2);
for i = 1:1:MG.numofL2
    Aeq_L2_in(:,numofRows*(i-1)+1:numofRows*i) = diag( MG.L2.value(1:MG.horizon,i) );
end
%Load2: (flg_s)(flg_e)
Aeq_L2_flg_s = zeros(numofRows, MG.numofL2*(MG.horizon+1));
Aeq_L2_flg_e = zeros(numofRows, MG.numofL2*(MG.horizon+1));


%Total Power balance
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

beq = zeros(numofRows, 1);

MG.Aeq.power = Aeq;
MG.beq.power = beq;

MG.Aeq.all = [ MG.Aeq.all; Aeq ];
MG.beq.all = [ MG.beq.all; beq ];

%clear Aeq_ad_UG Aeq_ad_CL Aeq_ad_ES Aeq_ad_RE_ind Aeq_ad_L0_ind Aeq_ad_L1_ind Aeq_ad_L2_ind;
%Power ends
MG_out = MG;
end

