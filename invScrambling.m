function [T]=invScrambling(input,seed)
[m,n]=size(input);
[y,num]=sort(seed);
scrambled=zeros(m,n);
for i=1:m*n
    scrambled(num(i))=input(i);
end
T=scrambled;