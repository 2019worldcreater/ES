function [Y1]=iImage_iDWT(LL1,LH1,HL1,HH1,lpr,hpr)
 Size=length(LL1);
 iH1=zeros(Size,Size*2);
 iL1=zeros(Size,Size*2);
 Y1=zeros(Size*2,Size*2);

 for i=1:Size
     iH = myidwt( HL1(i,:),HH1(i,:),lpr,hpr);
     iL=  myidwt( LL1(i,:),LH1(i,:),lpr,hpr);
     iH1(i,:)=iH;
     iL1(i,:)=iL;
 end
 for i=1:Size*2     
     Y = myidwt(iL1(:,i),iH1(:,i),lpr,hpr);
     Y1(:,i)=Y;
 end