function output = Model_UG ( type )
switch type
    case 1
        UG.type = 1; 
        UG.name = {'Utility'};
        UG.ub = 8;
        UG.lb = -8;
    case 2
        UG.type = 2; 
        UG.name = {'Utility'};
        UG.ub = 30;
        UG.lb = -30;
    case 3
        UG.type = 3; 
        UG.name = {'Utility'};
        UG.ub = 16;
        UG.lb = -16; 
    otherwise
        error('No such UG model!');     
end


output = UG;

end