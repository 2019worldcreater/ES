function out=ibackward_diffusion(c,X)
[M,N]=size(c);
S=reshape(X,M,N);
out(M,N)=mod(768+c(M,N)-S(M,N),256);
for j=N-1:-1:1
     out(M,j)=mod(512+c(M,j)-S(M,j)-c(M,j+1),256);
end
for i=M-1:-1:1
    out(i,N)=mod(512+c(i,N)-S(i,N)-c(i+1,N),256);
end

for i=M-1:-1:1
    for j=N-1:-1:1
        out(i,j)=mod(768+c(i,j)-S(i,j)-c(i,j+1)-c(i+1,j),256);
    end
end