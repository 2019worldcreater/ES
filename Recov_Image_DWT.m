function [Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12]=Recov_Image_DWT(A,B,C,lpr,hpr)
 L=length(A);
 LH1=zeros(L/2,L/2);
 HL1=zeros(L/2,L/2);
 HH1=zeros(L/2,L/2);

 Y1=iImage_iDWT(A(1:L/2,1:L/2),LH1,HL1,HH1,lpr,hpr);
 Y2=iImage_iDWT(A(1:L/2,1+L/2:end),LH1,HL1,HH1,lpr,hpr);
 Y3=iImage_iDWT(A(L/2+1:end,1:L/2),LH1,HL1,HH1,lpr,hpr);
 Y4=iImage_iDWT(A(L/2+1:end,L/2+1:end),LH1,HL1,HH1,lpr,hpr);

 Y5=iImage_iDWT(B(1:L/2,1:L/2),LH1,HL1,HH1,lpr,hpr);
 Y6=iImage_iDWT(B(L/2+1:end,1:L/2),LH1,HL1,HH1,lpr,hpr);
 Y7=iImage_iDWT(B(1:L/2,L/2+1:end),LH1,HL1,HH1,lpr,hpr);
 Y8=iImage_iDWT(B(L/2+1:end,L/2+1:end),LH1,HL1,HH1,lpr,hpr);
 
 Y9=iImage_iDWT(C(1:L/2,1:L/2),LH1,HL1,HH1,lpr,hpr);
 Y10=iImage_iDWT(C(L/2+1:end,1:L/2),LH1,HL1,HH1,lpr,hpr);
 Y11=iImage_iDWT(C(1:L/2,L/2+1:end),LH1,HL1,HH1,lpr,hpr);
 Y12=iImage_iDWT(C(L/2+1:end,L/2+1:end),LH1,HL1,HH1,lpr,hpr);