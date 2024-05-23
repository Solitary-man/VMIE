function B = threMat(A,Ts)
%threMat 阈值函数 将矩阵中小于Ts的值设为0
%   根据输入矩阵A与阈值Ts得到输出矩阵B

% 创建一个新的矩阵B，其元素与A相同  
B = A;  
% 使用逻辑索引找到所有小于Ts的元素，并将它们设为0  
B(B < Ts) = 0;  
end