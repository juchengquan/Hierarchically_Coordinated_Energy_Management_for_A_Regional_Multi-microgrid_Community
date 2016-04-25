function output = Model_EV ( type )
switch type
    case 1
        EV.type = 1; 
        EV.name = {'EV_type1'};
        EV.ub = 4;
        EV.lb = -4;
        EV.cap = 8;
        EV.price_in = 0.08;
        EV.price_out = -0.08;
    case 2 
        EV.type = 1; 
        EV.name = {'EV_type1'};
        EV.ub = 4;
        EV.lb = -4;
        EV.cap = 8;
        EV.price_in = 0.08;
        EV.price_out = -0.08;
    otherwise
        error('No such EV model!');     
end

output = EV;

end