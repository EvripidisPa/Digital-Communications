%myHuffmandict function 
%From MATLAB Documentation 
%[dict,avglen] = huffmandict(symbols,p)
% symbols, which lists the distinct signal values that the source produces. 
%It can have the form of a numeric vector, numeric cell array, or alphanumeric cell array. 
%If it is a cell array, it must be either a row or a column.
% p, a probability vector whose kth element is the probability with which the source produces the kth element of symbols. 
%The length of p must equal the length of symbols.


%Notes : We have already modified the inputs, 
%		 symbols to be a alphanumeric cell array of symbols 
% 		 and p as a vector/column of doubles 

function [dict,avglen] = huffmandict(symbols,p)

if ((sum(p)-1.0)> 1e-7)
	error("source probabilities must add up to 1.0");
end

%since it is already sorted in descending possibilities we are starting from the bottom

T = cell(length(symbols),2);
dict = cell(length(symbols),2);

for i=1:length(symbols)
	T{i} = symbols(i);
	dict{i} = symbols(i);
	T{i,2}= p(i);
end
T = sortrows(T , [2 1] , {'descend'});

%---- Make the binary tree using T ------%
i = 1;
m = length(T);
while (m > 1)
	BT{i,1} = T{m,1};						%symbols
	BT{i + 1,1} = T{m - 1,1};
	
	BT{i,2} = strcat(T{m},T{m-1});			%father node
	BT{i + 1,2} = BT{i,2};
	
	BT{i,3} = '0';							%transition code appending
	BT{i + 1,3} = '1';
	
	T{m - 1} = BT{i,2};						%name of new node
	T{m - 1,2} = T {m,2} + T{m - 1,2};		%adding weights
	T(m,:) = [];							%removing last used node
	m = length(T);	
	T = sortrows(T , [2 1] , {'descend'});
	i = i + 2;
end while

% fyi T{1} = root of binary tree 
root = T{1};

% Traversing the tree BT for the codes.

for  i = 1: length(BT) 
	for j = 1 :length(dict)
		if ( strcmp (BT{i,1},dict{j}))
			father = BT{i,2};
			tempcode = BT{i,3};
			node = BT{i,1};
			while (~(strcmp(father,root)))
				idx_f = find(strcmp(BT,father));
				% find returns an ordered! vector of those indices 
				%therefore I shall take the first one , belonging in the first column of BT!
				node = BT{idx_f};
				father = BT{idx_f,2};
				tempcode = strcat(tempcode,BT{idx_f,3});
			end
			dict{j,2} = fliplf(tempcode);
			%the matlab issued implemantation of huffmandeco calls for the codewords 
			%to be in numeric vector format 
		end
	end 
end 

%calculating the avglen of code
n = length(dict);
temp_length = 0;
for i = 1:n
	temp_length = temp_length + length(dict{i,2});
end

avglen = tlng_code./ length(dict);

end