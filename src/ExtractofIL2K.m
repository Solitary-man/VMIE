function A = ExtractofIL2K(I)
%ExtractofIL2K 2K校正提取算法
%   此处显示详细说明
% 提取嵌入信息
[cA, cH, cV, cD] = IWT(I);
cH=cH+512;
cV=cV+512;
cD=cD+512;
% disp(MAX(cD));
% disp(MIN(cD));
% disp(SUM(cD));
[H,N]=size(cH);

A=zeros(H*N,1);

A=mod(abs(cA),2)*2^7+mod(abs(cH),2^2)*2^5+mod(abs(cV),2^2)*2^3+mod(abs(cD),2^3);

A=uint8(reshape(A,H,N));

end


