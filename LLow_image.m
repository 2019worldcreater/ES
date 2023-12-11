function [A,B,C]=LLow_image(I1,I2,I3,I4,I5,I6,I7,I8,I9,I10,I11,I12,lpd,hpd)
L=length(I1);
A=zeros(L,L);
B=zeros(L,L);
C=zeros(L,L);

[LL1,LH1,HL1,HH1]=ImageDWT(I1,lpd,hpd);
[LL2,LH2,HL2,HH2]=ImageDWT(I2,lpd,hpd);
[LL3,LH3,HL3,HH3]=ImageDWT(I3,lpd,hpd);
[LL4,LH4,HL4,HH4]=ImageDWT(I4,lpd,hpd);

[LL5,LH5,HL5,HH5]=ImageDWT(I5,lpd,hpd);
[LL6,LH6,HL6,HH6]=ImageDWT(I6,lpd,hpd);
[LL7,LH7,HL7,HH7]=ImageDWT(I7,lpd,hpd);
[LL8,LH8,HL8,HH8]=ImageDWT(I8,lpd,hpd);

[LL9,LH9,HL9,HH9]=ImageDWT(I9,lpd,hpd);
[LL10,LH10,HL10,HH10]=ImageDWT(I10,lpd,hpd);
[LL11,LH11,HL11,HH11]=ImageDWT(I11,lpd,hpd);
[LL12,LH12,HL12,HH12]=ImageDWT(I12,lpd,hpd);

A=[LL1,LL2;LL3,LL4];
B=[LL5,LL6;LL7,LL8];
C=[LL9,LL10;LL11,LL12];