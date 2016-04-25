function output = Model_CL ( type )
CL.type = type;
CL.name = 'Community';
CL.ub = 0;
CL.lb = -0;

switch type
    case 1
    case 2 
    case 3
    otherwise
        error('No such CL model!');     
end

output = CL;
end


