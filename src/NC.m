function result = NC(X,Y)
%NC 分析载体图像和密文图像之间的归一化相关系数（NC）
%   此处显示详细说明
result=sum(sum(X.*Y))/sum(sum(X.^2))^0.5/sum(sum(Y.^2))^0.5;
end

