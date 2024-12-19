function I=igravitydiffusion(g,x,y,z,v,c)
[M,N]=size(c);
I=zeros(M,N);
temp=zeros(M,N);
for i=1:M
    for j=1:N
        temp(i,j)=mod(round(g*(x*y*i^3+y*z*j^3+x*y*z)/((x-i)^2+((y-j)^2+z*z))),256);
    end
end
I(1,1)=bitxor(bitxor(c(1,1),temp(1,1)),v);
for col=2:N
    I(1,col)=bitxor(bitxor(c(1,col),temp(1,col)),c(1,col-1));
end
for row=2:M
    I(row,1)=bitxor(bitxor(c(row,1),temp(row,1)),c(row-1,1));
end
for row=2:M
    for col=2:N
        I(row,col)=bitxor(bitxor(bitxor(c(row,col),temp(row,col)),c(row-1,j)),c(row,col-1));
    end
end
