function A = IDiffusion(B,X)
%IDiffusion 扩散 B待逆扩散矩阵 X与A长度一致的混沌序列
%   此处显示详细说明
[H,N]=size(B);

A=zeros(H,N);

X1=mod(floor(X*10^12),256);

A(1) = mod(B(1)-X(1),256);

for i=2:H*N
    
    A(i)=mod(B(i)-X1(i)-B(i-1),256);
    
end

end

