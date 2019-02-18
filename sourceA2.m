%Εξωτερική Πηγή A με δεύτερης τάξης επέκταση.

clear
clc

alphabet = ['a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z'];
p = [8.167/100,1.492/100,2.782/100,4.253/100,12.702/100,2.228/100,2.015/100,6.094/100,6.966/100,0.153/100,0.772/100,4.025/100,2.406/100,6.749/100,7.507/100,1.929/100,0.095/100,5.987/100,6.327/100,9.056/100,2.758/100,0.978/100,2.361/100,0.150/100,1.974/100,0.074/100];

%Για τη δεύτερης τάξης επέκταση, θέλουμε όλους τους πιθανούς συνδιασμούς
%ανά δύο. Αυτό δίνεται από το αποτέλεσμα της combnk συν τα αντίστροφά + το
%καθένα με τον εαυτό του.

first  = combnk(alphabet,2);
second = fliplr(combnk(alphabet,2));
alphabet = [first;second];
for i  = 1:26
    alphabet = [alphabet ;[i,i]];
end

%new possibilities vector
newp = zeros(length(alphabet),1);

for i=1:length(alphabet)
    newp(i) = p(alphabet(i,1)) * p(final(i,2));
end
p = newp';

sourceA = randsrc(1,10000,[alphabet; p]);

%Dictionary creation
[dict, avglen] = myHuffmandict (alphabet, p);

%we want sig/input in cell array
sig = cellstr(sourceA');

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

disp('Complete')
