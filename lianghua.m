function H = lianghua(I,mx,mn)

[M,N] = size(I);
H = zeros(M,N);

for i = 1:M
    for j = 1:N
        H(i,j) = (I(i,j) - mn)/(mx-mn);
        H(i,j) = double(H(i,j)*65535);
    end
end