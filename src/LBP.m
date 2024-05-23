function B = LBP(A,r)
%LBP 根据图像A的纹理进行分类，输出纹理矩阵B
%   根据利用阈值Ts来对图像纹理进行划分
bitvlue=[128,64,32;1,0,16;2,4,8];
[M,N]=size(A);
% 混沌序列
[X,Y,Z]=NewCheyLCM(0.2,0.3,0.5,500,M*N);
U = X+Y+Z;
Ts = 30+mod(U(r),20);
B=zeros(M,N);
for i=1:M-2
    for j=1:N-2
        submatrix = A(i:i+2, j:j+2);
        % 获取九宫格的中心值  
        center = submatrix(2, 2);  
        % 获取九宫格边缘的8个值差值的绝对值
        edges = abs(submatrix-center);
        edges(2,2)=0;
        bitnum=double(edges>Ts);
        %转换为十进制
        B(i+1,j+1)=SUM(bitnum.*bitvlue);
    end
end

