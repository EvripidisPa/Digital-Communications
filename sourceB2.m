%Εξωτερική Πηγή Β με δεύτερης τάξης επέκταση πηγής Α.

clear
clc


pA = [8.167/100,1.492/100,2.782/100,4.253/100,12.702/100,2.228/100,2.015/100,6.094/100,6.966/100,0.153/100,0.772/100,4.025/100,2.406/100,6.749/100,7.507/100,1.929/100,0.095/100,5.987/100,6.327/100,9.056/100,2.758/100,0.978/100,2.361/100,0.150/100,1.974/100,0.074/100];

alphabetA = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];

first  = combnk(alphabet,2);
second = fliplr(combnk(alphabet,2));
alphabetA = [first;second];

for i  = 1:26
    alphabetA = [alphabetA ;[i,i]];
end

%new possibilities vector
newp = zeros(length(alphabetA),1);

for i=1:length(alphabetA)
    newp(i) = pA (alphabetA(i,1)) * pA(alphabetA(i,2));
end
pA = newp';

%----------------- p for source B too --------------%

fileID = fopen('kwords.txt','r');
formatSpec = '%s';
A = fscanf(fileID,formatSpec);
fclose(fileID);
[~,n] = size(A);
B = unique(A)
DP = cell(length(B),2);

for i = 1:length(B)
	DP{i,1} = B(1,i);
	DP{i,2} = count(A,B(1,i));
end
s_p = sum(cellfun(@double,DP(:,2)))

for i = 1:length(B)
	DP{i,2} = DP{i,2} ./ s_p;
end

pB = cell2mat(DP(:,2));
alphabetB = DP(:,1);

first  = combnk(alphabetB,2);
second = fliplr(combnk(alphabetB,2));
alphabetB = [first;second];
for i  = a:z
    alphabetB = [alphabetB ;[i,i]];
end

%new possibilities vector
newp = zeros(length(alphabetB),1);

for i=1:length(alphabet)
    newp(i) = pB (alphabetB(i,1)) * pB(alphabetB(i,2));
end
pB = newp';



%------------Calculated the possibilities vectors --------%

%Dictionary creation
[dictA, avglenA] = myHuffmandict (alphabetB, pA);
[dictB, avglenB] = myHuffmandict (alphabetB, pB);

%we want sig/input in cell array
sig = cellstr(A');

%Encoding
[compA,code_lenA] = myHuffmanenco (sig,dictA);
[compB,code_lenB] = myHuffmanenco (sig,dictB);
%where code_len is the number of binary elements needed.
disp('Coded Messages in Binary');
compA
compB

%Decoding
[dsigA] = myHuffmandeco(compA, dictA);
[dsigB] = myHuffmandeco(compP, dictB);
disp('Decoded Message');
cell2mat(dsigA)'
cell2mat(dsigB)'

%check if sig* and dsig* match
equalA = isequal(sig,dsigA)
equalB = isequal(sig,dsigB)

disp('Average code lengths');
avglenA
avglenB

entropyA=0;
for i=1:length(pA)
    entropyA = entropyA + pA(i)*log2(1./pA(i));
end

entropyB=0;
for i=1:length(pB)
    entropyB = entropyB + pB(i)*log2(1./pB(i));
end

disp('Entropy for pA is :');
entropyA

disp('Entropy for pB is :');
entropyB

disp('Efficiency for pA :');
avglenA/entropyA

disp('Efficiency for pB :');
avglenB/entropyB

disp('Complete')
