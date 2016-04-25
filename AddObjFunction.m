function MG_out =  AddObjFunction( MG ,G)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here

MG = localizePrice (MG, G);

MG.f = [];
if MG.numofUG >= 1
    MG.f = [MG.f , MG.price.UG_in', MG.price.UG_out', zeros(1,MG.horizon*MG.numofUG) ];
end
if MG.numofCL >= 1
    MG.f = [MG.f , MG.price.CL_in', MG.price.CL_out', zeros(1,MG.horizon*MG.numofCL) ];
end
if MG.numofES >= 1
    MG.f = [MG.f , MG.ES.price_in', MG.ES.price_out', zeros(1,MG.horizon*MG.numofES) ];
end
if MG.numofEV >= 1 
    MG.f = [MG.f , MG.EV.price_in', MG.EV.price_out', zeros(1,MG.horizon*MG.numofEV) ];
end

MG.f = [MG.f, ...
        zeros(1,MG.horizon*MG.numofRE), ...
        zeros(1,MG.horizon*MG.numofL0), ...
        zeros(1,MG.horizon*MG.numofL1), ...
        zeros(1,MG.horizon*MG.numofL2), zeros(1, MG.numofL2*(MG.horizon+1)), zeros(1, MG.numofL2*(MG.horizon+1)) ] ...
        .*MG.timespan/60 ;

MG_out = MG;
end
