function lpd1=zeropading(lpd,L1)
L=length(lpd);
Z0=zeros(L1,1);
Z0(1:L,1)=lpd;
lpd1=Z0;