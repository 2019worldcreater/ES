function out=irandom_diffusion(a,b,inital2,c,ch1,ch2)
[M,N]=size(c);
out=zeros(M,N);
f0=floor(mod(mod(a*((1-sin(pi*inital2)+b)*(4*a*inital2*(1-inital2))*(1-4*a*inital2*(1-inital2))),1)*10^10,256));
chseq1=ch1'.*ch2;
chseq1=floor(mod(chseq1,256));
out(1,1)=bitxor(c(1,1),255-chseq1(1,1));
for i=2:M
    out(i,1)=bitxor(bitxor(c(i,1),chseq1(i,1)),f0);
end
for j=2:N
    out(1,j)=bitxor(bitxor(c(1,j),chseq1(1,j)),f0);
end
for i=2:M
    for j=2:N
        out(i,j)=bitxor(bitxor(bitxor(bitxor(c(i,j),chseq1(i,j)),c(i-1,j)),c(i,j-1)),f0);
    end
end