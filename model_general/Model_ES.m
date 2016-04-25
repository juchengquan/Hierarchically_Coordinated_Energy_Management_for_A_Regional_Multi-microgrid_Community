function output = Model_ES ( type )
switch type
    case 1
        ES.type = 1; 
        ES.name = {'ES_type1'};
        ES.ub = 4;
        ES.lb = -4;
        ES.cap = 8;
        ES.price_in = 0.08;
        ES.price_out = -0.08;
    case 2
        ES.type = 2; 
        ES.name = {'ES_type2'};
        ES.ub = 4;
        ES.lb = -4;
        ES.cap = 12;
        ES.price_in = 0.08;
        ES.price_out = -0.08;
    case 3
        ES.type = 3; 
        ES.name = {'ES_type3'};
        ES.ub = 4;
        ES.lb = -4;
        ES.cap = 12;
        ES.price_in = 0.08;
        ES.price_out = -0.08;
    otherwise
        error('No such ES model!');     
end


output = ES;

end