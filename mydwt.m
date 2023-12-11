function [cA,cD] = mydwt(x,lpd,hpd,dim)	%对x进行�?维离散小波分�?
%lpd：低通滤波器
%hpd：高通滤波器
%dim：小波分解级�?
%cA：平均部分的小波分解系数
%cD：细节部分的小波分解系数
cA=x;		
cD=[];
L=length(lpd);
L1=length(x);
lpd1=zeropading(lpd,L1);
hpd1=zeropading(hpd,L1);
for i=1:dim
 cvl=cconv(cA,lpd1,length(cA));
 dnl=downsample(cvl,2);
 cvh=cconv(cA,hpd1,length(cA)); 
 dnh=downsample(cvh,2); 
 cA=dnl;
 L=length(cA);
 cD=[cD,dnh]; 
end