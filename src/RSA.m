function OUT = RSA(IN,method)
%UNTITLED3 RSA 加密算法
%   选定 p q
p=7333;
q=6211;
n=p*q;
Q=(p-1)*(q-1);
e=263;
if method == "encrypt"
    %利用快速模指数算法进行模运算
    OUT=QuickMod(IN,e,n);
    % 这里是利用推广的欧里几得算法求e的乘法逆元 
elseif method == "decrypt"
    d=euclid(Q,e);
    OUT=QuickMod(IN,d,n);
else
    fprintf("RSA Input Method Error");
end

