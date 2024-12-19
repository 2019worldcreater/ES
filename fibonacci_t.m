function f=fibonacci_t(I,r,s)
[m,n]=size(I);
if n~=m 
    error('不是方阵'); 
    return 
end 
% a = zeros(m,n);
if s==0 
    for k=1:r
        for i=1:m 
            for j=1:n 
                a(i,j)=I(mod(i+j,m)+1,mod(i,n)+1);
            end 
        end 
	I=a; 
    end 
	f=I; 
else 
    for k=1:r
        for i=1:m 
            for j=1:n 
                a(mod(i+j,m)+1,mod(i,n)+1)=I(i,j);
            end 
        end 
	I=a; 
    end 
	f=I; 
end
