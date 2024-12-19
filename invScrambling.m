function [T]=invScrambling(input,Seq)
[m,n]=size(input);
[~,num]=sort(Seq);
scrambled=zeros(m,n);
for i=1:m*n
    scrambled(num(i))=input(i);
end
T=scrambled;
