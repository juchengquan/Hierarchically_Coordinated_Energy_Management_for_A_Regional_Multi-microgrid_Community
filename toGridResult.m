function MG_out  = toGridResult( MG, G )

ratio = G.timespan/MG.timespan; %now it is >1

MG_out = MG;

[m,n] = size(MG_out.result);
pp = [];
for i = 1:n;
    pp = [pp, sum(reshape(MG_out.result(:,i), 2,[]) , 1 )']
end
MG_out.result2G = pp./ratio;
end