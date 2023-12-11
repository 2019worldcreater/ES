function [LL1,LH1,HL1,HH1]=ImageDWT(image,lpd,hpd)
 Size=length(image);
 
 L=zeros(Size/2,Size);
 H=zeros(Size/2,Size);
 LL1=zeros(Size/2,Size/2);
 LH1=zeros(Size/2,Size/2);
 HL1=zeros(Size/2,Size/2);
 HH1=zeros(Size/2,Size/2);

for i=1:Size
    [cA,cD] = mydwt(image(:,i),lpd,hpd,1);
    L(:,i)=cA;
    H(:,i)=cD;
end  
for i=1:Size/2
    [LL,LH] = mydwt(L(i,:)',lpd,hpd,1);
    [HL,HH] = mydwt(H(i,:)',lpd,hpd,1);
    LL1(i,:)=LL;
    LH1(i,:)=LH;
    HL1(i,:)=HL;
    HH1(i,:)=HH;
end