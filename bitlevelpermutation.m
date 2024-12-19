function out=bitlevelpermutation(Input,X11,X12)
[N,~]=size(Input);
out1=zeros(N,16);
for i=1:N
    out1(i,:)=circshift(Input(i,:),X11(i),2);
end
out2=zeros(N,16);
for j=1:16
    out2(:,j)=circshift(out1(:,j),X12(j),1); 
end

real=zeros(N,1);
imag=zeros(N,1);
for k=1:N
    real(k,1)=base_convert(out2(k,1:8), 1, 8);
    imag(k,1)=base_convert(out2(k,9:16), 1, 8);
end

out=real+1j*imag;
