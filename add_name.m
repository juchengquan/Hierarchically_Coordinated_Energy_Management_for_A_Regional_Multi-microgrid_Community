function MG_out = add_name (MG)
    
MG.nameall =  [{'Time'}];
if MG.numofUG >= 1
    MG.nameall = [MG.nameall , MG.UG.name(1:MG.numofUG) ];
end
if MG.numofCL >= 1
    MG.nameall = [MG.nameall , MG.CL.name(1:MG.numofCL) ];
end
if MG.numofES >= 1
    MG.nameall = [MG.nameall , MG.ES.name(1:MG.numofES) ];
end
if MG.numofEV >= 1 
    MG.nameall = [MG.nameall , MG.EV.name(1:MG.numofEV) ];
end
if MG.numofRE >=1
    MG.nameall = [MG.nameall , MG.RE.name(1:MG.numofRE) ];
end
if MG.numofL0 >=1
    MG.nameall = [MG.nameall , MG.L0.name(1:MG.numofL0) ];
end
if MG.numofL1 >=1
    MG.nameall = [MG.nameall , MG.L1.name(1:MG.numofL1) ];
end
if MG.numofL2 >=1
    MG.nameall = [MG.nameall , MG.L2.name(1:MG.numofL2) ];
end

MG_out = MG;
end