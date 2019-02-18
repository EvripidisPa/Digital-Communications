%Εξωτερική Πηγή A

clear
clc

p = [8.167/100,1.492/100,2.782/100,4.253/100,12.702/100,2.228/100,2.015/100,6.094/100,6.966/100,0.153/100,0.772/100,4.025/100,2.406/100,6.749/100,7.507/100,1.929/100,0.095/100,5.987/100,6.327/100,9.056/100,2.758/100,0.978/100,2.361/100,0.150/100,1.974/100,0.074/100];
alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];

%s = 'abcdefghijklmnopqrstuvwxyz';
%find number of random characters to choose from
%numRands = length(s); 
%specify length of random string to generate
%sLength = 10000;
disp('Random letters created:');
%generate random string
%sourceA = s(ceil(rand(1,sLength)*numRands))
randsrc_ = alphabet( randsrc( 1, 10000, [1:length(p); p] );
sourceA = randsrc_;

%----------------- now for source B --------------------%
fileID = fopen('kwords.txt','r');
formatSpec = '%s';

A = fscanf(fileID,formatSpec);
[~,n] = size(A);
B = unique(A)
fclose(fileID);
DP = cell(length(B),1);

for i = 1:length(B)
	DP{i,1} = B(1,i);
	DP{i,2} = p{i};
end
DP = sortrows(DP,[2 1],{'descend'})
symbols = DP(:,1);

%Dictionary creation for srcs
[dictA, avglenA] = myHuffmandict (alphabet, p);
[dictA, avglenB] = myHuffmandict (symbols, p);

%we want sig/input in cell array
sigA = cellstr(sourceA');
sigB = cellstr(A');

%Encoding
[compA,code_lenA] = myHuffmanenco (sigA,dictA);
[compB,code_lenB] = myHuffmanenco (sigB,dictB);
%where code_len is the number of binary elements needed.
disp('Coded Messages in Binary');
compA
compB

%Decoding
[dsigA] = myHuffmandeco(compA, dictA);
[dsigB] = myHuffmandeco(compB, dictB);
disp('Decoded Messages');
cell2mat(dsigA)'
cell2mat(dsigB)'

%check if sig* and dsig* match
equalA = isequal(sigA,dsigA)
equalB = isequal(sigB,dsigB)

disp('Average code lengths');
avglenA
avglenB

entropy=0;
for i=1:length(p)
    entropy=entropy+p(i)*log2(1./p(i));
end

disp('Entropy is :');
entropy

disp('Efficiency for sourceA :');
avglenA./entropy

disp('Efficiency for sourceB :');
avglenB./entropy

disp('Complete')
