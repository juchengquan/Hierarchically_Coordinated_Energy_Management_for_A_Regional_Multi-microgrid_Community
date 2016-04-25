function load_out = loadCluster(string)

switch string
    case 'dish_washer'
        %load_out.ID = 1;
        load_out.name = 'dish_washer';
        load_out.avbl_h = [0,4,9,11,14,17,20,24];
        load_out.oper_h = 1;
        load_out.flag = 1;
        load_out.power = -1;
        %load_out.type = 1;
    case 'washing_machine'
        load_out.name = 'washing_machine';
        load_out.avbl_h = [0,19,23,24];
        load_out.oper_h = 1;
        load_out.flag = 1;
        load_out.power = -0.7;
        %load_out.type = 1;
    case 'vacuum_cleaner'
        load_out.name = 'vacuum_cleaner';
        load_out.avbl_h = [0,1,2,4,6,24];
        load_out.oper_h = 4;
        load_out.flag = 1;
        load_out.power = -0.6;
        %load_out.type = 1;  
    case 'toaster'
        load_out.name = 'toaster';
        load_out.avbl_h = [0 7 9 24];
        load_out.oper_h = 15/60;
        load_out.flag = 0;
        load_out.power = -1.2;
        %load_out.type = 2;
    case 'air_conditioner'
        load_out.name = 'air_conditioner';
        load_out.avbl_h = [0 7 18 24];
        load_out.oper_h = 3;
        load_out.flag = 1;
        load_out.power = -1.16;    
    case 'lighting'
        load_out.name = 'lighting';
        load_out.avbl_h = [0 6, 7 18, 23.5 24];
        load_out.oper_h = 5;
        load_out.flag = 0;
        load_out.power = -1.16;
    case 'oven'
        load_out.name = 'oven';
        load_out.avbl_h = [0 11, 13 24];
        load_out.oper_h = 0.5;
        load_out.flag = 0;
        load_out.power = -1.16;
    otherwise
        error('No such load!')
end


end