function [output1, output2, output3, output4] = make_pairing( W_input, MG_out, MG_sig, MG_pair_input)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

row = size(W_input, 1);

%determine the min in each row of W;
[~, pos_row] = min(W_input, [], 2);
%eliminate the un-participated MG in W:
for i = 1:1:row
   if MG_sig(i) == 0
       pos_row(i) = -1;
   end     
end

%select the pairing row:
pos_row_temp = pos_row;
pair_MG = [];
for i = 1:row
   if pos_row_temp(i) == -1
       %do nothing
   elseif pos_row_temp( pos_row_temp(i) ) == i
       pair_MG = [pair_MG;[i, pos_row_temp(i)]];
       temp = pos_row_temp(i);
       pos_row_temp(i) = -1;
       pos_row_temp( temp ) = -1; 
       clear temp;
   end
end


%determine the output exchange matrix and pairing index
MG_pair_output = MG_pair_input;
for i = 1:size(pair_MG, 1)
    if abs(MG_out(pair_MG(i,1))) >  abs(MG_out(pair_MG(i,2)))
        W_input = clear_out(W_input, pair_MG(i,2)); %clear the matrix;
        MG_sig(pair_MG(i,2)) = 0;
        %
        MG_pair_output(pair_MG(i,2), pair_MG(i,1)) = MG_out(pair_MG(i,2));
        MG_pair_output(pair_MG(i,1), pair_MG(i,2)) = -MG_out(pair_MG(i,2));
        MG_out(pair_MG(i,1)) = MG_out(pair_MG(i,1))+ MG_out(pair_MG(i,2));
        MG_out(pair_MG(i,2)) = 0;
    elseif abs(MG_out(pair_MG(i,1))) <  abs(MG_out(pair_MG(i,2)))
        W_input = clear_out(W_input, pair_MG(i,1));
        MG_sig(pair_MG(i,1)) = 0;
        %
        MG_pair_output(pair_MG(i,1), pair_MG(i,2)) = MG_out(pair_MG(i,1));
        MG_pair_output(pair_MG(i,2), pair_MG(i,1)) = -MG_out(pair_MG(i,1));
        MG_out(pair_MG(i,2)) = MG_out(pair_MG(i,1))+ MG_out(pair_MG(i,2));
        MG_out(pair_MG(i,1)) = 0;
    else
        W_input = clear_out(W_input, pair_MG(i,2));
        W_input = clear_out(W_input, pair_MG(i,1));
        MG_sig(pair_MG(i,1)) = 0;
        MG_sig(pair_MG(i,2)) = 0;
        MG_pair_output(pair_MG(i,1), pair_MG(i,2)) = MG_out(pair_MG(i,1));
        MG_pair_output(pair_MG(i,2), pair_MG(i,1)) = MG_out(pair_MG(i,2));
        MG_out(pair_MG(i,2)) = 0;
        MG_out(pair_MG(i,1)) = 0;
    end
end

output1 = W_input;
output2 = MG_out;
output3 = MG_sig;
output4 = MG_pair_output;
end

