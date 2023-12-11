function T=scrambling(input,Seq)
[m,n]=size(input);
[~,num]=sort(Seq);
scrambled=zeros(m,n);
for i=1:m*n
    scrambled(i)=input(num(i));
end
T=scrambled;