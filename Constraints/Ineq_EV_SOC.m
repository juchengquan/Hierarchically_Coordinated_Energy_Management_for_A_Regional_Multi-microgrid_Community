function MG_out = Ineq_EV_SOC( MG )
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
flag_reserve = MG.EV.flag;
%EV: 
b_max = [];
b_min = [];
A_EV = [];
i = 1;
for t = 1 : 1 : MG.hours/MG.timespan*60  %Be cautious of the num of intervals
    if t > MG.EV.avbl_h(i)/MG.timespan*60 && t < MG.EV.avbl_h(i+1)/MG.timespan*60  % inside the charging region
        if MG.EV.flag == 1
            b_max = [b_max; MG.EV.SOC_max-MG.EV.SOC(i)];
            b_min = [b_min; MG.EV.SOC(i)-MG.EV.SOC_min]; 
        else
        end
    else % at the boundary:
        if MG.EV.flag == 1
            b_max = [b_max; MG.EV.SOC_max-MG.EV.SOC(i)];
            b_min = [b_min; max(MG.EV.SOC(i)-MG.EV.SOC(i+1), MG.EV.SOC(i)-MG.EV.SOC_min)];
            start_p = ceil(MG.EV.avbl_h(i)*60/MG.timespan);
            end_p = ceil(MG.EV.avbl_h(i+1)*60/MG.timespan);
            rows = end_p - start_p;
            terminal_p = round(MG.EV.avbl_h( size(MG.EV.avbl_h,2) )*60/MG.timespan);
            A_temp = [zeros(rows, start_p), tril(ones( rows, rows )), zeros(rows, terminal_p-end_p)];
            A_EV = [A_EV; A_temp];
            clear start_p end_p rows terminal_p A_temp;
        else
        end
        i = i+1;
        MG.EV.flag = (MG.EV.flag~=1); 
    end
end
A_EV_in  = A_EV;
A_EV_out = A_EV;

numofRows = size(A_EV_in, 1);
A_EV_flg = zeros(numofRows, MG.horizon*MG.numofEV);

%UG:
A_UG_in  = zeros(numofRows, MG.horizon*MG.numofUG);
A_UG_out = zeros(numofRows, MG.horizon*MG.numofUG);
A_UG_flg = zeros(numofRows, MG.horizon*MG.numofUG);
%CL:
A_CL_in  = zeros(numofRows, MG.horizon*MG.numofCL);
A_CL_out = zeros(numofRows, MG.horizon*MG.numofCL);
A_CL_flg = zeros(numofRows, MG.horizon*MG.numofCL);
%ES: 
A_ES_in  = zeros(numofRows, MG.horizon*MG.numofES);
A_ES_out = zeros(numofRows, MG.horizon*MG.numofES);
A_ES_flg = zeros(numofRows, MG.horizon*MG.numofES);

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

if size(A_max, 1) ~= size(b_max, 1)
    error('matrix does not match in \"INEQ_EV_SOC\"');
end


MG.A.EV_SOC_in  = A_min;
MG.A.EV_SOC_out = A_max;
MG.b.EV_SOC_in = b_min;
MG.b.EV_SOC_in = b_max;

MG.A.all = [ MG.A.all; A_min; A_max ];
MG.b.all = [ MG.b.all; b_min; b_max ];
MG.EV.flag = flag_reserve ;
MG_out = MG;
end

