function output = gen_MG_data(numofMG, typeMG, caseMG)

hours = 24;
switch typeMG
    case 1 % household
        timespan = 5;
        horizon = hours *60 /timespan;
    case 2 %apartment
        timespan = 5;
        horizon = hours *60 /timespan;
    case 3 % RES station
        timespan = 5;
        horizon = hours *60 /timespan;
    otherwise
        error('in gen_MG_data');
end

%% ES
switch typeMG
    case {1,2,3}
        % lower/upper %0.1-0.2 %0.8-0.9
        ES_lu_s = [ 0.1, 0.8 ];
        ES_lu_var = [ 0.1, 0.1 ];
        % begin/end %0.4-0.6 %0.3-0.8
        ES_be_s = [ 0.4, 0.3 ];
        ES_be_var = [ 0.2, 0.5];
        %
        Gdata.ES.SOC_range = repmat (ES_lu_var, numofMG, 1) .* rand(numofMG, 2) + repmat(ES_lu_s, numofMG, 1);
        Gdata.ES.SOC_ST = repmat( ES_be_var , numofMG, 1).* rand(numofMG, 2) + repmat(ES_be_s, numofMG, 1);
    otherwise
        error('in gen_MG_data');
end
clear  ES_lu_s  ES_lu_var ES_be_s ES_be_var;

%% EV
switch typeMG
    case 1
        % lower/upper %0.1-0.2 %0.8-0.9
        EV_lu_s = [ 0.1, 0.8];
        EV_lu_var = [ 0.1, 0.1 ];
        %
        EV_avbl_h_s = [ 6, 17 ];
        EV_avbl_h_var = [4 4]; 
        % departure/arrival
        EV_da_s = [0.4 0.6 0.2 0.4];
        EV_da_var = [0.2 0.2 0.2 0.2];
        %
        Gdata.EV.SOC_range = repmat (EV_lu_var, numofMG, 1) .* rand(numofMG, 2) + repmat( EV_lu_s, numofMG, 1);
        Gdata.EV.avbl_h = repmat( [0, EV_avbl_h_var, 0], numofMG, 1).*rand(numofMG,4) + repmat([0, EV_avbl_h_s, 24], numofMG, 1);
        Gdata.EV.SOC = repmat (EV_da_var, numofMG, 1) .* rand(numofMG, 4) + repmat( EV_da_s, numofMG, 1);
    case {2,3}
        % no EV
    otherwise
        error('in gen_MG_data');
end
clear EV_lu_s EV_lu_var EV_avbl_h_s EV_avbl_h_var EV_da_s EV_da_var;

%% PV
switch typeMG
    case 1
        PV_var = 0.15;
        load('PV_house'); % introduce 'PV_type1'
    case 2
        PV_var = 0.2;
        load('PV_aprt'); % introduce 'PV_type2'
    case 3
        PV_var = 0.2;
        load('PV_res'); % introduce 'PV_type2'
    otherwise
        error('in gen_MG_data');
end % 'PV_data' has been introduced
value = [];
if length(PV_data) == 48
    PV_data = [PV_data; 0]; % Add a zero at last to form the last hour
    for i = 1:1:size(PV_data)-1
        value = [value,sort(rand(1,30/timespan+1)).*(PV_data(i+1,1)-PV_data(i,1))+repmat(PV_data(i,1),1,30/timespan+1)];
        value = value(1:size(value,2)-1);
    end
else
    error('Wrong in forming RE values');
end
value = repmat(value, numofMG , 1);
% randomize PV
nRE = normrnd(0, PV_var ,numofMG, horizon);
for i = 1:1:numofMG
    value(i,:) = max( value(i,:) + nRE(i,:), 0); 
    for j = 1 : horizon
        if (j>=0 && j<=6/timespan*60)||(j>=18.5/timespan*60 && j<=24/timespan*60)
            value(i,j) = 0;
        end
    end
end
Gdata.PV = value; 
clear PV_var nRE value i j ;


%% L0
switch typeMG
    case 1
        L0_var = 0.1;
        switch caseMG
            case 1
                load('L0_house1');
            case 2
                load('L0_house2');
            otherwise
                error('error in loading load');
        end
    case 2
        L0_var = 0.1;
        load('L0_aprt'); 
    case 3
        L0_var = 0.1;
        load('L0_res'); 
    otherwise
        error('in gen_MG_data');
end
value = [];
if length(L0_data) == 48
    L0_data = [L0_data; L0_data(1,1)]; % Add a zero at last to form the last hour
    for i = 1:1:size(L0_data)-1
        value = [value,sort(rand(1,30/timespan+1)).*(L0_data(i+1,1)-L0_data(i,1))+repmat(L0_data(i,1),1,30/timespan+1)];
        value = value(1:size(value,2)-1);
    end
else
    error('Wrong in forming L0 values');
end
value = repmat(value, numofMG , 1);
% randomize L0
nL0 = normrnd(0, L0_var ,numofMG, horizon);
value = min( value + nL0, 0);
Gdata.L0 = value; 
clear PV_var nRE value i j ;

output = Gdata;
end