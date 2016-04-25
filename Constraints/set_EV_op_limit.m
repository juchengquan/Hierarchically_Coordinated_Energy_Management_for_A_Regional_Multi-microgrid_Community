function MG_out = set_EV_op_limit (MG)

MG.ub.EV_in = [];
MG.lb.EV_out = [];
flg_reserve = MG.EV.flag;

i = 1;
for t = 0: 1*MG.timespan/60 :MG.hours
    if t>= MG.EV.avbl_h(i) && t < MG.EV.avbl_h(i+1)
        MG.ub.EV_in = [MG.ub.EV_in; (MG.EV.flag==1)];
        MG.lb.EV_out = [ MG.lb.EV_out; (MG.EV.flag==1)];
    else
        MG.ub.EV_in = [MG.ub.EV_in; (MG.EV.flag~=1)];
        MG.lb.EV_out = [ MG.lb.EV_out; (MG.EV.flag~=1)];
        i = i+1;
        MG.EV.flag = (MG.EV.flag~=1);
    end
end

MG.ub.EV_in(size(MG.ub.EV_in, 1)) = [];
MG.ub.EV_in = MG.ub.EV_in .* MG.EV.ub;

MG.lb.EV_out(size(MG.lb.EV_out, 1)) = [];
MG.lb.EV_out = MG.lb.EV_out .* MG.EV.lb;

MG.EV.flag = flg_reserve;

MG.lb.EV_in = zeros(MG.horizon*MG.numofEV, 1);
MG.ub.EV_out = zeros(MG.horizon*MG.numofEV, 1);
MG_out = MG;

end