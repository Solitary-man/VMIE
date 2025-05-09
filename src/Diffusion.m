function B = Diffusion(A,X)
%Diffusion 扩散 A待扩散矩阵 X与A长度一致的混沌序列
%   此处显示详细说明
[H,N]=size(A);

B=A;

X1=mod(floor(X*10^12),256);

B(1)=mod(A(1)+X1(1),256);

for i=2:H*N
    
    B(i)=mod(A(i)+X1(i)+B(i-1),256);
    
end
end

