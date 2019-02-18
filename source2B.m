%Εξωτερική Πηγή kwords.txt

clear
clc

fileID = fopen('kwords.txt','r');
formatSpec = '%s';

A = fscanf(fileID,formatSpec);

%Removing all the \newline characters and contatenating into a single string.
%We could also use A = importdata('kwords.txt') but our implementation takes better
% advantage of A as it is.

[~,n] = size(A);
B = unique(A)

%B will be our Temp Array
%Initialization of our cell array , 1st column symbols ,2nd column #of occurences

DP = cell(length(B),2);

for i = 1:length(B)
	DP{i,1} = B(1,i);
	DP{i,2} = count(A,B(1,i));
end

DP

%as we can see DP is ordered alpabetically , due to the function "unique"
%lets calculate the {p} and order our cell array in descending order.


s_p = sum(cellfun(@double,DP(:,2)))

%s_p is the size of our input or else size(A,1)

for i = 1:length(B)
	DP{i,2} = DP{i,2} ./ s_p;
end

disp('Checking the sum of possibilities == 1')
out=sum(cellfun(@double,DP(:,2)))

%sorting in descending order
DP = sortrows(DP,[2 1],{'descend'})

disp('Our complete and sorted cell array is..');
DP

%Continue to our encoding.
%Preparing the inputs : symbols cell array , p probability vector.

symbols = DP(:,1);
p = cell2mat(DP(:,2));

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%symbols is a column cell array
%p is a vector of doubles
%both sorted from highest probable symbol to lowest

%Dictionary creation
[dict, avglen] = myHuffmandict (symbols, p);

%we want sig/input in cell array
sig = cellstr(A');

%Encoding
[comp,code_len] = myHuffmanenco (sig,dict);
%where code_len is the number of binary elements needed.
disp('Coded Message in Binary');
comp

%Decoding
[dsig] = myHuffmandeco(comp, dict);
disp('Decoded Message');
cell2mat(dsig)'

%check if sig and dsig match
equal = isequal(sig,dsig)

disp('Average code length');
avglen

entropy=0;
for i=1:length(p)
    entropy=entropy+p(i)*log2(1./p(i));
end

disp('Entropy is :');
entropy

disp('Efficiency :');
avglen./entropy

fclose(fileID);

disp('Complete')
