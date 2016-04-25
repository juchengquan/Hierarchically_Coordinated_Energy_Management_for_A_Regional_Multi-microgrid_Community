function MG_out = Ineq_X( MG )
%INEQ_X This function defines the boundaries of the decision variables.
%% Variables indices:
%MG.UG_in, MG.UG_out, MG.UG_flg;
%MG.CL_in, MG.CL_out, MG.CL_flg;
%MG.ES_in, MG.ES_out, MG.ES_flg;
%MG.RE_in, (flg)
%MG.L0_out; (flg)
%MG.L1_out; (flg)
%MG.L2_out; (flg)
%MG.L2_ind_s; MG.L2_ind_e;

%% Inequality constraints: lb<=x<=ub

MG.lb.all = [];
MG.ub.all = [];
if MG.numofUG >= 1
    MG.lb.all = [ MG.lb.UG_in; MG.lb.UG_out; MG.lb.UG_flg; ];
    MG.ub.all = [ MG.ub.UG_in; MG.ub.UG_out; MG.ub.UG_flg; ];
end
if MG.numofCL >= 1
	MG.lb.all = [ MG.lb.all; MG.lb.CL_in; MG.lb.CL_out; MG.lb.CL_flg; ];
    MG.ub.all = [ MG.ub.all; MG.ub.CL_in; MG.ub.CL_out; MG.ub.CL_flg; ];
end
if MG.numofES >= 1
    MG.lb.all = [ MG.lb.all; MG.lb.ES_in; MG.lb.ES_out; MG.lb.ES_flg; ];
    MG.ub.all = [ MG.ub.all; MG.ub.ES_in; MG.ub.ES_out; MG.ub.ES_flg; ];
end
if MG.numofEV >= 1 
	MG.lb.all = [ MG.lb.all; MG.lb.EV_in; MG.lb.EV_out; MG.lb.EV_flg; ];
    MG.ub.all = [ MG.ub.all; MG.ub.EV_in; MG.ub.EV_out; MG.ub.EV_flg; ];
end
if MG.numofRE >=1
    MG.lb.all = [ MG.lb.all; MG.lb.RE_flg; ];
    MG.ub.all = [ MG.ub.all; MG.ub.RE_flg; ];
end
if MG.numofL0 >=1
    MG.lb.all = [ MG.lb.all; MG.lb.L0_flg; ];
    MG.ub.all = [ MG.ub.all; MG.ub.L0_flg; ];
end
if MG.numofL1 >=1
    MG.lb.all = [ MG.lb.all; MG.lb.L1_flg; ];
    MG.ub.all = [ MG.ub.all; MG.ub.L1_flg; ];
end
if MG.numofL2 >=1
    MG.lb.all = [ MG.lb.all; MG.lb.L2_flg; MG.lb.L2_flg_s; MG.lb.L2_flg_e ];
    MG.ub.all = [ MG.ub.all; MG.ub.L2_flg; MG.ub.L2_flg_s; MG.ub.L2_flg_e ];
end


%Total:

MG_out=MG;
end

