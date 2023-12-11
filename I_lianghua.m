function H = I_lianghua(I,mx,mn)
[M,N] = size(I);
H = zeros(M,N);

for i = 1:M
    for j = 1:N
      I(i,j) =double(I(i,j)/double(65535));
        H(i,j) =I(i,j) *(mx-mn)+mn;
    end
end