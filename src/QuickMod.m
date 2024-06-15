function result=QuickMod(a,m,n)
%%快速指数算法 a^m mod n
bin_m=dec2bin(m);           %把m换成二进制数，dec2bin函数：把一个十进制数转换成一个字符串形式的二进制数。
length_e=length(bin_m);     %二进制数e的长度
x=0;%用于记录明文乘几次幂
c=1;%记录明文转密文后的结果
%此循环是为不超出计算机数值范围
for i=1:1:length_e
    x=2*x;
    c=mod(c*c,n);
    if bin_m(i)=='1'
       x=x+1;
       c=mod(c*a,n);    
    end
end
result=c;
end
