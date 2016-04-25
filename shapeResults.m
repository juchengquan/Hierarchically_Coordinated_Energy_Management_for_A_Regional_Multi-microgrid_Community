function MG_out  = shapeResults( MG )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%UG: 
r_UG = reshape( MG.x( 1 : MG.horizon*(2*MG.numofUG) ), [], 2);
r_UG = sum(r_UG, 2);
r_UG = reshape( r_UG, [], MG.numofUG );
%CL:
r_CL = reshape(MG.x( MG.horizon*(3*MG.numofUG)+1 : MG.horizon*(3*MG.numofUG+2*MG.numofCL) ), [], 2);
r_CL = sum(r_CL, 2);
r_CL = reshape( r_CL, [], MG.numofCL );
%ES:
r_ES = reshape( MG.x( MG.horizon*(3*MG.numofUG+3*MG.numofCL)+1 : MG.horizon*(3*MG.numofUG+3*MG.numofCL+2*MG.numofES) ), [], 2);
r_ES = sum(r_ES, 2);
r_ES = reshape( r_ES, [], MG.numofES );
%EV:
r_EV = reshape( MG.x( MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES)+1 : MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+2*MG.numofEV) ), [], 2);
r_EV = sum(r_EV, 2);
r_EV = reshape( r_EV, [], MG.numofEV );
%RE:
r_RE = MG.RE.value(1 : MG.horizon, 1:MG.numofRE);
%L0:
r_L0 = MG.L0.value(1 : MG.horizon, 1:MG.numofL0);
%L1:
r_L1 = reshape( MG.x(  MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV+MG.numofRE+MG.numofL0)+1 : ...
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV+MG.numofRE+MG.numofL0+MG.numofL1) ), [], MG.numofL1);
if isempty(r_L1) ==0
    r_L1 = r_L1 .* MG.L1.value(1 : MG.horizon, 1:MG.numofL1);
end
%L2:
r_L2 =  reshape( MG.x( MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV+MG.numofRE+MG.numofL0+MG.numofL1)+1 : ...
    MG.horizon*(3*MG.numofUG+3*MG.numofCL+3*MG.numofES+3*MG.numofEV+MG.numofRE+MG.numofL0+MG.numofL1+MG.numofL2) ), [], MG.numofL2);
if isempty(r_L2) ==0
    r_L2 = r_L2 .* MG.L2.value(1 : MG.horizon, 1:MG.numofL2);
end

MG.result = [r_UG, r_CL, r_ES, r_EV, r_RE, r_L0, r_L1, r_L2 ];
MG_out = MG;
end

