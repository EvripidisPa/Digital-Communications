%From MATLAB DOCUMENTATION 
%sig can have the form of a numeric vector, numeric cell array, or alphanumeric cell array. 
%If sig is a cell array, it must be either a row or a column.
%dict is an N-by-2 cell array, where N is the number of distinct possible symbols to be encoded.
% We are only implementing the cell array case!

%Input evaluation
function [comp,code_len] = myHuffmanenco(sig,dict)
if ( nargin < 2 || strcmp(class(dict),"cell")~=1 )
	error('usage: myhuffmanenco(sig,dict)');
end

% Given than sig is an alphanumeric cell array
% lets say the 5th codeword dict{5,1},its code is gonna be dict{5,2}

% For loop for each cell in the cell array  
dictlen = size(dict,1)
index = 1; 
code_len = 0;
for i = 1 : length(sig) 
    tempcode = []; 
    for j = 1 : dictlen
        if( sig{i} == dict{j,1} ) 
            tempcode = dict{j,2}; 
            break; 
        end 
	end  
	lenCode = length(tempcode);
	comp(index : index + lenCode-1) = tempcode; 
	index = index + lenCode;
	code_len = code_len + numel(num2str(tempcode));
end

%comp will be a vector of doubles,with dimensions such as A's.
end