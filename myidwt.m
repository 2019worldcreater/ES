function y = myidwt(cA,cD,lpr,hpr)
lca=length(cA); 	
lcd=length(cD);
L=length(lpr);
L1=length(cA);
lpd1=zeropading(lpr,L1);
hpd1=zeropading(hpr,L1);

while (lcd)>=(lca)	 
  upl=upspl(cA); 
  cvl=cconv(upl,lpr,length(upl));
  cD_up=cD(lcd-lca+1:lcd); 
  uph=upspl(cD_up);
  cvh=cconv(uph,hpr,length(uph));
  cA=cvl+cvh;	
  cA=circshift(cA',-7);
  cD=cD(1:lcd-lca);	
  lca=length(cA);
  lcd=length(cD);
end		
y=cA';

function y1=upspl(x)
N=length(x);
M=2*N;
y1 = zeros(1,M);
for i=1:M
  if mod(i,2)
    y1(i)=x((i+1)/2);
  else
    y1(i)=0;
  end
end 