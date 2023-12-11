function out=bitlevelpermutation(Input,X11,X12)
[m,n]=size(Input);
int16Scram=reshape(Input,m*n,1);

data_10_to_2=zeros(m*n,16);

for ii=1:m*n
    data_10_to_2(ii,:)=base_convert(int16Scram(ii,:), 16, 1); %% 10进制转为16位二进制
end
out1=zeros(m*n,16);
for i=1:m*n
    out1(i,:)=circshift(data_10_to_2(i,:),X11(i),2);
end
out2=zeros(m*n,16);
for j=1:12
    out2(:,j)=circshift(out1(:,j),X12(j),1); 
end
for j=13:16
    out2(:,j)=circshift(out1(:,j),X12(j),1);
end

real=zeros(m*n,1);
imag=zeros(m*n,1);
for k=1:m*n
    real(k,1)=base_convert(out2(k,1:8), 1, 8);
    imag(k,1)=base_convert(out2(k,9:16), 1, 8);
end

out=real+1j*imag;