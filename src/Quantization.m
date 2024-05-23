function [B,Max,Min] = Quantization(A,L)
%Quantization 将矩阵A量化为0~L范围的整数值
%   量化矩阵
Max = max(max(A));
Min = min(min(A));
% L=floor(Max-Min);
B = floor((A-Min)*L/(Max-Min));
end

