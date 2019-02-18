%myHuffmandeco function
%From MATLAB Documentation
%The argument dict is an N-by-2 cell array, 
%where N is the number of distinct possible symbols in the original signal that was encoded as comp. 
%The first column of dict represents the distinct symbols and the second column represents the corresponding codewords. 

dsig = myhuffmandeco(comp,dict)

%note that comp is a character vector
%we shall modify that , and then 
%take advantage of the prefix characteristic of the huffman encoding 

comp = string(comp);
comp = str2mat(comp);
step = 1;
i = 1;
n = length(dict);

while(length(comp >= 1)
	for j=1:n
		if(strcmp(comp(1:step),dict{j,2}))
			dsig{i} = dict {j , 1};
			i = i + 1;
			comp(1:step) = [];
			step = 1;
			break
		end
	end
end