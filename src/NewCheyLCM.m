function [x,y,z]=NewCheyLCM(x0,y0,z0,t,nn)
%UNTITLED2 新的3维离散混沌系统ILM
%   t为防止暂态效应抛弃数
%   nn为需要生成混沌序列的数量
r1 = 3.7028;
r2 = 0.0105;
r3 = 0.0126;
r4 = 3.5;

X(1) = x0;
Y(1) = y0;
Z(1) = z0;

for i = 1:nn+t  
    X(i+1)=sin((r1*X(i)*(1-X(i))+r2*X(i)*Y(i)^2+r3*Z(i)^3+cos(r4*acos(X(i))))*pi);
    Y(i+1)=sin((r1*Y(i)*(1-Y(i))+r2*Y(i)*Z(i)^2+r3*X(i)^3+cos(r4*acos(Y(i))))*pi);
    Z(i+1)=sin((r1*Z(i)*(1-Z(i))+r2*Z(i)*X(i)^2+r3*Y(i)^3+cos(r4*acos(Z(i))))*pi);
end

x= X(t+1:nn+t);  
y= Y(t+1:nn+t);
z= Z(t+1:nn+t);
end


