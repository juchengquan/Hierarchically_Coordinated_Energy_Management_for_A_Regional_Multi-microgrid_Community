value = [];
PV_type2 = L0_type2;
if length(PV_type2) == 24
    PV_type2 = [PV_type2; 0]; % Add a zero at last to form the last hour
    for i = 1:1:size(PV_type2)-1
        value = [value,linspace(PV_type2(i,1), PV_type2(i+1,1), 3)];
        value = value(1:size(value,2)-1);
    end
else
    %error('Wrong in forming L0 values');
    value = PV_type2';
end
L0_data = value';

save('L0_aprt', 'L0_data');