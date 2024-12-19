function out=ibitlevelpermutation(Input,X11,X12)
N=length(Input);
data1=zeros(N,8);
data2=zeros(N,8);
for i=1:N
    data1(i,:)=base_convert(real(Input(i,:)), 8, 1);
    data2(i,:)=base_convert(imag(Input(i,:)), 8, 1);
end
data3=[data1,data2];

out1=zeros(N,16);
for j=1:16
    out1(:,j)=circshift(data3(:,j),-X12(j),1); 
end

out2=zeros(N,16);
for i=1:N
    out2(i,:)=circshift(out1(i,:),-X11(i),2); 
end
out = out2;
