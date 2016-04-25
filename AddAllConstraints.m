function MG_out = AddAllConstraints( MG )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
%% Equality constraints:
%Power balance
MG = Eq_Power( MG );
%Indicator for L1: should meet the operation time intervals
MG = Eq_L1_flg( MG );
%Indicator for L2: should meet the operation time intervals
MG = Eq_L2_flg( MG );
%Indicator for L2: Additional flags ---- starting and ending intervals
MG = Eq_L2_continuous( MG );
MG = Eq_L2_s( MG );
MG = Eq_L2_e( MG );

%% Inequality constraints: A*x<=b
%Re-arrange the variables:
MG = arrange_X_limit( MG );

%ES
if MG.numofES >=1
    MG = Ineq_ES_SOC( MG );
    MG = Ineq_ES_SOC_T( MG );
    MG = Ineq_ES_in( MG ); %Input power of ES
    MG = Ineq_ES_out( MG ); % output power of ES
end

%EV
if MG.numofEV >=1
    MG = Ineq_EV_SOC( MG );
    MG = Ineq_EV_in( MG );  %input of EV
    MG = Ineq_EV_out( MG ); %output of EV
end

% additional constraints for binaries in UG, CL, ES, EV:
MG = Ineq_UG_in( MG );
MG = Ineq_UG_out( MG );
MG = Ineq_CL_in( MG );  %Particularly
MG = Ineq_CL_out( MG ); %Particularly

%% Inequality constraints: lb<=x<=ub
MG = Ineq_X( MG ); 


MG_out = MG;
end

