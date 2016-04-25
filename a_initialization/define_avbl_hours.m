function output = define_avbl_hours (MG, load)

seq = [];
i = 1;
for t = 0: 1*MG.timespan/60 :MG.hours
    if t>=load.avbl_h(i) && t<load.avbl_h(i+1)
        seq = [seq; (load.flag==1)];
    else
        seq = [seq; (load.flag~=1)];
        i = i+1; 
        load.flag = (load.flag~=1);
    end
end
seq(size(seq, 1))=[];

output = seq.*load.power;
end




