function MG_out = formalize2G( MG, G )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
ratio = G.timespan/MG.timespan;
%ratio = 1;
    if ratio >= 1
        n = size(MG.result, 2);
        pp = [];
        for i = 1:1:n
           pp = [pp, sum(reshape(MG.result(:,i),ratio,[]), 1)'] ;
        end
        pp = pp ./ ratio;
        MG.result2G = pp;

        MG_out = MG;
    else
        error('error formalize2G');
    end 
end

