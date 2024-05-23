function result = IQuantization(A,Max,Min,L)
%UNTITLED4 此处显示有关此函数的摘要
%   还原量化结果
% L=floor(Max-Min);
result = A*(Max-Min)/L+Min;
end

