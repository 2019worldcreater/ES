function out=backward_diffusion(I,X)
[M,N]=size(I);
S=reshape(X,M,N);
out(M,N)=mod(I(M,N)+S(M,N),256);
for j=N-1:-1:1
     out(M,j)=mod(I(M,j)+S(M,j)+out(M,j+1),256);
end
for i=M-1:-1:1
    out(i,N)=mod(I(i,N)+S(i,N)+out(i+1,N),256);
end
for i=M-1:-1:1
    for j=N-1:-1:1
        out(i,j)=mod(I(i,j)+S(i,j)+out(i,j+1)+out(i+1,j),256);
    end
end