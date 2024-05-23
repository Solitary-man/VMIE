P = imread("image/bridge512.bmp");
P = double(P);  % plain image
C = imread("image/Boat512.bmp");
C = double(C);  % carriager image
[H, N] = size(P);
%Step1 Associated with the plain image(Last used)
Message = hash(P, 'SHA-256');  %输出为64位的十六进制数

m1 = hex2dec(Message(1:4))   + hex2dec(Message(5:8))   + hex2dec(Message(9:12))  + hex2dec(Message(13:16));
m2 = hex2dec(Message(17:20)) + hex2dec(Message(21:24)) + hex2dec(Message(25:28)) + hex2dec(Message(29:32));
m3 = hex2dec(Message(33:36)) + hex2dec(Message(37:40)) + hex2dec(Message(41:44)) + hex2dec(Message(45:48));
m4 = hex2dec(Message(49:52)) + hex2dec(Message(53:56)) + hex2dec(Message(57:60)) + hex2dec(Message(61:64));

c1 = RSA(m1, "encrypt");
c2 = RSA(m2, "encrypt");
c3 = RSA(m3, "encrypt");
c4 = RSA(m4, "encrypt");

%密钥流生成
x0=cos((floor(c1./m1)-c1./m1)*pi);
y0=cos((floor(c2./m2)-c2./m2)*pi);
z0=cos((floor(c3./m3)-c3./m3)*pi);
T = mod(floor(c1./m1)+floor(c2./m2)+floor(c3./m3)+floor(c4./m4),1000);
[X,Y,Z]=NewCheyLCM(x0,y0,z0,T,H*N);