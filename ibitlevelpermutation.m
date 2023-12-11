function out=ibitlevelpermutation(Input,X11,X12);
[m,n]=size(Input);
int16Scram=reshape(Input,m*n,1);
data1=zeros(m*n,8);
data2=zeros(m*n,8);
data3=zeros(m*n,16);

for i21=1:m*n
    data1(i21,:)=base_convert(real(int16Scram(i21,:)), 8, 1);
    data2(i21,:)=base_convert(imag(int16Scram(i21,:)), 8, 1);
end
data3=[data1,data2];

out1=zeros(m*n,16);
for j=1:12
    out1(:,j)=circshift(data3(:,j),-X12(j),1); 
end
for j=13:16
    out1(:,j)=circshift(data3(:,j),-X12(j),1);
end


out2=zeros(m*n,16);
for i=1:m*n
    out2(i,:)=circshift(out1(i,:),-X11(i),2); 
end
out3=zeros(m*n,1);
for k=1:m*n
   % out3(k,:)=numbin2dec(out2(k,:));
     out3(k,1)=base_convert(out2(k,:), 1, 16);
end
out=reshape(out3,256,256*3);