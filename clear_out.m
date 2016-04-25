function output_M = clear_out( input_M, MG_index1, varargin )
%CLEAR_OUT Summary of this function goes here
%   Detailed explanation goes here

    if nargin >=4 || nargin <=1
        error('Please check the input variables in function \"clear_out\".');
    elseif nargin ==3
        %disp('Excute \"clear_out\" for pairing MGs...');
        MG_index2 = varargin{1};
        input_M(MG_index1,MG_index2) = 10^4;
        input_M(MG_index2,MG_index1) = 10^4;
    elseif nargin ==2
        %disp('Excute \"clear_out\" for one MG...'); 
        input_M(MG_index1, :) = 10^4;
        input_M(:, MG_index1) = 10^4;
    end
    output_M = input_M;
end

