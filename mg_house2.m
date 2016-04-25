function MG = mg_house2(numofIndex,Gdata)

%% Type
MG.casetype = 1;
MG.case = 'house_2';

%% number of components:
%{
UG = 1;
CL = 1;
ES = 1;
EV = 1; 
RE = 1;
L0 = 1;
L1 = 4;
L2 = 2;
%}

%%
MG.timespan = 5; % in minutes
MG.hours = 24; % in hours
MG.horizon = MG.hours * 60 / MG.timespan ;

%% UG: (1)
MG.numofUG = 1;
MG.UG = Model_UG( MG.casetype );

%% CL: (1)
MG.numofCL = 1;
MG.CL = Model_CL( MG.casetype );

%% ES: (1)
MG.numofES = 1;
MG.ES = Model_ES( MG.casetype ); %declare the type;
MG.ES.SOC_range = Gdata.ES.SOC_range(numofIndex,:);
MG.ES.SOC_ST = Gdata.ES.SOC_ST(numofIndex,:);

%% EV: (1)
MG.numofEV = 1;
MG.EV = Model_EV( MG.casetype ); %declare the type;
MG.EV.SOC_range = Gdata.EV.SOC_range(numofIndex,:);
MG.EV.SOC = Gdata.EV.SOC(numofIndex, :);
MG.EV.avbl_h =Gdata.EV.avbl_h(numofIndex, :); 
MG.EV.flag = 1;

%% RE: (1)
MG.numofRE = 1;
MG.RE.name = 'PV1';
MG.RE.value = Gdata.PV(numofIndex, :)';

%% L0: (1)
MG.numofL0 = 1;
MG.L0.name = 'base_load';
MG.L0.value = Gdata.L0(numofIndex, :)';

%% L1: (X)
MG.numofL1 = 4;
MG.L1 = struct('value',[],'name',[],'avbl_hours',[]); 
if MG.numofL1 >= 1
    MG = add_load(MG,'washing_machine',1); 
    MG = add_load(MG,'vacuum_cleaner',1); 
    MG = add_load(MG,'air_conditioner',1); 
    MG = add_load(MG,'oven',1); 
end

%% L2: (X)
MG.numofL2 = 2;
MG.L2 = struct('value',[],'name',[],'avbl_hours',[]);
if MG.numofL2 >= 1
    MG = add_load(MG,'dish_washer',2);
    MG = add_load(MG,'toaster',2); 
end

end

