function MG_out = add_load (MG, loadString,load_type)

%% Define all the loads
load = loadCluster(loadString);
%%
switch load_type
    case 0
        MG.L0.name = [MG.L0.name, {load.name}];
    case 1
        if isempty(MG.L1) ~= 1
            MG.L1.name = [MG.L1.name, {load.name}];
            MG.L1.value = [MG.L1.value, define_avbl_hours(MG, load)];
            MG.L1.avbl_hours = [MG.L1.avbl_hours, load.oper_h*60/MG.timespan];
        else
            MG.L1.name = load.name;
            MG.L1.value = define_avbl_hours(MG, G );
            MG.L1.avbl_hours = load.oper_h*60/MG.timespan;
        end
    case 2
        if isempty(MG.L2) ~=1
            MG.L2.name = [MG.L2.name, {load.name}];
            MG.L2.value = [MG.L2.value, define_avbl_hours(MG, load)];
            MG.L2.avbl_hours = [MG.L2.avbl_hours, load.oper_h*60/MG.timespan];
        else
            MG.L2.name = load.name;
            MG.L2.value = define_avbl_hours(MG, G );
            MG.L2.avbl_hours = load.oper_h*60/MG.timespan;
        end
    otherwise 
        error('Load type is wrong!');
end

MG_out = MG;
end