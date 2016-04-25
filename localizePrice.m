function MG_out = localizePrice (MG, G)

if G.timespan/MG.timespan >=1
    MG.price.UG_in = reshape( repmat(G.price.UG_in', G.timespan/MG.timespan, 1), [], 1 );
    MG.price.UG_out = reshape( repmat(G.price.UG_out', G.timespan/MG.timespan, 1), [], 1 );
    MG.price.CL_in = reshape( repmat(G.price.CL_in', G.timespan/MG.timespan, 1), [], 1) ;
    MG.price.CL_out = reshape( repmat(G.price.CL_out', G.timespan/MG.timespan, 1), [], 1) ;
else
    error('timespan prob in localizePRICE');
end

MG_out = MG;
end