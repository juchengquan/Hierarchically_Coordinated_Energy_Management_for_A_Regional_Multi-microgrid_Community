function [ output1, output2, output3, output4 ] = make_output( W,MG_out )

for i = 1:size(W,1)
    W(i,i) = 0;
end
%W: weighting coefficient
W = W + diag(10^4*ones(size(W,1), 1));
%MG-sig: energy exchange index in ea
MG_sig = (MG_out>0)-(MG_out<0);

%clear out the unparticipated MG and MGs with same direction of power flow:
for i = 1:1:size(MG_out, 2)
    if MG_sig(i) == 0
        W = clear_out(W, i);
        continue;
    else
        for j = i+1:1:size(MG_out, 2)
            if  MG_sig(i) == MG_sig(j) 
                W = clear_out( W, i, j );
            end
        end
    end
end

MG_pair_input = zeros(size(W));
while (sum(MG_sig>0)~=0 ) & ( sum(MG_sig<0)~=0)
    [W, MG_out, MG_sig, MG_pair_input] = make_pairing(W, MG_out, MG_sig , MG_pair_input);
end

if sum(sum(W ~= 10^4))>=1
    disp('error!');
end

output1 = W;
output2 = MG_out;
output3 = MG_sig;
output4 = MG_pair_input;


end



