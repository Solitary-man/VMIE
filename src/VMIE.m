function [CICS,DI,RI] = VMIE(P,C,varargin)
%VMIE 输入秘密图像P 载体图像C 密钥Key
%   此处显示详细说明

addpath('E:\BaiduSyncdisk\Matlab')
addpath('E:\BaiduSyncdisk\Matlab\VMIE')
addpath('C:\Users\Liushoukang\Desktop\VMIE\src')
addpath('E:\BaiduSyncdisk\Matlab\2DCS-ETC-master\TDCS-ETC\WaveletSoftware\')
addpath('E:\BaiduSyncdisk\Matlab\2DCS-ETC-master\TDCS-ETC\mywork')

tic
P = double(P);  % Plain image
C = double(C);  % carriager image
[H, N] = size(P);
%Step1 Associated with the plain image(Last used)
Pmes = LBP(P,30);
Message = hash(Pmes, 'SHA-256');  %输出为64位的十六进制数
% 初始秘钥
alpha1=1.3;
alpha2=90;
alpha3=-0.9;

m1 = hex2dec(Message(1:4))   + hex2dec(Message(5:8))   + hex2dec(Message(9:12))  + hex2dec(Message(13:16));
m2 = hex2dec(Message(17:20)) + hex2dec(Message(21:24)) + hex2dec(Message(25:28)) + hex2dec(Message(29:32));
m3 = hex2dec(Message(33:36)) + hex2dec(Message(37:40)) + hex2dec(Message(41:44)) + hex2dec(Message(45:48));
m4 = hex2dec(Message(49:52)) + hex2dec(Message(53:56)) + hex2dec(Message(57:60)) + hex2dec(Message(61:64));

c1 = RSA(m1, "encrypt");
c2 = RSA(m2, "encrypt");
c3 = RSA(m3, "encrypt");
c4 = RSA(m4, "encrypt");

%密钥流生成
x0=cos((floor(c1./m1)-c1./m1+alpha1*alpha2)*pi);
y0=cos((floor(c2./m2)-c2./m2+alpha2*alpha3)*pi);
z0=cos((floor(c3./m3)-c3./m3+alpha3*alpha1)*pi);
T = mod(floor(c1./m1)+floor(c2./m2)+floor(c3./m3)+floor(c4./m4)+floor(sin(alpha1*alpha2*alpha3*pi)),1000);
[X,Y,Z]=NewCheyLCM(x0,y0,z0,T,H*N);

CR=0.5;  

Phi1=hadamard(H);
Phi2=hadamard(H);

Rx1=X(1:H*CR);Rx2=X(1:N);
Ry1=Y(1:H*CR);Ry2=Y(1:N);

[~,Rx1Index]=sort(Rx1);
[~,Rx2Index]=sort(Rx2);
[~,Ry1Index]=sort(Ry1);
[~,Ry2Index]=sort(Ry2);

 [~,Index]=sort(Z(1:H*N*CR*CR));

Phi1=Phi1(Rx1Index,Rx2Index);
Phi2=Phi2(Ry1Index,Ry2Index);

RBI=Quantization(Z,255);

RBI=reshape(S(RBI,H*N),H,N);
 
[Temp,Max,Min]=CS(P,Phi1,Phi2,Index,RBI);

% 对Temp的内容名感性进行分散，这样保证对处理过的图像进行攻击对原图像的影响降到最低

Temp1=Scramble(Index,Temp);

Temp2=Diffusion(Temp1,X);


DI = Temp2;

C1=EmbedofIL2K(double(Temp2),C);

if nargin >= 3  
    if nargin == 3
        sp = varargin{1}; 
        C1=imnoise(uint8(C1),"salt & pepper",sp);
%     elseif nargin == 4
%         num=varargin{1}; 
%         delta=varargin{2};  
%         [X,Y,Z,T]=KeyGen(P,alpha1,alpha2,alpha3);
    elseif nargin == 5  
        t=varargin{1}; 
        v=varargin{2}; 
        cs=varargin{3}; 
        C1((1+t):(t+cs),(v+1):(v+cs))=0;
    end
end
toc
CICS=C1;
%% 解密
tic

Temp_extract=double(ExtractofIL2K(double(C1)));

Temp_extract1=IDiffusion(Temp_extract,X);

Temp_extract2=Unscramble(Index,Temp_extract1);

RI=ICS(Temp_extract2,Max,Min,X,Y,Z);

toc
end

