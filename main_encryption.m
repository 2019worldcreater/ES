clear
clc
close all
addpath('.\pics');

%% 读取图像 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fileN = 'cc.png'; % 保存密文图像的名称
jiemi = 1; % 是否解密

I1=imread('couple.tiff');
J11=double(I1);
JR1=J11(:,:,1);JG1=J11(:,:,2);JB1=J11(:,:,3);  %三个颜色分量
% JR1(2,3)=JR1(2,3)+1;

I2=imread('house.tiff'); 
J11=double(I2);
JR2=J11(:,:,1);JG2=J11(:,:,2);JB2=J11(:,:,3);  

I3=imread('peppers.tif');
J11=double(I3);
JR3=J11(:,:,1);JG3=J11(:,:,2);JB3=J11(:,:,3); 

I4=imread('tree.tiff');
J11=double(I4);
JR4=J11(:,:,1);JG4=J11(:,:,2);JB4=J11(:,:,3);  

tic;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('开始加密');
%% 秘钥生成 %%%%%%%%%%%%%%%%%%%%%
P = bitxor(bitxor(bitxor(I1,I2),I3(:,:,1:3)),I4);
P_sum = sum(P(:));
hashv = HashFunction(P_sum,'SHA-512');
hashv = hashv(4:509);
x1 = bin2dec(hashv(1:46)) * 10^(-22);
x2 = bin2dec(hashv(47:92)) * 10^(-22);
x3 = bin2dec(hashv(93:138)) * 10^(-22);
x4 = bin2dec(hashv(139: 184)) * 10^(-22);
r1 = bin2dec(hashv(185: 230)) * 10^(-22);
r2 = bin2dec(hashv(231: 276)) * 10^(-22);
r3 = bin2dec(hashv(277: 322)) * 10^(-22);
aerfa = bin2dec(hashv(323:368)) * 10^(-22);
lambda = bin2dec(hashv(369:414)) * 10^(-22);
g = bin2dec(hashv(415:460)) * 10^(-22);
v = mod(bin2dec(hashv(461:506)), 256);
%% 加密开始 %%%%%%%%%%%%%%%%%%%%%%%%%
%% 产生混沌序列 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
M = 256; N=256;
F = JSMP1(x1,r1,6*M*N+16);
X11 = F(1:3*M*N);
X12 = F(3*M*N+1:6*M*N);
X13 = F(6*M*N+1:6*M*N+16);
F = JSMP1(x2,r2,6*M*N+2*M+3*N);
X14 = F(1:6*M*N);
X15 = F(6*M*N+1:6*M*N+2*M);
X16 = F(6*M*N+2*M+1:6*M*N+2*M+3*N);
F = JSMP1(x3,r3,6*M*N+2*M+3*N);
X17 = F(1:6*M*N);
X18 = F(6*M*N+1:6*M*N+2*M+3*N);

%% DWT 压缩 %%%%%%%%%%%%%
[lpd,hpd,lpr,hpr]=wfilters('db4');
[A,B,C]=LLow_image(JR1,JR2,JR3,JR4,JG1,JG2,JG3,JG4,JB1,JB2,JB3,JB4,lpd,hpd);
Rcompre=A;
Gcompre=B;
Bcompre=C;
%% 斐波那契变换  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RP1=fibonacci_t(Rcompre,150,0);
GP1=fibonacci_t(Gcompre,150,0);
BP1=fibonacci_t(Bcompre,150,0);
%% RGB全部同时置乱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RGB=[RP1,GP1,BP1]; 
RGB1=reshape(RGB,256*768,1);
Scram=reshape(scrambling(RGB1,X11),256,256*3);
%% 比特级扩展 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
mx=max(max(Scram));mn=min(min(Scram));
H = lianghua(double(Scram),mx,mn);
int16Scram=fix(H);
%% 第一轮比特级置乱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data_bit_scram=bitlevelpermutation(int16Scram,X12,X13);
%% 向后扩散 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
Data_bit_scram1=reshape(Data_bit_scram,256,256*3);
P1=[real(Data_bit_scram1);imag(Data_bit_scram1)];
P2=backward_diffusion(P1,X14);
%% 第二轮比特级置乱 Zigzag %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P3=P2(1:256,:)+1j*P2(1+256:512,:);
RP=P3(:,1:256); GP=P3(:,257:512); BP=P3(:,513:768);
RP2=zigzag(RP,0); GP2=zigzag(GP,0); BP2=zigzag(BP,0);
P4=[RP2,GP2,BP2];
P5=reshape(P4,256,768);
P6=[real(P5);imag(P5)];
%% 比特级随机扩散 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P7=random_diffusion(aerfa,lambda,x4,P6,X15,X16);
%% 第三轮比特级置乱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
P8=scrambling(P7,X17);
%% 改进的重力扩散 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1=X18(32); y1=X18(64); z1=X18(128);
P9=gravitydiffusion(g,x1,y1,z1,v,P8); 
%% 生成密文 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
RPCC1=uint8(P9(:,1:256)); GPCC1=uint8(P9(:,257:512)); BPCC1=uint8(P9(:,513:768));
cipher = cat(3,RPCC1,GPCC1,BPCC1);
toc
imwrite(cipher, fileN);

if jiemi == 0
    return;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 解密 % %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
fprintf('开始解密');
tic;
RPA1=RPCC1;
GPA1=GPCC1;
BPA1=BPCC1;
%% 利用接收的秘钥重新生成混沌序列 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
F = JSMP1(x1,r1,6*M*N+16);
X11 = F(1:3*M*N);
X12 = F(3*M*N+1:6*M*N);
X13 = F(6*M*N+1:6*M*N+16);
F = JSMP1(x2,r2,6*M*N+2*M+3*N);
X14 = F(1:6*M*N);
X15 = F(6*M*N+1:6*M*N+2*M);
X16 = F(6*M*N+2*M+1:6*M*N+2*M+3*N);
F = JSMP1(x3,r3,6*M*N+2*M+3*N);
X17 = F(1:6*M*N);
X18 = F(6*M*N+1:6*M*N+2*M+3*N);
%% 合并 %%%%%%%%%%%%%%%%%%%%%%%%%%%%
invP9=[RPA1,GPA1,BPA1];
%% 逆重力扩散 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
x1=X18(32); y1=X18(64); z1=X18(128); 
invP8=igravitydiffusion(g,x1,y1,z1,v,(round(invP9)));
%% 逆置乱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
invP7=invScrambling(invP8,X17);
%% 逆比特级随机扩散 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
invP6=irandom_diffusion(aerfa,lambda,x4,invP7,X15,X16);
%% 逆Zigzag %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
invP5=invP6(1:256,:)+1j*invP6(1+256:512,:);
invP4=reshape(invP5,1,196608);
invRP2=invP4(1,1:256*256); invGP2=invP4(1,1+256*256:256*256*2);
invBP2=invP4(1,1+256*256*2:256*256*3);
invRP=zigzag(invRP2,1);invGP=zigzag(invGP2,1);invBP=zigzag(invBP2,1);
%% 逆向后扩散 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
invP3=[invRP,invGP,invBP];
invP2=[real(invP3);imag(invP3)];
invP1=ibackward_diffusion(invP2,X14);
%% 逆bit级置乱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
invData_bit_scram1=invP1(1:256,:)+1j*invP1(1+256:512,:);
invData_bit_scram=reshape(invData_bit_scram1,256*768,1);
invint16Scram=ibitlevelpermutation(invData_bit_scram,X12,X13);
%% 逆比特级拓展 %%%%%%%%%%%%%%%%%%%
invScram=I_lianghua(double(invint16Scram),mx,mn);
%% 逆置乱 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
invRGB1=reshape(invScram,256*768,1);
invRGB=reshape(invScrambling(invRGB1,X11),256,768);
%% 逆斐波那契变换  %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
invRP1=invRGB(:,1:256);invGP1=invRGB(:,257:512); invBP1=invRGB(:,513:768);
invA=fibonacci_t(invRP1,150,1);
invB=fibonacci_t(invGP1,150,1);
invC=fibonacci_t(invBP1,150,1);
%% DWT解压缩 %%%%%%%%%%%%%%%%%%
[Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12]=Recov_Image_DWT(invA,invB,invC,lpr,hpr);
rec1 = cat(3,uint8(Y1),uint8(Y5),uint8(Y9));
rec2 = cat(3,uint8(Y2),uint8(Y7),uint8(Y11));
rec3 = cat(3,uint8(Y3),uint8(Y6),uint8(Y10));
rec4 = cat(3,uint8(Y4),uint8(Y8),uint8(Y12));

toc;

imwrite(uint8(rec1),'c1.png');
imwrite(uint8(rec2),'c2.png');
imwrite(uint8(rec3),'c3.png');
imwrite(uint8(rec4),'c4.png');